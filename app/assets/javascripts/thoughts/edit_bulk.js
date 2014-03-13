(function() {
  $(document).on("change", "#thought_pattern_id", renderDescription);

  function renderDescription(event) {
    var description = $(event.target.selectedOptions).data("description");
    $("#thought-pattern-description").html(description);
  }
})();
