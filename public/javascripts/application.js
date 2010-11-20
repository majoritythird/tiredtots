jQuery(document).ready(function($) {

  $('.sleep_blocks a#pager').live('click', function(event) {
    event.preventDefault();
    var pager = $(this);
    $.get($(this).attr('href'), function(json) {
      $('.sleep_blocks .days').append(json.html);
      $(pager).parent('div').replaceWith(json.link);
    }, 'json');
  });

  var opts = {
    gutter_x: 30,
    gutter_y: 30,
    max_y_value: 20,
    grid: {
      draw_y: true,
      color: "#d7d7d7",
      gap_y: 4
    },
    point: {
      radius: 4
    },
    path: {
      bezier_curve: 0,
      stroke_width: 2,
      fill_opacity: 0.1,
      color: "#4DBBFF"
    },
    labels_y: {
      draw: true,
      adj_x: -10,
      font: "bold 11px Arial",
      increment: 4
    },
    labels_x: {
      draw: true,
      adj_y: -200,
      font: "bold 11px Arial"
    }
  };

  $('.chart_data').each(function(index){
    $(this).before("<div class='chart' id='chart"+index+"'></div>");
    var $chart = $(this).prev('.chart');
    var data = {};
    var $table = $(this).find("table");
    var $dl = $(this).find("dl");
    data.path_name = 'path' + (index + 1);
    data.name = '';
    data.values = [];
    data.labels = [];
    $table.find("tbody tr").each(function(i) {
      data.labels.push($(this).find("td:nth-child(1)").text());
      data.values.push(parseFloat($(this).find("td:last").text()));
    });
    data.average = parseFloat($dl.find('dd:first').text());
    data.attr = {}

    buildGraph($chart, data, opts, index);
  });

  function buildGraph($chart, data, opts, index) {
    var graphite = new Graphite($chart, opts);

    var $tags = {
      tag_x: createAndAppend('div', $chart, 'tag_x_'+index, 'tag_x'),
      line_x: createAndAppend('span', $chart, 'line_x_'+index, 'line_x'),
      y_top: createAndAppend('div', $chart, 'tag_y_top_'+index, 'tag_y_top'),
      line_y: createAndAppend('span', $chart, 'line_y_'+index, 'line_y')
    }
    $("<b />").prependTo(createAndAppend('p', $tags.tag_x, '').text('AVG'));
    var raphael = Raphael($tags.tag_x.attr('id'), $tags.tag_x.width(), $tags.tag_x.height());
    $tags.tag_x.data('shape', raphael.path("M0 15.5 l5 -15 l35 0 l0 30 l-35 0 l-5 -15"));

    $("<b />").prependTo(createAndAppend('p', $tags.y_top, ''));
    raphael = Raphael($tags.y_top.attr('id'), $tags.y_top.width(), $tags.y_top.height());
    $tags.y_top.data('shape', raphael.path("M0 0 l49 0 l0 15 l-24.5 10 l-24.5 -10 l0 -15 z"));

    graphite.trigger.mouseoutGraph = function() {
      $('.tag_y_top, .line_y').fadeOut(100);
    };

    graphite.trigger.afterPath = function(path) {
      var avg = data.average;
      var y = graphite.getYOffset(avg);
      var attrs = {stroke: path.attr.color, fill: path.attr.color};
      $tags.tag_x.animate({'top': y - ($tags.tag_x.height()/2)}, 100).fadeIn(100);
      $tags.tag_x.find('b').text(Math.round(avg*10)/10);
      $tags.tag_x.data('shape').attr(attrs);
      $tags.line_x.animate({'top': y}, 100).fadeIn(100);
      $tags.line_x.css({background: path.attr.color});
    }

    graphite.trigger.mouseoverPoint = function(point) {
      point.parent.element.toFront();
      $.each(point.parent.points, function() {
        this.element.toFront();
      });

      var attrs = {stroke: point.parent.attr.color, fill: point.parent.attr.color};
      $tags.y_top.find('b').text(Math.round(point.amount*10)/10);

      var x = Math.round(point.x);
      $tags.y_top.data('shape').attr(attrs);
      $tags.y_top.animate({'left': x - $tags.y_top.width()/2 + 1}, 100).fadeIn(100);
      $tags.line_y.animate({'left': x}, 100).fadeIn(100);
      $tags.line_y.css({background: point.parent.attr.color});

      return point;
    }

    graphite.setLabels(data.labels);
    graphite.addPath(data.path_name, data.values, data.attr);

    return graphite;
  }

  function createAndAppend(tag, $target, id, css_class) {
    var $element = $('<' + tag + ' />');
    if(id)
      $element.attr("id", id);
    if(css_class)
      $element.attr("class", css_class);
    $element.appendTo($target);
    return $element;
  }

});
