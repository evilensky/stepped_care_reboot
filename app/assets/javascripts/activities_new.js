$(function() {
  $("form.activity_form:first").show();
  $("form.activity_form").on('ajax:success', function(data, status, xhr) {
    $(this).hide();
    $(this).next('form.activity_form').show();
    if (!$("form.activity_form").is(":visible")) {
      window.location.replace(window.location.origin+"/navigator/next_content")
    };
  });
});