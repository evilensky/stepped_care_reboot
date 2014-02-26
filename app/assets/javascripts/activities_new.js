$(function() {
  $("form.activity_form").on('submit', function(event) {
    event.preventDefault();
    var $target = $(event.currentTarget);
    $.ajax({
      type: "POST",
      data: $(event.currentTarget).find('input').serialize(),
      url: event.currentTarget.action,
      success: function(response) {
        if (response.status == "success") {
          $target.hide();
          $target.next('form.activity_form').show();
        } else {
          console.log('ERRORS');
        };
      },
      dataType: "json"
    });
  })
})