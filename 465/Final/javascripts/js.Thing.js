// Generated by CoffeeScript 1.8.0

/*
Made for Assignment 3
Extends the stage class and makes a drawing
 */

(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  if (window.js == null) {
    window.js = {};
  }

  window.js.Thing = (function(_super) {
    __extends(Thing, _super);

    function Thing(canvas) {
      Thing.__super__.constructor.call(this, canvas);
    }

    return Thing;

  })(window.js.Stage);

}).call(this);