$(document).on('page:change', function() {
  $("form.activity_form:first").show();
  $(document)
    .on('ajax:success', 'form.activity_form', function(event, script, status, xhr) {
      $(this).hide();
      $(this).next('form.activity_form').show();
      if (!$("form.activity_form").is(":visible")) {
        window.location.replace(window.location.origin+"/navigator/next_content")
      };
    })
    .on('ajax:error', 'form.activity_form', function(event, xhr, status) {
    })
    .on('ajax:complete', 'form.activity_form', function(data, status, xhr) {
    });
});
