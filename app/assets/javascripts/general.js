function zeroPrepend(number) {
  var result = number.toString();

  if (number < 10) {
    result = '0' + result;
  }

  return result;
}

function dateString(time) {
  return time.getFullYear() + '-' + zeroPrepend(time.getMonth() + 1) + '-' + zeroPrepend(time.getDate());
}

function timeString(time) {
  return dateString(time) + 'T' + zeroPrepend(time.getHours()) + ':' + zeroPrepend(time.getMinutes());
}

var ready = function() {
  $(".link-row").click(function() {
    window.location = $(this).data("href");
  });

  $(".set-now-date").click(function() {
    var now = new Date($.now());
    $(this).prev().val(dateString(now));
    console.log(now);
  });

  $(".set-now-time").click(function() {
    var now = new Date($.now());
    $(this).prev().val(timeString(now));
    console.log(now);
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
