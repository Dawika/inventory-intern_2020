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


function showDropdown(id) {
  ul = $('#' + id)
  ul.hasClass('open') ? ul.removeClass('open') : ul.addClass('open')
}

function validateUniqueness(url, id) {
  input = $('#' + id);
  $.ajax({
    url: url,
    dataType: 'json',
    data: { email: input.val() },
    success: function(response) {
      if (response.status == false) {
        input.addClass('is-uniqueness');
        inValid(id, response.message)
      } else {
        input.removeClass('is-uniqueness');
        valid(id)
      }
    }
  });
}

function validateUserBySubdomain(url, id) {
  input = $('#' + id);
  form = input.closest('form')
  $.ajax({
    url: url,
    dataType: 'json',
    data: { email: input.val() },
    success: function(response) {
      if (response.status == false) {
        input = $('#' + id)
        $('.' + id + ':first .invalid-feedback').remove();
        input.removeClass('is-valid');
        input.addClass('is-invalid');
        $('.' + id + ':first').append('<div class="invalid-feedback text-right" style="display:block;">' + response.message + '</div>');
        form.find(':submit').attr('disabled', true);
      } else {
        $('.' + id + ':first .invalid-feedback').remove();
        input.removeClass('is-invalid');
        input.addClass('is-valid');
        form.find(':submit').attr('disabled', false);
      }
    }
  });
}

function validateUniqueness2(url, id) {
  input = $('#' + id);
  $.ajax({
    url: url,
    dataType: 'json',
    data: { subdomain_name: input.val() },
    success: function(response) {
      if (response.status == false) {
        input.addClass('is-uniqueness');
        inValid(id, response.message)
      } else {
        input.removeClass('is-uniqueness');
        valid(id)
      }
    }
  });
}

function inValid(id, errorMessage) {
  input = $('#' + id)
  $('.' + id + ':first .invalid-feedback').remove();
  input.removeClass('is-valid');
  input.addClass('is-invalid');
  $('.' + id + ':first').append('<div class="invalid-feedback text-right" style="display:block;">' + errorMessage + '</div>');
  disabledOrEnableSubmitForm(input.closest('form'), input.hasClass('validate-sign-up'));
}

function valid(id) {
  input = $('.required#' + id)
  if (!input.hasClass('is-uniqueness')) {
    $('.' + id + ':first .invalid-feedback').remove();
    input.removeClass('is-invalid');
    input.addClass('is-valid');
    disabledOrEnableSubmitForm(input.closest('form'), input.hasClass('validate-sign-up'));
  }
}

function disabledOrEnableSubmitForm(form, enableSubmit) {
  // disabled buntton save when input validate blank
  if (form.find('input.required.is-valid').length === form.find('input.required').length) {
    form.find(':submit').attr('disabled', false);
  } else {
    form.find(':submit').attr('disabled', true);
  }
  if (enableSubmit) {
    enableButtonFormSchool('new_school', 'new_modal');
  }
}

function enableButtonFormAdmin(formID, id) {
  form = $('#' + formID);
  button = $('#' + id);
  if (form.find('input.validate-sign-in.is-valid').length === form.find('input.validate-sign-in.required').length) {
    button.attr('disabled', false);
  } else {
    button.attr('disabled', true);
  }
}

function enableButtonFormSchool(formID, id) {
  form = $('#' + formID);
  button = $('#' + id);
  if (form.find('input.validate-sign-up.is-valid').length === form.find('input.validate-sign-up.required').length) {
    $('#new_modal').removeClass('btn-bg-grey')
    $('#new_modal').addClass('btn-bg-blue')
    button.attr('disabled', false);
  } else {
    $('#new_modal').removeClass('btn-bg-blue')
    $('#new_modal').addClass('btn-bg-grey')
    button.attr('disabled', true);
  }
}

function showNewSchool() {
  $('#formSingUp').hide();
  $('#formSchool').show();
}

function changeLogo(event, img_logo) {
  logo = URL.createObjectURL(event.target.files[0]);
  console.log(logo)
  $('#' + img_logo).attr('src', logo);
  FileType = event.target.files[0]
  FileSize = event.target.files[0].size / 1024 / 1024; // in MB
  error = $('#errorMessage')
  requireimg = $('#requireimg')
  input = $('.required#school_logo')
  if (FileType.name.match(/\.(jpg|jpeg|png)$/)) {
    if (FileSize > 2) {
      $('#' + img_logo).attr('src', 'http://chittagongit.com/images/icon-file-size/icon-file-size-10.jpg');
      error.show()
      requireimg.hide()
      inValid('school_logo', '')
      $('#img-sc-true').addClass('hide');
      $('#img-sc-false').removeClass('hide');
      error.html('*ไฟล์รูปภาพขนาดเกิน 2 Mb')
    } else {
      error.hide()
      requireimg.hide()
      valid('school_logo')
      $('#img-sc-true').removeClass('hide');
      $('#img-sc-false').addClass('hide');
    }
  } else {
    $('#' + img_logo).attr('src', 'http://chittagongit.com/images/icon-file-size/icon-file-size-10.jpg');
    error.show()
    requireimg.hide()
    inValid('school_logo', '')
    $('#img-sc-true').addClass('hide');
    $('#img-sc-false').removeClass('hide');
    error.html('*ต้องเป็นไฟล์รูปภาพเท่านั้น')
  }
}