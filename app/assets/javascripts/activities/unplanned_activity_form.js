$(document).on('page:change', function() {
  var formEl = 'form.unplanned-activity-review';

  $(document)
    .on('ajax:success', formEl, function(event, script, status, xhr) {
      $(this)
        .hide()
        .next(formEl).show();
      if ($(this).next(formEl).length === 0) {
        window.location.replace(window.location.origin + '/navigator/next_content');
      }
    });
});
