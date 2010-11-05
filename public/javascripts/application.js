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
    var $canvas = $(this).prev('.chart');
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

    var the_chart = buildGraph($canvas, data, opts);
    var $label = $canvas.find('.label');
    var $total = createAndAppend('p', $label).addClass('total');
    $canvas.mousemove(function(e) {
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

  function createAndAppend(tag, $target) {
    var $element = $('<' + tag + ' />');
    $element.appendTo($target);
    return $element;
  }

});
