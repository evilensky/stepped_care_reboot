$(function() {
  $("form.activity_form").on('submit', function(event) {
    event.preventDefault();
    $.ajax({
      type: "POST",
      data: $(event.currentTarget).find('input').serialize(),
      url: event.currentTarget.action,
      success: function(response) {
        debugger
      },
      dataType: "script"
    });
  })
})