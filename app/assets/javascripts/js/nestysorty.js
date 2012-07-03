/*
nestysorty jQuery Plugin 

version : 0.1 

By Simon McManus (simonmcmanus.com)

- customized by Charles Selvarajan
  Dependancy: jQuery.Sortable, jQuery.json

Licence: BSD Open Source Licence

*/

(function($) {
    $.fn.nestysorty = function(options) {
        settings = jQuery.extend({
            callback: undefined,
            nestydepth: 1,
            global: true
        }, options);

        this.each(function() {
            $(this).sortable({
                items: 'li',
                helper: 'helper',
                connectWith: 'ul#list-container',
                placeholder: 'placeholder',
                toleranceElement: '> span',
                handle: 'span.dndhandle',
                forcePlaceholderSize: true,
                forceHelperSize: true,
                sort: function(event, ui) {
                    if (ui.position.left - 10 > ui.originalPosition.left && _isNestingAllowed(ui.item)){	// make child pointer
                        $(ui.placeholder).empty();
                        $(ui.placeholder).append("<ul class='ConLibra'>" + $(ui.item).html() + "</ul>");
                    }
                },
                stop: function(event, ui) {
                    if (ui.position.left - 10 > ui.originalPosition.left && _isNestingAllowed(ui.item)) {	// make child - could/should add some more check in here.
                        if ($(ui.item).prev().is('li')) {
                            if(!$(ui.item).prev().children('ul').length) {  // if already the li has a child ul append the item to it else create new ul
                                $(ui.item).prev().append(ui.item);
                                $(ui.item).wrap("<ul class='ConLibra'></ul>");
                            } else
                                $(ui.item).prev().children('ul').append(ui.item);
                        }
                    } else if (ui.position.left - 10 < ui.originalPosition.left) {	// kill child
                        if ($(ui.item).parent().is('ul')) {	// confirm its not the base level element
                            if ($(ui.item).parent().children().length <= 1) {	// if only item in the list
                                $(ui.item).parent().replaceWith($(ui.item));	// put outside not inside parent li
                            }
                        }
                    }
                    // cleanup unused lists
                    $('ul#list-container, ul#list-container li').each(function() {
                        if ($(this).text() == "")	// if only item and item is empty.
                            $(this).remove();	// remove the parent li
                    });
                    $('ul#list-container').sortable("refresh");
                    // make a callback
                    if (settings.callback !== undefined)
                        settings.callback($.fn.nestysorty.jsonSerializer());
                }
            });
        });
        // tells whether the item(s) can be inserted/appended in the selected place?
        var _isNestingAllowed = function(context) {
            // calculate the depth level relative to root(parent)
            var level = 1, list = context.closest('ul');
            while (list && list.length > 0 && !list.is('.ui-sortable')) {
                level++;
                list = list.parent().closest('ul');
            }
            // find depth level calculating nof child
            var nofchild = function(parent, depth) {
                var result = 0, depth = depth || 0;
                $(parent).children('ul').children('li').each(function (index, child) {
                    result = Math.max(nofchild(child, depth + 1), result);
                });

                return depth ? result + 1 : result;
            }
            // now return whether the total depth is within the allowed range
            return ((level + nofchild(context)) <= settings.nestydepth);
        };

        return this;
    };

    // serialize the sorted li's and return it as json string
    $.fn.nestysorty.jsonSerializer = function() {
        var _buildSpec = function(liList) {
            var spec = [];
            liList.each(function() {
                if(this.id != 'empty') {
                    var li=this;
                    var node = {
                        title: li.id
                    };
                    node.children = _buildSpec($(li).children('ul').children('li'));
                    spec.push(node);
                }
            });
            return spec;
        }

        var hash = [];
        $('ul#list-container:first').children().each(function() {
            hash.push(_buildSpec($(this)));
        });

        return hash;
    };
})(jQuery);