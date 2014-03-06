$(document).on('page:change', function() {
  var formEl = 'form#new_thought';

  $(formEl + ' button[type="submit"]').hide();

  $(document)
    .on('change', formEl + ' input[name="thought[effect]"]', function(event) {
      $(formEl + ' button[type="submit"]').show();
    });
});
