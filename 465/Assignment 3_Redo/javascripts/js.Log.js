// Generated by CoffeeScript 1.8.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if (window.js == null) {
    window.js = {};
  }

  window.js.Log = (function() {
    var log, _ref;

    function Log() {
      this.log = __bind(this.log, this);
      this.add = __bind(this.add, this);
      this.texts = [];
    }

    Log.prototype.add = function(name, value, indent) {
      var triplet, triplets, type, _i, _len;
      type = js.Support.type(arguments[0]);
      if (type === 'Array') {
        triplets = Array.prototype.slice.call(arguments);
      } else {
        triplets = [[name, value, indent]];
      }
      for (_i = 0, _len = triplets.length; _i < _len; _i++) {
        triplet = triplets[_i];
        name = triplet[0], value = triplet[1], indent = triplet[2];
        if (js.Support.type(value === 'Object' || value === 'Array')) {
          if (indent != null) {
            value = JSON.stringify(value, null, indent);
          } else {
            value = JSON.stringify(value);
          }
          this.texts.push("" + name + "=" + (value.replace(/\"([\w-]+?)\":/g, '$1:')));
        }
      }
      return this;
    };

    Log.prototype.log = function(name, value, indent) {
      var i, text, _i, _len, _ref;
      if (name != null) {
        if (value != null) {
          if (indent != null) {
            lAdd(name, value, indent);
          } else {
            lAdd(name, value);
          }
        } else {
          _ref = this.texts;
          for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
            text = _ref[i];
            this.texts[i] = "  " + text;
          }
          this.texts.unshift("" + name + "=");
        }
      }
      console.log(this.texts.join('\n'));
      return this.texts = [];
    };

    log = new Log();

    _ref = [log.log, log.add], window.log = _ref[0], window.lAdd = _ref[1];

    return Log;

  })();

}).call(this);
