function Graphite($div, opts) {
  var graphite = this;
  var defaults = {
    max_y_value: 0,
    gutter_x: 20,
    gutter_y: 20,
    tooltip_class: 'tooltip',
    grid: {
      draw_border: true,
      draw_x: true,
      draw_y: true,
      color: "#ccc",
      gap_y: 0
    },
    point: {
      radius: 4
    },
    path: {
      color: Raphael.getColor(),
      bezier_curve: 10,
      stroke_width: 4,
      fill_opacity: .3
    },
    labels_x: {
      draw: true,
      font: "normal 10px Helvetica, Arial, sans-serif",
      color: "#333333",
      align: "center",
      adj_x: 0,
      adj_y: 0
    },
    labels_y: {
      draw: true,
      font: "normal 10px Helvetica, Arial, sans-serif",
      color: "#333333",
      count: 0,
      increment: 0,
      adj_x: 0,
      adj_y: 0
    }
  }
  var user_opts = arguments[1];
  var opts = $.extend(true, defaults, user_opts || {});
  this.attr = function(opt) {
    return opts[opt];
  };

  var graph = initGraph($div);

  this.labels = [];
  var data = {};

  this.trigger = {
    beforePoint : {},
    beforePath : {},
    afterPoint : {},
    afterPath : {},
    mouseoverPoint : {},
    mouseoutPoint : {},
    mouseoverPath : {},
    mouseoutPath : {},
    mouseoverGraph : {},
    mouseoutGraph : {}
  };

  this.tooltip = $('.' + opts.tooltip_class);

  function fireTrigger(name, obj) {
    var fire = graphite.trigger[name];
    if(typeof fire == 'function') {
      return fire(obj);
    }
    return obj;
  }

  function initGraph($div) {
    var graph = Raphael($div.attr('id'), $div.width(), $div.height());
    opts.w = $div.width();
    opts.h = $div.height();

    $("<div />").addClass(opts.tooltip_class).appendTo($div);

    $div.mouseenter(function() {
      fireTrigger('mouseoverGraph', graph);
    });
    $div.mouseleave(function() {
      fireTrigger('mouseoutGraph', graph);
    });
    return graph;
  }

  this.refresh = function() {
    $.each(data, function(k, v) {
      if(v.element) {
        v.element.remove();
      }
      if(v.fill_element) {
        v.fill_element.remove();
      }
      $.each(v.points, function(k, v) {
        if(v.element) {
          v.element.remove();
        }
      });
      v.element = graphite.drawPath(v);
    });
    this.gridpaths = this.drawGrid();
    $.each(this.labels, function(i) {
      graphite.labels.pop().remove();
    });
    this.setLabels();
  };

  this.setYScale = function(v) {
    if(opts.grid.gap_y != 0) {
      opts.max_y_value = v + opts.grid.gap_y - (v % opts.grid.gap_y);
    } else {
      opts.max_y_value = v;
    }
    graphite.scale_y = (opts.h - opts.gutter_y * 2) / opts.max_y_value;
  };

  this.addPath = function(name, values, newOpts) {
    if($.isEmptyObject(data)) {
      this.setYScale(opts.max_y_value);
    }
    var pathObj = {
      name: name,
      points: [],
      attr: $.extend({}, opts.path)
    };
    var newPath = $.extend({}, pathObj);
    newPath.attr = $.extend(newPath.attr, newOpts);
    $.each(values, function(k, v) {
      if ((typeof v == 'number') && (v >= 0)) {
        var pointObj = {
          index: k,
          parent: newPath,
          amount: v,
          attr: $.extend({}, opts.point)
        };
        if(v > opts.max_y_value) {
          graphite.setYScale(v);
        }
        newPath.points.push($.extend({}, pointObj));
      }
    });

    data[name] = newPath;

    this.refresh();

    return newPath;

  };

  this.removePath = function(pathName) {
    var path = data[pathName];
    path.element.remove();
    if(path.fill_element) {
      path.fill_element.remove();
    }
    $.each(path.points, function(point) {
      this.element.remove();
    });
    delete data[pathName];
    if(opts.max_y_value > user_opts.max_y_value) {
      var newMax = user_opts.max_y_value;
      $.each(data, function(k, v) {
        $.each(v.points, function(k, v) {
          if(v.amount > newMax) {
            newMax = v.amount;
          }
        });
      });
      graphite.setYScale(newMax);
    };
    this.refresh();
  };

  this.setLabels = function() {
    if (arguments[0]) {
      this.labels_x = arguments[0];
    }
    var l = this.labels_x;
    this.scale_x = (opts.w / (l.length - 1)) - (opts.gutter_x * 2) / (l.length - 1);
    var increment_x = (opts.w - (opts.gutter_x * 2)) / (l.length - 1);
    if(opts.labels_x.draw) {
      $.each(l, function(i, label) {
        var x = i * increment_x + opts.gutter_x + opts.labels_x.adj_x;
        var y = opts.h - opts.gutter_y / 2 + opts.labels_x.adj_y;
        var t = graph.text(x, y, label).attr({
          "text-anchor": opts.labels_x.text_anchor,
          font: opts.labels_x.font,
          fill: opts.labels_x.color
        });
        graphite.labels.push(t);
      });
    }
    if(opts.labels_y.draw) {
      var increment_y = (opts.h - (opts.gutter_y * 2)) / opts.max_y_value;
      var x = opts.gutter_x + opts.labels_y.adj_x;
      if(opts.labels_y.count > 0) {
        var step = ((opts.h - (opts.gutter_y * 2)) / (opts.labels_y.count-1)) / increment_y;
        for (var i = 0; i < opts.h; i+= step) {
          var amount = Math.round(i);
          var y = opts.h - (i * increment_y) - opts.gutter_y + opts.labels_y.adj_y;
          var t = graph.text(x, y, amount+'').attr({
            "text-anchor": "end",
            font: opts.labels_y.font,
            fill: opts.labels_x.color
          });
          graphite.labels.push(t);
        }
      } else {
        var step = opts.grid.gap_y;
        if(opts.labels_y.increment) {
          step = opts.labels_y.increment;
        }
        for (var i = 0; i <= opts.max_y_value; i+=step) {
          var y = opts.h - (i * increment_y) - opts.gutter_y + opts.labels_y.adj_y;
          var t = graph.text(x, y, i+'').attr({
            "text-anchor": "end",
            font: opts.labels_y.font,
            fill: opts.labels_x.color
          });
          graphite.labels.push(t);
        }
      }
    }
  };

  this.drawPath = function(p) {
    var path = fireTrigger('beforePath', p);
    var c = graph.path("M0,0").attr({fill: "none", stroke: path.attr.color, "stroke-width": path.attr.stroke_width});
    var coordinates = graphite.svgPath(path.points);
    c.attr({path: coordinates});
    if(opts.path.fill_opacity > 0) {
      var bg = graph.path("M0,0").attr({stroke: "none", opacity: path.attr.fill_opacity});
      var bg_values = coordinates + "L" + (opts.w - opts.gutter_x) + "," + (opts.h - opts.gutter_y) +
                      " " + opts.gutter_x + "," + (opts.h - opts.gutter_y) + "z";
      bg.attr({path: bg_values, fill: path.attr.color});
    }
    c.mouseover(function() {
      fireTrigger('mouseoverPath', path);
    });
    c.mouseout(function() {
      fireTrigger('mouseoutPath', path);
    });
    path.element = c;
    path.fill_element = bg;
    fireTrigger('afterPath', path);
    return c;
  };

  this.getYOffset = function(value) {
    return opts.h - value * this.scale_y - opts.gutter_y;
  };

  this.drawGrid = function() {
    if(this.gridpaths) {
      $.each(this.gridpaths, function(k, v) {
        v.remove();
      });
    }

    var gap_x, gap_y, count_x, count_y = 0;
    var gx = opts.gutter_x;
    var gy = opts.gutter_y;
    var grid_width = opts.w - gx*2;
    var grid_height = opts.h - gy*2;
    var gridlines = [];

    if(opts.grid.draw_x) {
      count_x = this.labels_x.length - 1;
      gap_x = (opts.w - gx * 2) / count_x;

      for (var q = 1; q < count_x; q++) {
        var x = Math.round(q * gap_x + gx) + .5;
        gridlines.push("M" + x + "," + gy + "l0," + grid_height);
      }
    }
    if(opts.grid.draw_y) {
      if(opts.grid.gap_y != 0) {
        gap_y = (opts.h - gy * 2) / (opts.max_y_value / opts.grid.gap_y);
      } else {
        gap_y = this.scale_y;
      }
      count_y = (opts.h - gy * 2) / gap_y;
      for (var q = 1; q < count_y; q++) {
        var y = Math.round(q * gap_y + gy) + .5;
        gridlines.push("M" + gx + "," + y + "l" + grid_width + ",0");
      }
    }
    if(opts.grid.draw_border) {
      gridlines.push("M" + (gx+.5) + "," + (gy+.5) + "l" + grid_width + ",0l0" + "," + grid_height + "l-" + grid_width + ",0 z")
    }

    var gridpaths = [];
    $.each(gridlines, function(k, v) {
      gridpaths.push(graph.path(v).attr({fill: "none", "stroke-width": 1, stroke: opts.grid.color}).toBack());
    });
    return gridpaths;

  };

  this.svgPath = function(points) {
    var coordinates = "";
    var x = 0, y = 0;
    var n = points.length;
    for (var i = 0; i < n; i++) {
      var point = points[i];
      y = opts.h - (point.amount * graphite.scale_y) + (opts.path.stroke_width / 2) - opts.gutter_y;
      x = opts.gutter_x + graphite.scale_x * point.index;
      if (i) {
        coordinates += "S" + [x - opts.path.bezier_curve, y, x, y];
      } else {
        coordinates += "M" + [x, y];
      }
      point.x = Math.round(x);
      point.y = y;
      point.element = this.svgPoint(point);
      point = fireTrigger('afterPoint', point);
    }
    return coordinates;
  };

  this.svgPoint = function(point) {
    var point = fireTrigger('beforePoint', point);
    var circle = graph.circle(point.x, point.y, point.attr.radius)
                  .attr({fill: point.parent.attr.color, stroke: "none"});
    circle.mouseover(function() {
      fireTrigger('mouseoverPoint', point);
    });
    circle.mouseout(function() {
      fireTrigger('mouseoutPoint', point);
    });
    return circle;
  };
}