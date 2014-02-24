var ready;
ready = function() {


  centerIt($(".container"));


};

$(document).ready(ready);
$(document).on('page:load', ready);