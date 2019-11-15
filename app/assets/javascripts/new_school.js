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
      console.log(url)
      console.log(response.status)
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
  disabledOrEnableSubmitForm(input.closest('form'), input.hasClass('validate-sign-up'), input.hasClass('plan-select'), id);
}

function valid(id) {
  input = $('.required#' + id)
  if (!input.hasClass('is-uniqueness')) {
    $('.' + id + ':first .invalid-feedback').remove();
    input.removeClass('is-invalid');
    input.addClass('is-valid');
    disabledOrEnableSubmitForm(input.closest('form'), input.hasClass('validate-sign-up'), input.hasClass('plan-select'), id);
  }
}

function disabledOrEnableSubmitForm(form, enableSubmit, enableButtonSelectplan, id) {
  // disabled buntton save when input validate blank
  if (form.find('input.required.is-valid').length === form.find('input.required').length) {
    form.find(':submit').attr('disabled', false);
  } else {
    form.find(':submit').attr('disabled', true);
  }
  if (enableSubmit) {
    enableButtonFormSchool('new_school', 'new_modal');
  }
  if (enableButtonSelectplan) {
    enableButtonSelectplans('new_school', 'modal', true);
  } else {
    if (id == "false") {
      enableButtonSelectplans('new_school', 'modal', false);
    }
  }
}

function enableButtonSelectplans(formID, id, check) {
  if (check) {
    form = $('#' + formID);
    button = $('#' + id);
    if (form.find('input.plan-select.disabled').length == 6) {
      if (form.find('input.plan-select.is-valid').length === form.find('#validate-bil input.plan-select').length) {
        button.attr('disabled', false);
      } else {
        button.attr('disabled', true);
      }
    } else {
      if (form.find('input.plan-select.is-valid').length === form.find('input.plan-select.required').length) {
        button.attr('disabled', false);
      } else {
        button.attr('disabled', true);
      }
    }
  } else {
    form = $('#' + formID);
    button = $('#' + id);
    if (form.find('#validate-bil input.plan-select.is-valid').length === form.find('#validate-bil input.plan-select').length) {
      button.attr('disabled', false);
    } else {
      button.attr('disabled', true);
    }

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

function showNewSchool(value) {
  if (value == 'setting') {
    $('body').removeClass('backgorund-signup');
    $('body').addClass('backgorund-signup1');
    $('#formSingUp').hide();
    $('#formSchool').show();
  } else {
    $('#formSingUp').hide();
    $('#formSchool').hide();
    $('#formplan').show();
    $("input[name='school[bil_info_attributes][phone]']").val($("input[name='school[phone]']").val());
    $("input[name='school[bil_info_attributes][branch]']").val($("input[name='school[branch]']").val());
    $("input[name='school[bil_info_attributes][tax_id]']").val($("input[name='school[tax_id]']").val());
    $("input[name='school[bil_info_attributes][name]']").val($("input[name='school[users_attributes][0][full_name]']").val());
  }
}

function changeLogo(event, img_logo) {
  logo = URL.createObjectURL(event.target.files[0]);
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


function enablevalidate(id) {
  if (id == "school_bil_info_payment_method") {
    $('#credit div').removeClass("disabled");
    $('#credit label').removeClass("disabled");
    $('#credit input').removeClass("disabled");
    $('#credit input').prop("disabled", false);
    valid(id);
    setTimeout(function() {
      $('form.simple_form').enableClientSideValidations();
    }, 200);
  } else {
    $('#credit div').addClass("disabled");
    $('#credit label').addClass("disabled");
    $('#credit input').addClass("disabled");
    $('#credit input').removeClass("is-valid");
    $('#credit input').prop("disabled", true);
    valid(id);

  }
}

function branch(id) {
  if (id == "hideBr") {
    $('div.school_bil_info_branch').hide();
    $('div.school_bil_info_company_id').hide();
    $('#hideBr').addClass("active");
    $('#showBr').removeClass("active");
  } else if (id == "showBr") {
    $('div.school_bil_info_branch').show();
    $('div.school_bil_info_company_id').show();
    $('#showBr').addClass("active");
    $('#hideBr').removeClass("active");

  }

}

function hidebutton(value) {
  if (value) {
    $('#modal-confirm').show();
  } else {
    $('#modal-confirm').hide();
  }
}

function checkvalidate() {
  if ($("#transfer-money").hasClass('active')) {
    if ($("#school_bil_info_name").val() == "") {
      inValid('school_bil_info_name', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_name')
    }
    if ($("#school_bil_info_address").val() == "") {
      inValid('school_bil_info_address', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_address')
    }
    if ($("#school_bil_info_district").val() == "") {
      inValid('school_bil_info_district', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_district')
    }
    if ($("#school_bil_info_province").val() == "") {
      inValid('school_bil_info_province', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_province')
    }
    if ($("#school_bil_info_zip_code").val() == "") {
      inValid('school_bil_info_zip_code', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_zip_code')
    }
    if ($("#school_bil_info_phone_number").val() == "") {
      inValid('school_bil_info_phone_number', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_phone_number')
    }
    if ($("#school_bil_info_tax_id").val() == "") {
      inValid('school_bil_info_tax_id', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_tax_id')
    }
    if ($("#school_bil_info_branch").val() == "") {
      inValid('school_bil_info_branch', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_branch')
    }
  } else {
    if ($("#school_bil_info_name").val() == "") {
      inValid('school_bil_info_name', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_name')
    }
    if ($("#school_bil_info_address").val() == "") {
      inValid('school_bil_info_address', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_address')
    }
    if ($("#school_bil_info_district").val() == "") {
      inValid('school_bil_info_district', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_district')
    }
    if ($("#school_bil_info_province").val() == "") {
      inValid('school_bil_info_province', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_province')
    }
    if ($("#school_bil_info_zip_code").val() == "") {
      inValid('school_bil_info_zip_code', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_zip_code')
    }
    if ($("#school_bil_info_phone_number").val() == "") {
      inValid('school_bil_info_phone_number', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_phone_number')
    }
    if ($("#school_bil_info_tax_id").val() == "") {
      inValid('school_bil_info_tax_id', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_tax_id')
    }
    if ($("#school_bil_info_branch").val() == "") {
      inValid('school_bil_info_branch', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_branch')
    }
    if ($("#school_bil_info_payment_method").val() == "") {
      inValid('school_bil_info_payment_method', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_payment_method')
    }
    if ($("#school_bil_info_cardholder_name").val() == "") {
      inValid('school_bil_info_cardholder_name', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_cardholder_name')
    }
    if ($("#school_bil_info_card_number").val() == "") {
      inValid('school_bil_info_card_number', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_card_number')
    }
    if ($("#school_bil_info_exp_month").val() == "") {
      inValid('school_bil_info_exp_month', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_exp_month')
    }
    if ($("#school_bil_info_exp_year").val() == "") {
      inValid('school_bil_info_exp_year', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_exp_year')
    }
    if ($("#school_bil_info_cvv").val() == "") {
      inValid('school_bil_info_cvv', 'ต้องไม่เว้นว่างเอาไว้');
    } else {
      valid('school_bil_info_cvv')
    }
  }
}
