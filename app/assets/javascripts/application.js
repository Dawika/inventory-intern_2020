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
//= require_tree .

$(document).ready(function() {
  $('form[data-client-side-validations]').validate();
})

function inValid(id, errorMessage) {
  input = $('#' + id)
  console.log(input.form)
  $('.' + id + ':first .invalid-feedback').remove();
  input.removeClass('is-valid');
  input.addClass('is-invalid');
  $('.' + id + ':first').append('<div class="invalid-feedback text-right" style="display:block;">' + errorMessage + '</div>');

}

function valid(id) {
  input = $('#' + id)
  $('.' + id + ':first .invalid-feedback').remove();
  input.removeClass('is-invalid');
  input.addClass('is-valid');
}