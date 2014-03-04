sort = function() {
  return $('#sortable-slides').sortable({
    axis: 'y',
    handle: '.handle',
    update: function() {
      return $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });  
};

$(document).ready(sort)
$(document).on('page:load', sort)
