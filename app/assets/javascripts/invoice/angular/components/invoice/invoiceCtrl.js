(function() {
  'use strict';
  angular.module('somsri.invoice.invoice', [
  ])
  .controller('invoiceCtrl', ['$scope', '$http', 'DEFAULT_INVOICE', 'DEFAULT_LOGO', 'LocalStorage', 'Currency', 'invoiceService', '$rootScope', function($scope, $http, DEFAULT_INVOICE, DEFAULT_LOGO, LocalStorage, Currency, service, $rootScope) {
    var ctrl = this;
    $rootScope.menu = "การเงิน"
    $rootScope.loadAndAuthorizeResource("invoice", function(){
      ctrl.title = 'Invoice';
       function isPaymentMethodMoreThanOne(){
         var count = 0;
         if(ctrl.datas.payment_method.is_cash){ count += 1; }
         if(ctrl.datas.payment_method.is_credit_card){ count += 1; }
         if(ctrl.datas.payment_method.is_cheque){ count += 1; }
         if(ctrl.datas.payment_method.is_transfer){ count += 1; }
         if(count > 1){
           return true;
         }else{
           return false;
         }
       }

      function initDatas(){
        if(!ctrl.datas) { ctrl.datas = {} }
        if(!ctrl.datas.parent) { ctrl.datas.parent = {} }
        if(!ctrl.datas.student) { ctrl.datas.student = {} }
      }

      function autoFillParent($item){
        if($item.parent_id){
          for(var i = 0;i < ctrl.parent_info.length; i++){
            if($item.parent_id == ctrl.parent_info[i].id){
              initDatas();
              if(!ctrl.datas.parent.full_name){
                ctrl.datas.parent.full_name = ctrl.parent_info[i].full_name;
              }
            }
          }
        }
      }

      function autoFillStudent($item){
        if($item.student_id){
          for(var i = 0;i < ctrl.student_info.length; i++){
            if($item.student_id == ctrl.student_info[i].id){
              initDatas();
              if(!ctrl.datas.student.full_name){
                ctrl.datas.student.full_name = ctrl.student_info[i].full_name;
              }
              if(!ctrl.datas.student.student_number){
                ctrl.datas.student.student_number = ctrl.student_info[i].student_number;
              }
            }
          }
        }
      }

      ctrl.submitAmountModal = function(){
        var cash_amount = ctrl.datas.payment_method.cash_amount || 0;
        var credit_card_amount = ctrl.datas.payment_method.credit_card_amount || 0;
        var transfer_amount = ctrl.datas.payment_method.transfer_amount || 0;
        var cheque_amount = ctrl.datas.payment_method.cheque_amount || 0;
        ctrl.invoiceTotal();
        if(cash_amount + credit_card_amount + transfer_amount + cheque_amount != ctrl.total){
          $('#confirm-amount-modal').modal('show');
        }else{
          $('#amount-modal').on('hidden.bs.modal', function () {
            ctrl.createInvoice();
          });
          $('#amount-modal').modal('hide');
        }
      }

      ctrl.createInvoice = function(){
        service.createInvoice(ctrl.datas).then(function(resp) {
          // Reset Value
          ctrl.datas = JSON.parse(JSON.stringify(DEFAULT_INVOICE))
          $rootScope.openSlip(resp.data.id);
        },function(resp) {

        });
      }

      ctrl.onSelectParent = function ($item) {
        autoFillStudent($item);
      };

      ctrl.onSelectStudentNumber = function ($item) {
        ctrl.datas.student.full_name = $item.full_name;
        autoFillParent($item);
      };

      ctrl.onSelectStudentFullName = function ($item) {
        ctrl.datas.student.student_number = $item.student_number;
        autoFillParent($item);
      };

      ctrl.onSelectLineItem = function ($item, $model) {
        $model.amount = $item.amount;
        ctrl.invoiceTotal();
      };

      // Adds an item to the invoice's items
      ctrl.addItem = function() {
        ctrl.datas.invoice.items.push({ amount:0, detail:"" });
        ctrl.invoiceTotal();
      }

      ctrl.cancel = function() {
      };

      ctrl.save = function() {
        if(isPaymentMethodMoreThanOne()){
          $('#amount-modal').modal('show');
        }else{
          ctrl.invoiceTotal();
          var pm = ctrl.datas.payment_method;
          if(pm.is_cash){
            pm.cash_amount = ctrl.total;
          }else if(pm.is_credit_card){
            pm.credit_card_amount = ctrl.total;
          }else if(pm.is_cheque){
            pm.cheque_amount = ctrl.total;
          }else if(pm.is_transfer){
            pm.transfer_amount = ctrl.total;
          }
          ctrl.createInvoice();
        }
      };

      // Remotes an item from the invoice
      ctrl.removeItem = function(item) {
        ctrl.datas.invoice.items.splice(ctrl.datas.invoice.items.indexOf(item), 1);
        ctrl.invoiceTotal();
      };

      // Calculates the sub total of the invoice
      ctrl.invoiceTotal = function() {
        var total = 0.00;
        angular.forEach(ctrl.datas.invoice.items, function(item, key){
          total += item.amount;
        });
        ctrl.total = total;
      };

      ctrl.validatePaymentMethod = function(){
        var pm = ctrl.datas.payment_method;
        if(pm){
          return pm.is_cash || pm.is_credit_card || pm.is_cheque || pm.is_transfer;
        }else{
          return false;
        }

      };

      (function init() {
        // Attempt to load invoice from local storage
        service.newInvoice().then(function(resp) {
          ctrl.invoice_number = resp.data.last_invoice_id + 1;
          ctrl.student_info = resp.data.student_info;
          ctrl.parent_info = resp.data.parent_info;
          ctrl.line_items_info = resp.data.line_items_info;
          ctrl.grades = resp.data.grades;

          var nowDate = new Date();
          // Clone to prevent the reset value
          ctrl.datas = JSON.parse(JSON.stringify(DEFAULT_INVOICE))
          ctrl.datas.invoice.semester = resp.data.current_semester;
          ctrl.datas.payment_method = {};
          ctrl.datas.payment_method.is_cash = false;
          ctrl.datas.payment_method.is_credit_card = true;
          ctrl.datas.payment_method.is_transfer = false;
          ctrl.datas.payment_method.is_cheque = false;
          ctrl.datas.invoice.school_year = resp.data.school_year;
          ctrl.datas.invoice.grade_name = resp.data.grades[0];

          ctrl.date_display = nowDate.getDate() + "/" + (nowDate.getMonth() + 1) + "/" + (nowDate.getFullYear() + 543);
          ctrl.availableCurrencies = Currency.all();
          ctrl.invoiceTotal();
        },function(resp) {
        });

      })()

      // Runs on document.ready
      angular.element(document).ready(function () {
        // Set focus
        document.getElementById('student_code').focus();
        $('.btn.btn-grades').find('option').first().remove();
      });
    });
  }]);
})();
