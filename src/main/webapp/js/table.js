var gvclonetables = [];
jQuery.fn.fixedtableheader = function(options) { 
    var settings = jQuery.extend({ headerrowsize: 1, highlightrow: false, highlightclass: "highlight" }, options); 
    this.each(function(i) { 
        var $tbl = $(this); 
        //var $box = $("#box_"+$tbl.attr("id"));
        var $box = $tbl.parent();
        //alert($box.attr("id"));
        var $tblhfixed = $tbl.find("tr:lt(" + settings.headerrowsize + ")"); 
        var headerelement = "th"; 
        if ($tblhfixed.find(headerelement).length == 0) headerelement = "td"; 
        if ($tblhfixed.find(headerelement).length > 0) { 
            $tblhfixed.find(headerelement).each(function() { 
                $(this).css("width", $(this).width());
             });
            var $clonedTable = $tbl.clone().empty(); 
            gvclonetables.push($clonedTable);
            
            var tblwidth = GetTblWidth($tbl); 
            tblwidth = tblwidth - 17;
            $clonedTable.attr("id", "fixedtableheader" + i).css({ "position": "fixed", "top": "0", "left": $tbl.offset().left }).append($tblhfixed.clone()).width(tblwidth).hide().appendTo($("body"));
            /*
            if (settings.highlightrow) 
                $("tr:gt(" + (settings.headerrowsize - 1) + ")", $tbl).hover(function() { 
                    $(this).addClass(settings.highlightclass); 
                }, function() { 
                    $(this).removeClass(settings.highlightclass); 
                });
            */
            $box.scroll(function() { 
                if (jQuery.browser.msie && jQuery.browser.version == "6.0") 
                    $clonedTable.css({ "position": "absolute", "top": $box.offset().top+1-$(window).scrollTop(), "left": $tbl.offset().left }); 
                else 
                    $clonedTable.css({ "position": "fixed", "top": $box.offset().top+1-$(window).scrollTop(), "left": $tbl.offset().left - $box.scrollLeft() }); 
                var sctop = $box.scrollTop(); 
                var elmtop = $tblhfixed.offset().top;

                if (sctop > 0) 
                    $clonedTable.show(); 
                else 
                    $clonedTable.hide(); 
            });
            $(window).scroll(function() {
                if (jQuery.browser.msie && jQuery.browser.version == "6.0") 
                    $clonedTable.css({ "position": "absolute", "top": $box.offset().top+1-$(window).scrollTop(), "left": $tbl.offset().left }); 
                else 
                    $clonedTable.css({ "position": "fixed", "top": $box.offset().top+1-$(window).scrollTop(), "left": $tbl.offset().left - $box.scrollLeft() }); 
                var sctop = $box.scrollTop(); 
                var elmtop = $tblhfixed.offset().top;

                if (sctop > 0) 
                    $clonedTable.show(); 
                else 
                    $clonedTable.hide(); 
            });
            $box.resize(function() { 
                if ($clonedTable.outerWidth() != $tbl.outerWidth()) { 
                    $tblhfixed.find(headerelement).each(function(index) { 
                        var w = $(this).width(); 
                        $(this).css("width", w); 
                        $clonedTable.find(headerelement).eq(index).css("width", w); 
                    }); 
                    $clonedTable.width($tbl.outerWidth()); 
                } 
                $clonedTable.css("left", $tbl.offset().left); 
            });
            $(window).resize(function() { 
                if ($clonedTable.outerWidth() != $tbl.outerWidth()) { 
                    $tblhfixed.find(headerelement).each(function(index) { 
                        var w = $(this).width(); 
                        $(this).css("width", w); 
                        $clonedTable.find(headerelement).eq(index).css("width", w); 
                    }); 
                    $clonedTable.width($tbl.outerWidth()); 
                } 
                $clonedTable.css("left", $tbl.offset().left); 
                $(window).scroll();
            });
            /*
            $(window).scroll(function() { 
                if (jQuery.browser.msie && jQuery.browser.version == "6.0") 
                    $clonedTable.css({ "position": "absolute", "top": $(window).scrollTop(), "left": $tbl.offset().left }); 
                else 
                    $clonedTable.css({ "position": "fixed", "top": "0", "left": $tbl.offset().left - $(window).scrollLeft() }); 
                var sctop = $(window).scrollTop(); 
                var elmtop = $tblhfixed.offset().top; 
                if (sctop > elmtop && sctop <= (elmtop + $tbl.height() - $tblhfixed.height())) 
                    $clonedTable.show(); 
                else 
                    $clonedTable.hide(); 
            }); 
            */
            /*
            $(window).resize(function() { 
                if ($clonedTable.outerWidth() != $tbl.outerWidth()) { 
                    $tblhfixed.find(headerelement).each(function(index) { 
                        var w = $(this).width(); 
                        $(this).css("width", w); 
                        $clonedTable.find(headerelement).eq(index).css("width", w); 
                    }); 
                    $clonedTable.width($tbl.outerWidth()); 
                } 
                $clonedTable.css("left", $tbl.offset().left); 
            });
            */ 
        } 
    }); 
    
    function GetTblWidth($tbl) { var tblwidth = $tbl.outerWidth(); return tblwidth; } };