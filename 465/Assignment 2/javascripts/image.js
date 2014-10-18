// Generated by CoffeeScript 1.8.0
(function() {
  var Image, Media,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Media = (function() {
    function Media(element) {
      this.element = element;
      this.top(Math.round(JS.CSS.css(this.element, 'top')));
      this.left(Math.round(JS.CSS.css(this.element, 'left')));
      this.width(Math.round(this.element.width()));
      this.height(Math.round(this.element.height()));
      this.link('');
    }

    Media.prototype.top = function(top_) {
      if (arguments.length === 0) {
        return this.top_;
      }
      this.top_ = top_;
      JS.CSS.css(this.element, 'top', this.top_);
      return this;
    };

    Media.prototype.left = function(left_) {
      if (arguments.length === 0) {
        return this.left_;
      }
      this.left_ = left_;
      JS.CSS.css(this.element, 'left', this.left_);
      return this;
    };

    Media.prototype.width = function(width_) {
      if (arguments.length === 0) {
        return this.width_;
      }
      this.width_ = width_;
      this.element.width(this.width_);
      return this;
    };

    Media.prototype.height = function(height_) {
      if (arguments.length === 0) {
        return this.height_;
      }
      this.height_ = height_;
      this.element.height(this.height_);
      return this;
    };

    Media.prototype.link = function(link_) {
      if (arguments.length === 0) {
        return this.link_;
      }
      if (link_ != null) {
        link_ = link_.trim();
        if (link_ === "") {
          link_ = null;
        }
      }
      this.link_ = link_;
      if (this.link_ != null) {
        this.element.click((function(_this) {
          return function() {
            return window.location = _this.link_;
          };
        })(this));
      } else {
        this.element.click(function() {});
      }
      return this;
    };

    return Media;

  })();

  Image = (function(_super) {
    __extends(Image, _super);

    function Image(element) {
      var border;
      this.element = element;
      Image.__super__.constructor.apply(this, arguments);
      border = {
        width: JS.CSS.css(this.element, 'border-width'),
        color: JS.CSS.css(this.element, 'border-color')
      };
      this.border(border);
      this.margin(JS.CSS.css(this.element, 'margin'));
      this.padding(JS.CSS.css(this.element, 'padding'));
    }

    Image.prototype.border = function(border_) {
      if (arguments.length === 0) {
        return this.border_;
      }
      this.border_ = border_;
      JS.CSS.css(this.element, 'border-width', this.border_.width);
      JS.CSS.css(this.element, 'border-color', this.border_.color);
      return this;
    };

    Image.prototype.margin = function(margin_) {
      if (arguments.length === 0) {
        return this.margin_;
      }
      this.margin_ = margin_;
      JS.CSS.css(this.element, 'margin', this.margin_);
      return this;
    };

    Image.prototype.padding = function(padding_) {
      if (arguments.length === 0) {
        return this.padding_;
      }
      this.padding_ = padding_;
      JS.CSS.css(this.element, 'padding', this.padding_);
      return this;
    };

    return Image;

  })(Media);

  if (!window.JS) {
    window.JS = {};
  }

  window.JS.Image = Image;

  $(function() {
    var border, dom, id, ids, image, _i, _len;
    dom = {};
    ids = ['image', 'top', 'left', 'position', 'width', 'height', 'resize', 'link', 'border_width', 'border_color', 'set_border', 'get_border', 'margin', 'set_margin', 'padding', 'set_padding', 'set_link'];
    for (_i = 0, _len = ids.length; _i < _len; _i++) {
      id = ids[_i];
      dom[id] = $("#" + id);
    }
    image = new JS.Image(dom.image);
    dom.top.val(image.top());
    dom.left.val(image.left());
    dom.width.val(image.width());
    dom.height.val(image.height());
    border = image.border();
    dom.border_width.val(JS.Support.toString(JS.CSS.shrink(border.width)));
    dom.border_color.val(JS.Support.toString(JS.CSS.shrink(border.color)));
    dom.margin.val(JS.Support.toString(JS.CSS.shrink(image.margin())));
    dom.padding.val(JS.Support.toString(JS.CSS.shrink(image.padding())));
    dom.position.click(function() {
      return image.top(Number(dom.top.val())).left(Number(dom.left.val()));
    });
    dom.resize.click(function() {
      return image.width(dom.width.val()).height(dom.height.val());
    });
    dom.set_border.click(function() {
      border = {
        width: JS.Support.parse(dom.border_width.val(), JS.CSS.arounds),
        color: JS.Support.parse(dom.border_color.val(), JS.CSS.arounds)
      };
      return image.border(border);
    });
    dom.set_margin.click(function() {
      var values;
      values = JS.Support.parse(dom.margin.val(), JS.CSS.arounds);
      return image.margin(JS.CSS.toArounds(values));
    });
    dom.set_padding.click(function() {
      var values;
      values = JS.Support.parse(dom.padding.val(), JS.CSS.arounds);
      return image.padding(JS.CSS.toArounds(values));
    });
    return dom.set_link.click(function() {
      return image.link(dom.link.val());
    });
  });


  /*
  cd "C:/Users/Tyler/Documents/Aptana Studio 3 Workspace/Assignment 2/"
  coffee -cwo javascripts/ coffeescripts/
   */

}).call(this);
