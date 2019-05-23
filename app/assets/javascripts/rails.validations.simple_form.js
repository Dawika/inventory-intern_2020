/*!
 * Client Side Validations - SimpleForm - v6.2.0 (https://github.com/DavyJonesLocker/client_side_validations-simple_form)
 * Copyright (c) 2017 Geremia Taglialatela, Brian Cardarella
 * Licensed under MIT (http://opensource.org/licenses/mit-license.php)
 */

(function() {
  ClientSideValidations.formBuilders['SimpleForm::FormBuilder'] = {
    add: function(element, settings, message) {
      return this.wrapper(settings.wrapper).add.call(this, element, settings, message);
    },
    remove: function(element, settings) {
      return this.wrapper(settings.wrapper).remove.call(this, element, settings);
    },
    wrapper: function(name) {
      return this.wrappers[name] || this.wrappers["default"];
    },
    wrappers: {
      "default": {
        add: function(element, settings, message) {
          inValid(element.attr('id'), message)
        },
        remove: function(element, settings) {
          valid(element.attr('id'))
        }
      }
    }
  };

}).call(this);