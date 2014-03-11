(function() {
  // add the Markdown for a link to the selection
  $(document).on('change', '#coach-message-link-selection', function(event) {
    var title = $(event.target.selectedOptions).text();
    var path = $(event.target.selectedOptions).val();

    if (path !== '') {
      $('#message_body').append('\n[' + title + '](' + path + ')');
    }
  });
})();
