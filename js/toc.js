function makeTableOfContents(elementToStart, container, start, depth, callback) {
    if (!start) {
        start = 2;
    }

    if (!depth) {
        depth = 3;
    }

    var maxLevel = start + depth;

    var expression = "";
    for (var l = start; l < maxLevel; ++l) {
        expression += "h" + l + ", ";
    }

    var currentList = jQuery(container);
    var levels = [-1];

    jQuery(elementToStart).children(expression).each(function () {
        var element = jQuery(this);

        var level = parseInt(element[0].nodeName.substring(1));

        if (level > levels[0]) {
            currentList = jQuery("<ul>").appendTo(currentList);
            levels.unshift(level);
        } else if (level < levels[0]) {
            while (level < levels[0]) {
                levels.shift();
                currentList = currentList.parent();
            }
        }

        element = jQuery(element);
        var label = element.text();
        var id = element.attr("id");
        var li = jQuery("<li>");
        var a = jQuery("<a>").appendTo(li).attr("href", "#" + id).text(label);

        if (callback) {
            callback(a);
        }

        li.appendTo(currentList)
    });

    while (levels.length > 2) {
        levels.shift();
        currentList = currentList.parent();
    }

    return currentList;
}