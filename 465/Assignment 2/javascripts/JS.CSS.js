// Generated by CoffeeScript 1.7.1
(function() {
  var CSS,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  CSS = (function() {
    var key, _i, _j, _len, _len1, _ref, _ref1;

    function CSS() {}

    CSS.arounds = ['top', 'right', 'bottom', 'left'];

    CSS.aroudRules = ['margin', 'padding', 'border-width', 'border-color'];

    CSS.rules = {
      numeric: ['top', 'left', 'margin', 'padding', 'border-width'],
      colors: ['color', 'background-color', 'border-color']
    };

    CSS.noPx = function(pixels) {
      return Math.round(pixels.replace('px', ''));
    };

    CSS.addPx = function(pixels) {
      return "" + pixels + (pixels === 0 ? '' : 'px');
    };

    CSS.same = function(value) {
      return value;
    };

    CSS.hexColor = function(value) {
      var bytes, number;
      bytes = (function() {
        var _i, _len, _ref, _results;
        _ref = value.match(/(\d+).*(\d+).*(\d+)/).slice(1, 4);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          number = _ref[_i];
          number = Number(number);
          _results.push("" + (number < 16 ? '0' : '') + (number.toString(16)));
        }
        return _results;
      })();
      return "#" + (bytes.join(''));
    };

    CSS.from = {};

    CSS.to = {};

    _ref = CSS.rules.numeric;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      key = _ref[_i];
      CSS.from[key] = CSS.noPx;
      CSS.to[key] = CSS.addPx;
    }

    _ref1 = CSS.rules.colors;
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      key = _ref1[_j];
      CSS.from[key] = CSS.hexColor;
      CSS.to[key] = CSS.same;
    }

    CSS.css = function(element, key, values) {
      var fromCss, key_, prefix, property, split, suffix, toCss, _k, _len2, _ref2, _ref3, _ref4;
      split = function() {
        var prefix, suffix, _ref2;
        _ref2 = key.split('-'), prefix = _ref2[0], suffix = _ref2[1];
        suffix = suffix != null ? "-" + suffix : '';
        return [prefix, suffix];
      };
      if (values != null) {
        toCss = CSS.to[key];
        if (__indexOf.call(CSS.aroudRules, key) >= 0) {
          _ref2 = split(), prefix = _ref2[0], suffix = _ref2[1];
          _ref3 = CSS.arounds;
          for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
            key_ = _ref3[_k];
            element.css("" + prefix + "-" + key_ + suffix, toCss(values[key_]));
          }
          return null;
        } else {
          return element.css(key, toCss(values));
        }
      } else {
        fromCss = CSS.from[key];
        if (__indexOf.call(CSS.aroudRules, key) >= 0) {
          _ref4 = split(), prefix = _ref4[0], suffix = _ref4[1];
          property = function(key_) {
            return fromCss(element.css("" + prefix + "-" + key_ + suffix));
          };
          return JS.Support.filled(CSS.arounds, property);
        } else {
          return fromCss(element.css(key));
        }
      }
    };

    CSS.shrink = function(values) {
      var key_, value, value_;
      value = values.top;
      for (key_ in values) {
        value_ = values[key_];
        if (value_ !== value) {
          return values;
        }
      }
      return value;
    };

    CSS.toArounds = function(values) {
      var i;
      if (JS.Support.type(values) === 'Array') {
        values = (function() {
          var _k, _results;
          switch (values.length) {
            case 0:
              return [0, 0, 0, 0];
            case 1:
              _results = [];
              for (i = _k = 1; _k <= 4; i = ++_k) {
                _results.push(values[0]);
              }
              return _results;
              break;
            case 2:
              return values.concat(values);
            case 3:
              return values.concat([values[1]]);
            default:
              return values;
          }
        })();
        return JS.Support.filled(CSS.arounds, function(key, index) {
          return values[index];
        });
      } else {
        return values;
      }
    };

    CSS.expand = function(value) {
      return JS.Support.filled(CSS.arounds, function() {
        return value;
      });
    };

    return CSS;

  })();

  if (!window.JS) {
    window.JS = {};
  }

  window.JS.CSS = CSS;


  /*
  cd "/Users/jan/Documents/workspace/465/2_image/"
  coffee -cwo javascripts/ coffeescripts/
   */

}).call(this);
