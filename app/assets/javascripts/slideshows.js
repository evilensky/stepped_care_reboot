// $(document).on('page:load', function() {
  $(function() {
    return $('#sortable-slides').sortable({
      axis: 'y',
      handle: '.handle',
      update: function() {
        return $.post($(this).data('update-url'), $(this).sortable('serialize'));
      }
    });
  });
// });
