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
                    if (ui.position.left - 10 > ui.originalPosition.left){	// make child pointer
                        $(ui.placeholder).empty();
                        $(ui.placeholder).append("<ul class='ConLibra'>" + $(ui.item).html() + "</ul>");
                    }

                },
                stop: function(event, ui) {
                    if (ui.position.left - 10 > ui.originalPosition.left) {	// make child - could/should add some more check in here.
                        var _depthlevel = _depth(ui.item);
                        if ($(ui.item).prev().is('li') && _depthlevel <=1) {
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

        var _depth = function(context) {
            var level = 1, list = context.closest('ul');
            while (list && list.length > 0 && !list.is('.ui-sortable')) {
                level++;
                list = list.parent().closest('ul');
            }

            return level;
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