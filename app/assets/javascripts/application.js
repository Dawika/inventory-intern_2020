// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require selectize.min
//= require angular
//= require tether
//= require bootstrap
//= require dropzone
//= require rails.validations
//= require rails.validations.simple_form
//= require modal_clientside_validation
//= require angular-bootstrap
//= require angular-ui-router
//= require angular-ui-router.stateHelper
//= require moment
//= require angular-moment
//= require ocLazyLoad/dist/ocLazyLoad.min
//= require angular-input-masks
//= require angular-xeditable/dist/js/xeditable
//= require bootstrap-table
//= require extensions/bootstrap-table-multiple-sort.js
//= require angular-ui-bootstrap-fontawesome
//= require extensions/bootstrap-table-export.js
//= require ng-file-upload-shim
//= require ng-file-upload
//= require_tree .

function CreateToken(form) {
  // Serialize the form fields into a valid card object.
  var card = {
    "name": form.find("[data-omise=holder_name]").val(),
    "number": form.find("[data-omise=number]").val(),
    "expiration_month": form.find("[data-omise=expiration_month]").val(),
    "expiration_year": form.find("[data-omise=expiration_year]").val(),
    "security_code": form.find("[data-omise=security_code]").val()
  };
  // Send a request to create a token then trigger the callback function once
  // a response is received from Omise.
  //
  // Note that the response could be an error and this needs to be handled within
  // the callback.
  Omise.createToken("card", card, function(statusCode, response) {
    if (card.name == '' && card.expiration_month == '' && card.security_code == '') {
      $("#token_errors").html('<div class="alert alert-danger" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Please fill out this field.</div>');
    }
    if (response.object == "error") {
      // Display an error message.
      var message_text = "SET YOUR SECURITY CODE CHECK FAILED MESSAGE";
      if (response.object == "error") {
        message_text = response.message;
      }
      $("#token_errors").html('<div class="alert alert-danger" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + message_text + '</div>');
      $('#myModal').modal('hide');

      // Re-enable the submit button.
      form.find("input[type=submit]").prop("disabled", false);
    } else {
      // Then fill the omise_token.
      form.find("[name=omise_token]").val(response.id);

      // Remove card number from form before submiting to server.
      form.find("[data-omise=number]").val("");
      form.find("[data-omise=security_code]").val("");

      // submit token to server.
      form.get(0).submit();
    };
  });
}