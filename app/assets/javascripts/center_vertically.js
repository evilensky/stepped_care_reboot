var centerIt = function (el,top_ratio)  {
    if (!el) {
    	return;
    }
    var moveIt = function () {
        var winWidth = $(window).width();
        var winHeight = $(window).height();
        el
        .css("position","absolute").css("left", ((winWidth / 2) - (el.width() / 2)) + "px")
        .css("top", ((winHeight / 2) - (el.height() / 2))*top_ratio + "px");
    }; 
    $(window).resize(moveIt);
    moveIt();
};