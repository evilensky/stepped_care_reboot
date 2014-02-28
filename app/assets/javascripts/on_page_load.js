var ready = function() {

  centerIt($("#main-layout"),1);
  centerIt($("#tool-layout"),.5);

};

// on initial page load
$(document).ready(ready);
// on turbolinks page load
$(document).on('page:load', ready);
