$(document).on("page:change", function() {
  return $("a.content-module").on("click", function(event) {
    var $target, taskStatusId;
    $target = $(event.currentTarget);
    taskStatusId = $target.data("task-status-id");
    if (taskStatusId) {
      return $.ajax({
        async: false,
        dataType: "script",
        type: "PUT",
        url: "/participants/task_status/" + taskStatusId
      });
    }
  });
});