// Generated by CoffeeScript 1.8.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  if (window.js == null) {
    window.js = {};
  }

  window.js.Image = (function(_super) {
    __extends(Image, _super);

    function Image(element) {
      Image.__super__.constructor.call(this, element);
    }

    Image.prototype.toString = function() {
      return 'image';
    };

    return Image;

  })(js.Media);

}).call(this);