// Generated by CoffeeScript 1.7.1
(function() {
  var Support;

  Support = (function() {
    function Support() {}

    Support.parse = function(string, keys) {
      var char, equivalent, index, key_, keys_, lastKey, leftParent, match, object, pattern, rightParent, separator, value, _i, _j, _len, _len1, _ref, _ref1, _ref2;
      equivalent = function(key) {
        var key_, _i, _len;
        for (_i = 0, _len = keys.length; _i < _len; _i++) {
          key_ = keys[_i];
          if (key_.startsWith(key)) {
            return key_;
          }
        }
        return key_;
      };
      _ref = [{}, []], object = _ref[0], keys_ = _ref[1];
      string = string.replace(/\s+\:/g, ':');
      pattern = /([\w-]+):/g;
      match = pattern.exec(string);
      while (match != null) {
        keys_.push(match[1]);
        match = pattern.exec(string);
      }
      if (keys_.length > 0) {
        lastKey = null;
        for (index = _i = 0, _len = keys_.length; _i < _len; index = ++_i) {
          key_ = keys_[index];
          pattern = new RegExp("" + (index === 0 ? '' : '[\\s;,]') + key_ + ":");
          _ref1 = string.split(pattern, 2), value = _ref1[0], string = _ref1[1];
          if (index !== 0) {
            object[lastKey] = value;
          }
          lastKey = equivalent(key_);
        }
        object[lastKey] = string;
        return object;
      } else {
        leftParent = string.index('(');
        rightParent = string.index(')');
        separator = {
          index: -1
        };
        _ref2 = [' ', ',', ';'];
        for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
          char = _ref2[_j];
          index = string.index(char);
          if (index != null) {
            if ((index != null) && (leftParent != null) && (index > leftParent)) {
              index = string.indexOf(char, rightParent);
            }
            if ((index != null) && (index > separator.index)) {
              separator = {
                char: char,
                index: index
              };
            }
          }
        }
        if (separator.char != null) {
          return string.split(separator.char);
        } else {
          return [string];
        }
      }
    };

    Support.toString = function(object) {
      return JSON.stringify(object).replace(/\{(.*)\}/g, '$1').replace(/"/g, '').replace(/\s/g, ',');
    };

    Support.filled = function(keys, filler) {
      var index, key, object, _i, _len;
      object = {};
      for (index = _i = 0, _len = keys.length; _i < _len; index = ++_i) {
        key = keys[index];
        object[key] = filler(key, index);
      }
      return object;
    };

    Support.type = function(value) {
      var type_;
      if (value !== void 0 && value !== null) {
        type_ = Object.prototype.toString.call(value);
        type_ = type_.substring(8, type_.length - 1);
        if ((type_ === 'Number') && isNaN(value)) {
          return 'NaN';
        } else {
          return type_;
        }
      } else {
        return String(value);
      }
    };

    String.prototype.index = function(substring) {
      var index;
      index = this.indexOf(substring);
      if (index < 0) {
        return null;
      } else {
        return index;
      }
    };

    if (typeof String.prototype.startsWith !== 'function') {
      String.prototype.startsWith = function(substring) {
        return this.lastIndexOf(substring, 0) === 0;
      };
    }

    return Support;

  })();

  if (!window.JS) {
    window.JS = {};
  }

  window.JS.Support = Support;


  /*
  cd "/Users/jan/Documents/workspace/465/2_image/"
  coffee -cwo javascripts/ coffeescripts/
   */

}).call(this);