jQuery(document).ready(function($) {

  $('.sleep_blocks a#pager').live('click', function(event) {
    event.preventDefault();
    $.get($(this).attr('href'), function(json) {
      $('.sleep_blocks .days').append(json.html);
      $('.sleep_blocks .actions').replaceWith(json.link);
    }, 'json');
  });

  var opts = {
    gutter_x: 30,
    gutter_y: 30,
    max_y_value: 24,
    grid: {
      draw_y: false,
      color: "#d7d7d7"
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
      count: 2,
      adj_x: -10,
      font: "bold 11px Arial"
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

    var the_chart = buildGraph($chart, data, opts);
    var $label = $chart.find('.label');
    var $total = createAndAppend('p', $label).addClass('total');
    $chart.mousemove(function(e) {
      var line_x = animateTooltip(the_chart, $(this), e);
      $total.text(data.values[line_x]);
    });

    function animateTooltip(graphite, $chart, e) {
      var increment = (graphite.attr('w') - graphite.attr('gutter_x')*2) / (data.labels.length-1);
      var mouse_x = e.pageX - $chart.offset().left - graphite.attr('gutter_x');
      var line_x = Math.round(mouse_x / increment);
      $chart.find('.tooltip').stop().animate({
        'opacity' : 1,
        'left' : Math.round(line_x * increment + graphite.attr('gutter_x') - ($label.width()/2))
      }, 50);
      return line_x;
    }

  });

  function buildGraph($chart, data, opts) {
    var graphite = new Graphite($chart, opts);

    var $tags = {
      tag_x: createAndAppend('div', 'tag_x', $chart),
      line_x: createAndAppend('span', 'line_x', $chart),
    }
    $("<b />").prependTo(createAndAppend('p', '', $tags.tag_x).text('AVG'));
    var raphael = Raphael($tags.tag_x.attr('id'), $tags.tag_x.width(), $tags.tag_x.height());
    $tags.tag_x.data('shape', raphael.path("M0 15.5 l5 -15 l35 0 l0 30 l-35 0 l-5 -15"));

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

    var $tooltip = createAndAppend('div', $chart).addClass('tooltip');
    $('<span />').appendTo($tooltip);
    $('<div />').addClass('label').appendTo($tooltip);

    $chart.mouseleave(function($i) {
      $tooltip.stop().animate({
        'opacity' : 0
      }, 50);
    });

    graphite.setLabels(data.labels);
    graphite.addPath(data.path_name, data.values, data.attr);

    return graphite;
  }

  function createAndAppend(tag, id, $target) {
    var $element = $('<' + tag + ' />').attr("id", id);
    if(id) {
      $element.attr("id", id);
    }
    $element.appendTo($target);
    return $element;
  }

});
