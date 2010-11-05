$(function() {
  var graphite = new Graphite($("#graph"), {
    bezier_curve: 0,
    gutter_x: 5,
    max_y_value: 100,
    grid: {
      gap_y: 20,
      color: "#ccc"
    },
    path: {
      bezier_curve: 0,
      stroke_width: 2,
      fill_opacity: 0
    },
    labels_y: {
      draw: false
    },
    labels_x: {
      text_anchor: "end",
      adj_x: -5,
      adj_y: -20,
      font: "bold 11px arial",
      color: "#333"
    }
  });

  $('<div />').addClass('avgLine').appendTo($("#graph"));

  graphite.trigger.mouseoverGraph = function(i) {
  }

  graphite.trigger.mouseoutGraph = function(i) {
    graphite.tooltip.fadeOut(100);
    $('.avgLine').fadeOut(100);
  }

  graphite.trigger.beforePath = function(i) {
    return i;
  }

  graphite.trigger.beforePoint = function(i) {
    if((i.index == 0) || (i.index == graphite.labels.length-1)) {
      i.attr.radius = 2;
    }
    return i;
  }

  graphite.trigger.mouseoverPath = function(path) {
  }

  graphite.trigger.mouseoverPoint = function(point) {
    var avg = 0;
    var parent = point.parent
    $.each(parent.points, function() {
      avg += this.amount;
    });
    avg = avg / parent.points.length;
    $('.avgLine').css('background', parent.attr.color);
    $('.avgLine').animate({'top': graphite.getYOffset(avg)}, 100).fadeIn(100);

    var t = graphite.tooltip;
    t.text(point.amount);
    var x = point.x - t.innerWidth() / 2;
    var y = point.y - t.outerHeight() - 10;
    t.animate({left: x, top: y}, 100).fadeIn(100);
    return point;
  }

  function testPath() {
    var testPoints = []
    for(var i=0; i<5; i++) {
      testPoints.push((Math.round(Math.random()*1000)) / 10);
    }
    return testPoints;
  }
  graphite.setLabels(['jan', 'feb', 'mar', 'apr', 'may'])
  graphite.addPath('test path 1', testPath(), {color: '#004156'});
  graphite.addPath('test path 2', testPath(), {color: '#ff5200'});
  graphite.removePath('test path 2');
  graphite.addPath('test path 3',['',0,15,null,23], {color: '#ff0000'});
  graphite.addPath('test path 4', testPath(), {color: '#00ff55'});

});

