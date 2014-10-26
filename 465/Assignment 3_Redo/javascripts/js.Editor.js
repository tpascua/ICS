// Generated by CoffeeScript 1.8.0
(function() {
  if (window.js == null) {
    window.js = {};
  }

  window.js.Editor = (function() {
    var deselect, dom, drawing, entryIds, eye1, eye2, id, ids, image, media, mouth, nose, points, select, selected, _fn, _i, _j, _len, _len1, _ref;

    function Editor() {}

    dom = {};

    entryIds = ['top', 'left', 'width', 'height', 'margin', 'padding', 'border_width', 'border_color', 'link'];

    ids = entryIds.concat(['image', 'drawing', 'playground', 'set_area', 'set_border', 'set_layout', 'set_link', 'test_links']);

    for (_i = 0, _len = ids.length; _i < _len; _i++) {
      id = ids[_i];
      dom[id] = $("#" + id);
    }

    image = new js.Image(dom.image);

    drawing = new js.Stage(dom.drawing);

    selected = null;

    deselect = function() {
      var _j, _len1, _results;
      if (selected != null) {
        selected.element.removeClass('selected');
      }
      selected = null;
      _results = [];
      for (_j = 0, _len1 = entryIds.length; _j < _len1; _j++) {
        id = entryIds[_j];
        _results.push(dom[id].val(''));
      }
      return _results;
    };

    select = function(media) {
      var border;
      if (selected != null) {
        selected.element.removeClass('selected');
      }
      selected = media;
      selected.element.addClass('selected');
      dom.top.val(selected.top());
      dom.left.val(selected.left());
      dom.width.val(selected.width());
      dom.height.val(selected.height());
      dom.margin.val(js.Support.toString(js.Css.shrink(selected.margin())));
      dom.padding.val(js.Support.toString(js.Css.shrink(selected.padding())));
      border = selected.border();
      dom.border_width.val(js.Support.toString(js.Css.shrink(border.width)));
      dom.border_color.val(js.Support.toString(js.Css.shrink(border.color)));
      dom.link.val(selected.link());
      return false;
    };

    eye1 = drawing.square().style({
      color: 'blue'
    }).at({
      x: 40,
      y: 20
    }).side(40).label('eye1');

    eye2 = drawing.square().style({
      color: 'blue'
    }).at({
      x: 120,
      y: 20
    }).side(40).label('eye2');

    points = [
      {
        x: 100,
        y: 80
      }, {
        x: 110,
        y: 140
      }, {
        x: 90,
        y: 140
      }
    ];

    nose = drawing.polygon().style({
      color: 'green'
    }).points(points).label('nose');

    mouth = drawing.circle().center({
      x: 100,
      y: 180
    }).radius(20);

    mouth.style({
      color: 'yellow',
      stroke: {
        color: 'green'
      }
    }).label('mouth');

    drawing.draw();

    deselect();

    _ref = [image, drawing];
    _fn = function(media) {
      return media.element.click((function(_this) {
        return function(event) {
          if (!dom.test_links.is(':checked')) {
            select(media);
            return event.stopImmediatePropagation();
          }
        };
      })(this));
    };
    for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
      media = _ref[_j];
      _fn(media);
    }

    image.link('image_target.html');

    drawing.link('drawing_target.html');

    dom.playground.click(deselect);

    dom.set_area.click(function() {
      return selected.top(Number(dom.top.val())).left(Number(dom.left.val())).width(Number(dom.width.val())).height(Number(dom.height.val()));
    });

    dom.set_border.click(function() {
      var border, color, width;
      width = js.Support.parse(dom.border_width.val(), js.Css.arounds);
      color = js.Support.parse(dom.border_color.val(), js.Css.arounds);
      border = {
        width: js.Css.toArounds(width),
        color: js.Css.toArounds(color)
      };
      return selected.border(border);
    });

    dom.set_layout.click(function() {
      var margin, padding;
      margin = js.Support.parse(dom.margin.val(), js.Css.arounds);
      selected.margin(js.Css.toArounds(margin));
      padding = js.Support.parse(dom.padding.val(), js.Css.arounds);
      return selected.padding(js.Css.toArounds(padding));
    });

    dom.set_link.click(function() {
      return selected.link(dom.link.val());
    });

    return Editor;

  })();

}).call(this);
