// Generated by CoffeeScript 1.8.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if (window.js == null) {
    window.js = {};
  }

  window.js.Stage = (function(_super) {
    var add, context, shapes, _ref;

    __extends(Stage, _super);

    Stage.xys = ['x', 'y'];

    Stage.sizings = ['x', 'y', 'width', 'height'];

    _ref = [null, []], context = _ref[0], shapes = _ref[1];

    function Stage(canvas) {
      Stage.__super__.constructor.call(this, canvas);
      canvas.attr('width', canvas.width());
      canvas.attr('height', canvas.height());
      context = canvas.get(0).getContext('2d');
    }

    Stage.prototype.line = function() {
      return add(new js.Line(this));
    };

    Stage.prototype.square = function() {
      return add(new js.Square(this));
    };

    Stage.prototype.rectangle = function() {
      return add(new js.Rectangle(this));
    };

    Stage.prototype.polygon = function() {
      return add(new js.Polygon(this));
    };

    Stage.prototype.maxLine = function() {
      return add(new js.MaxLine(this));
    };

    Stage.prototype.circle = function() {
      return add(new js.Circle(this));
    };

    Stage.prototype.point = function() {
      return add(new js.Point(this));
    };

    add = function(shape) {
      shapes.push(shape);
      return shape;
    };

    Stage.prototype.dispose = function(shape) {
      var i, shape_, _i, _len;
      for (i = _i = 0, _len = shapes.length; _i < _len; i = ++_i) {
        shape_ = shapes[i];
        if (shape_ === shape) {
          shapes.slice(i, 1);
        }
      }
      return shape;
    };

    Stage.prototype.reorder = function(direction, allTheWay) {};

    Stage.prototype.draw = function() {
      var shape, _i, _len;
      context.clearRect(0, 0, context.canvas.width, context.canvas.height);
      for (_i = 0, _len = shapes.length; _i < _len; _i++) {
        shape = shapes[_i];
        shape.draw();
      }
      return this;
    };

    Stage.prototype.hit = function(p) {
      var shape, _i;
      for (_i = shapes.length - 1; _i >= 0; _i += -1) {
        shape = shapes[_i];
        if (shape.inside(p)) {
          return shape;
        }
      }
      return null;
    };

    Stage.prototype.moveTo = function(p) {
      context.moveTo(p.x, p.y);
      return this;
    };

    Stage.prototype.lineTo = function(p) {
      context.lineTo(p.x, p.y);
      return this;
    };

    Stage.prototype.rect = function(at, to) {
      context.rect(at.x, at.y, to.x - at.x, to.y - at.y);
      return this;
    };

    Stage.prototype.circle_ = function(at, radius) {
      context.arc(at.x, at.y, radius, 0, 2 * Math.PI, true);
      return this;
    };

    Stage.prototype.translate = function(vector) {
      context.translate(vector.x, vector.y);
      return this;
    };

    Stage.prototype.scale = function(factor) {
      context.scale(factor.x, factor.y);
      return this;
    };

    Stage.prototype.save = function() {
      context.save();
      return this;
    };

    Stage.prototype.restore = function() {
      context.restore();
      return this;
    };

    Stage.prototype.beginPath = function() {
      context.beginPath();
      return this;
    };

    Stage.prototype.closePath = function() {
      context.closePath();
      return this;
    };

    Stage.prototype.style = function(style) {
      if (style.color != null) {
        context.fillStyle = style.color;
        context.fill();
      }
      if (style.stroke != null) {
        if (style.stroke.color != null) {
          context.strokeStyle = style.stroke.color;
        }
        if (style.stroke.width != null) {
          context.strokeWidth = style.stroke.width;
        }
        context.stroke();
      }
      return this;
    };

    Stage.prototype.context = function() {
      return context;
    };

    Stage.prototype.area = function() {
      return {
        width: context.canvas.width,
        height: context.canvas.height
      };
    };

    Stage.prototype.toString = function() {
      return 'stage';
    };

    return Stage;

  })(window.js.Media);

  window.js.Shape = (function() {
    function Shape(stage) {
      this.stage = stage;
      this.toOriginal = __bind(this.toOriginal, this);
      this.fromOriginal = __bind(this.fromOriginal, this);
      this.toString = __bind(this.toString, this);
      this.t = {
        move: {
          x: 0,
          y: 0
        },
        scale: {
          x: 1,
          y: 1
        },
        skew: {
          x: 0,
          y: 0
        }
      };
    }

    Shape.prototype.at = function(at) {};

    Shape.prototype.style = function(style) {
      if (style != null) {
        this.style = style;
        return this;
      } else {
        return this.style;
      }
    };

    Shape.prototype.move = function(vector) {
      this.t.move.x += vector.x;
      this.t.move.y += vector.y;
      return this;
    };

    Shape.prototype.scale = function(factor) {
      this.t.scale.x *= factor.x;
      this.t.scale.y *= factor.y;
      return this;
    };

    Shape.prototype.draw = function(subDraw) {
      var bounds, vectorBack;
      bounds = this.bounds();
      vectorBack = {
        x: this.t.move.x - bounds[0].x,
        y: this.t.move.y - bounds[0].y
      };
      this.stage.save().translate(bounds[0]).scale(this.t.scale).translate(vectorBack).beginPath();
      subDraw().closePath().restore().style(this.style);
      return this;
    };

    Shape.prototype.bounds = function(subBounds) {
      var at, box;
      box = js.Support.clone(subBounds());
      at = this.at();
      return [this.fromOriginal(box[0], at), this.fromOriginal(box[1], at)];
    };

    Shape.prototype.inside = function(p, subInside) {
      return subInside(this.toOriginal(p, this.at()));
    };

    Shape.prototype.label = function(label) {
      if (label != null) {
        this.label_ = label;
        return this;
      } else {
        return this.label_;
      }
    };

    Shape.prototype.toString = function(details) {
      return "" + this.label_ + ": " + (JSON.stringify(details));
    };

    Shape.prototype.fromOriginal = function(p, at) {
      return p = {
        x: at.x + this.t.move.x + (p.x - at.x) * this.t.scale.x,
        y: at.y + this.t.move.y + (p.y - at.y) * this.t.scale.y
      };
    };

    Shape.prototype.toOriginal = function(p, at) {
      var p_;
      return p_ = {
        x: at.x + (p.x - at.x - this.t.move.x) / this.t.scale.x,
        y: at.y + (p.y - at.y - this.t.move.y) / this.t.scale.y
      };
    };

    return Shape;

  })();

  window.js.Circle = (function(_super) {
    __extends(Circle, _super);

    function Circle(stage) {
      this.inside = __bind(this.inside, this);
      this.bounds = __bind(this.bounds, this);
      this.draw = __bind(this.draw, this);
      var _ref;
      Circle.__super__.constructor.call(this, stage);
      _ref = [
        {
          x: 0,
          y: 0
        }, 50
      ], this.center_ = _ref[0], this.radius_ = _ref[1];
    }

    Circle.prototype.at = function(at) {
      if (at != null) {
        this.center_ = {
          x: at.x + this.radius_,
          y: at.y + this.radius_
        };
        return this;
      } else {
        return {
          x: this.center_.x - this.radius_,
          y: this.center_.y - this.radius_
        };
      }
    };

    Circle.prototype.center = function(center) {
      if (center != null) {
        this.center_ = center;
        return this;
      } else {
        return this.center_;
      }
    };

    Circle.prototype.radius = function(radius) {
      if (radius != null) {
        this.radius_ = radius;
        return this;
      } else {
        return this.radius_;
      }
    };

    Circle.prototype.draw = function() {
      return Circle.__super__.draw.call(this, (function(_this) {
        return function() {
          return _this.stage.circle_(_this.center_, _this.radius_);
        };
      })(this));
    };

    Circle.prototype.bounds = function() {
      return Circle.__super__.bounds.call(this, (function(_this) {
        return function() {
          return [
            _this.at(), {
              x: _this.center_.x + _this.radius_,
              y: _this.center_.y + _this.radius_
            }
          ];
        };
      })(this));
    };

    Circle.prototype.inside = function(p_) {
      return Circle.__super__.inside.call(this, p_, (function(_this) {
        return function(p) {
          var dx, dy, _ref;
          _ref = [_this.center_.x - p.x, _this.center_.y - p.y], dx = _ref[0], dy = _ref[1];
          return dx * dx + dy * dy < _this.radius_ * _this.radius_;
        };
      })(this));
    };

    Circle.prototype.toString = function() {
      return Circle.__super__.toString.call(this, {
        center: this.center_,
        radius: this.radius_
      });
    };

    return Circle;

  })(js.Shape);

  window.js.Point = (function(_super) {
    __extends(Point, _super);

    function Point(stage) {
      Point.__super__.constructor.call(this, stage);
      this.radius(3).style({
        stroke: {
          color: 'black'
        }
      });
    }

    Point.prototype.toString = function() {
      return Point.__super__.toString.call(this, this.p);
    };

    return Point;

  })(js.Circle);

  window.js.Rectangle = (function(_super) {
    __extends(Rectangle, _super);

    function Rectangle(stage) {
      this.inside = __bind(this.inside, this);
      this.bounds = __bind(this.bounds, this);
      this.draw = __bind(this.draw, this);
      var _ref;
      Rectangle.__super__.constructor.call(this, stage);
      _ref = [
        {
          x: 0,
          y: 0
        }, {
          x: 50,
          y: 50
        }
      ], this.at_ = _ref[0], this.to_ = _ref[1];
    }

    Rectangle.prototype.at = function(at) {
      if (at != null) {
        this.to_ = {
          x: at.x + this.to_.x - this.at_.x,
          y: at.y + this.to_.y - this.at_.y
        };
        this.at_ = {
          x: at.x,
          y: at.y
        };
        return this;
      } else {
        return {
          x: this.at_.x,
          y: this.at_.y
        };
      }
    };

    Rectangle.prototype.to = function(to) {
      if (to != null) {
        this.to_ = {
          x: to.x,
          y: to.y
        };
        return this;
      } else {
        return {
          x: this.to_.x,
          y: this.to_.y
        };
      }
    };

    Rectangle.prototype.width = function(width) {
      if (width != null) {
        this.to_.x = this.at_.x + width;
        return this;
      } else {
        return this.to_.x - this.at_.x;
      }
    };

    Rectangle.prototype.height = function(height) {
      if (height != null) {
        this.to_.y = this.at_.y + height;
        return this;
      } else {
        return this.to_.y - this.at_.y;
      }
    };

    Rectangle.prototype.draw = function() {
      return Rectangle.__super__.draw.call(this, (function(_this) {
        return function() {
          return _this.stage.rect(_this.at_, _this.to_);
        };
      })(this));
    };

    Rectangle.prototype.bounds = function() {
      return Rectangle.__super__.bounds.call(this, (function(_this) {
        return function() {
          return [_this.at_, _this.to_];
        };
      })(this));
    };

    Rectangle.prototype.inside = function(p_) {
      return Rectangle.__super__.inside.call(this, p_, (function(_this) {
        return function(p) {
          var _ref, _ref1;
          return ((_this.at_.x <= (_ref = p.x) && _ref <= _this.to_.x)) && ((_this.at_.y <= (_ref1 = p.y) && _ref1 <= _this.to_.y));
        };
      })(this));
    };

    Rectangle.prototype.toString = function() {
      return Rectangle.__super__.toString.call(this, {
        at: this.at_,
        to: this.to_
      });
    };

    return Rectangle;

  })(js.Shape);

  window.js.Square = (function(_super) {
    __extends(Square, _super);

    function Square(stage) {
      Square.__super__.constructor.call(this, stage);
    }

    Square.prototype.side = function(side) {
      if (side != null) {
        this.width(side);
        this.height(side);
        return this;
      } else {
        return this.width();
      }
    };

    return Square;

  })(js.Rectangle);

  window.js.Polygon = (function(_super) {
    __extends(Polygon, _super);

    function Polygon(stage) {
      this.stage = stage;
      this.inside = __bind(this.inside, this);
      this.bounds = __bind(this.bounds, this);
      this.draw = __bind(this.draw, this);
      Polygon.__super__.constructor.call(this, stage);
      this.ps = [
        {
          x: 0,
          y: 0
        }, {
          x: 50,
          y: 50
        }
      ];
    }

    Polygon.prototype.points = function(ps) {
      if (ps != null) {
        this.ps = ps;
        return this;
      } else {
        return this.ps;
      }
    };

    Polygon.prototype.at = function(at) {
      var bounds, dx, dy, p, p_, _i, _len, _ref, _ref1;
      bounds = this.originalBounds();
      if (at != null) {
        _ref = [at.x - bounds.x, at.y - bounds.y], dx = _ref[0], dy = _ref[1];
        _ref1 = this.ps;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          p_ = _ref1[_i];
          p = {
            x: p.x + dx,
            y: p.y + dy
          };
        }
        return this;
      } else {
        return bounds[0];
      }
    };

    Polygon.prototype.draw = function() {
      return Polygon.__super__.draw.call(this, (function(_this) {
        return function() {
          var i, _i, _ref;
          _this.stage.moveTo(_this.ps[0]);
          for (i = _i = 1, _ref = _this.ps.length; 1 <= _ref ? _i < _ref : _i > _ref; i = 1 <= _ref ? ++_i : --_i) {
            _this.stage.lineTo(_this.ps[i]);
          }
          return _this.stage;
        };
      })(this));
    };

    Polygon.prototype.originalBounds = function() {
      var box, compare, i, p, _i, _j, _len, _ref;
      compare = [Math.min, Math.max];
      box = js.Support.clone([this.ps[0], this.ps[0]]);
      _ref = this.ps;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        for (i = _j = 0; _j <= 1; i = ++_j) {
          box[i] = {
            x: compare[i](box[i].x, p.x),
            y: compare[i](box[i].y, p.y)
          };
        }
      }
      return box;
    };

    Polygon.prototype.bounds = function() {
      return Polygon.__super__.bounds.call(this, (function(_this) {
        return function() {
          return _this.originalBounds();
        };
      })(this));
    };

    Polygon.prototype.inside = function(p_, subInside) {
      if (subInside == null) {
        subInside = (function(_this) {
          return function(p) {
            var box, _ref, _ref1;
            box = _this.bounds();
            return ((box[0].x <= (_ref = p.x) && _ref <= box[1].x)) && ((box[0].y <= (_ref1 = p.y) && _ref1 <= box[1].y));
          };
        })(this);
      }
      return Polygon.__super__.inside.call(this, p_, subInside);
    };

    Polygon.prototype.toString = function() {
      return Polygon.__super__.toString.call(this, this.ps);
    };

    return Polygon;

  })(js.Shape);

  window.js.Line = (function(_super) {
    var stripLimitSquare;

    __extends(Line, _super);

    stripLimitSquare = 4 * 4;

    function Line(stage) {
      this.stage = stage;
      this.inside = __bind(this.inside, this);
      Line.__super__.constructor.call(this, stage);
    }

    Line.prototype.from = function(p) {
      if (p != null) {
        return this.points([p, this.ps[1]]);
      } else {
        return this.ps[0];
      }
    };

    Line.prototype.to = function(p) {
      if (p != null) {
        return this.points([this.ps[0], p]);
      } else {
        return this.ps[1];
      }
    };

    Line.prototype.points = function(ps) {
      if (ps != null) {
        ps = ps.slice(0, 2);
      }
      return Line.__super__.points.call(this, ps);
    };

    Line.prototype.inside = function(p_) {
      return Line.__super__.inside.call(this, p_, (function(_this) {
        return function(p) {
          var a, a2b2, b, c, d, x, y;
          a = _this.ps[0].y - _this.ps[1].y;
          b = _this.ps[1].x - _this.ps[0].x;
          c = _this.ps[0].x * _this.ps[1].y - _this.ps[1].x * _this.ps[0].y;
          d = a * p.x + b * p.y + c;
          a2b2 = a * a + b * b;
          if (d * d > a2b2 * stripLimitSquare) {
            return false;
          }
          if (Math.abs(a) > Math.abs(b)) {
            y = (a * (a * p.y - b * p.x) - b * c) / a2b2;
            return (y < _this.ps[0].y) !== (y < _this.ps[1].y);
          } else {
            x = (b * (b * p.x - a * p.y) - a * c) / a2b2;
            return (x < _this.ps[0].x) !== (x < _this.ps[1].x);
          }
        };
      })(this));
    };

    return Line;

  })(js.Polygon);

  window.js.MaxLine = (function(_super) {
    __extends(MaxLine, _super);

    function MaxLine(stage) {
      this.stage = stage;
      MaxLine.__super__.constructor.call(this, stage);
    }

    MaxLine.prototype.points = function(ps) {
      var area, c, m, points, x2, _ref;
      if (ps != null) {
        area = this.stage.area();
        points = ps[0].x === ps[1].x ? [
          {
            x: ps[0].x,
            y: 0
          }, {
            x: ps[0].x,
            y: area.height
          }
        ] : ps[0].y === ps[1].y ? [
          {
            x: 0,
            y: ps[0].y
          }, {
            x: area.width,
            y: ps[0].y
          }
        ] : ((_ref = Geometry.lineCoefficientsY(ps), c = _ref[0], m = _ref[1], _ref), x2 = area.width, [
          {
            x: 0,
            y: c
          }, {
            x: x2,
            y: m * x2 + c
          }
        ]);
        MaxLine.__super__.points.call(this, points);
        return this;
      } else {
        return this.ps;
      }
    };

    return MaxLine;

  })(js.Line);

  window.js.Geometry = (function() {
    function Geometry() {}

    Geometry.limit = 1e-5;

    Geometry.lineCoefficientsX = function(ps) {
      var dx, dy, m;
      dx = ps[0].x - ps[1].x;
      dy = ps[0].y - ps[1].y;
      if (Math.abs(dy) > Geometry.limit) {
        m = dx / dy;
        return [ps[0].x - m * ps[0].y, m];
      } else if (Math.abs(dx) < Geometry.limit) {
        return [ps[0].x];
      } else {
        return null;
      }
    };

    Geometry.lineCoefficientsY = function(ps) {
      var dx, dy, m;
      dx = ps[0].x - ps[1].x;
      dy = ps[0].y - ps[1].y;
      if (Math.abs(dx) > Geometry.limit) {
        m = dy / dx;
        return [ps[0].y - m * ps[0].x, m];
      } else if (Math.abs(dy) < Geometry.limit) {
        return [ps[0].y];
      } else {
        return null;
      }
    };

    return Geometry;

  })();

}).call(this);