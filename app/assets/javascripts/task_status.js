$(document).on('page:change', function() {
  $("a.module").on("click", function(event) {
    var $target, taskStatusId;
    $target = $(event.currentTarget);
    taskStatusId = $target.data("taskstatusid");
    if (taskStatusId) {
      return $.ajax({
        type: "PUT",
        url: "/participants/task_status/" + taskStatusId,
        dataType: "script"
      });
    }
  });
});