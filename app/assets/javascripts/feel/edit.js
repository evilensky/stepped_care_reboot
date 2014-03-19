$(document).on("page:change", function() {
  var forms;
  forms = $("form.edit_emotion_form");
  $("form.edit-emotion-form .checkbox input").on("change", function(event) {
    var form, target;
    target = $(event.currentTarget);
    form = $(target).closest("form.edit-emotion-form");
    return form.find(".intensity-scale").toggle();
  });
  return $("#update-emotions").on("click", function(event) {
    var $target, numberOfForms;
    event.preventDefault();
    forms = $("form input:checked").closest("form");
    numberOfForms = forms.length;
    $target = $(event.currentTarget);
    $.each(forms, function(index, form) {
      var data;
      data = $(form).serialize();
      return $.ajax({
        type: $(form).attr("method"),
        url: $(form).attr("action"),
        data: data,
        dataType: "json",
        success: function(response) {
          numberOfForms = numberOfForms - 1;
          if (numberOfForms === 0) {
            return window.location.href = $target.attr("href");
          }
        }
      });
    });
    return false;
  });
});