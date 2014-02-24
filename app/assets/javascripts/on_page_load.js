var ready = function() {
  centerIt($(".container"));
};

// on initial page load
$(document).ready(ready);
// on turbolinks page load
$(document).on('page:load', ready);
