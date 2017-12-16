//돈형식으로 변환 input
(function($) {
    $.fn.toPrice = function(cipher) {
        var strb, len, revslice;

        strb = $(this).val().toString();
        strb = strb.replace(/,/g, '');
        strb = $(this).getOnlyNumeric();
        strb = parseInt(strb, 10);
        if (isNaN(strb))
            return $(this).val('');

        strb = strb.toString();
        len = strb.length;

        if (len < 4)
            return $(this).val(strb);

        if (cipher == undefined || !isNumeric(cipher))
            cipher = 3;

        count = len / cipher;
        slice = new Array();

        for ( var i = 0; i < count; ++i) {
            if (i * cipher >= len)
                break;
            slice[i] = strb.slice((i + 1) * -cipher, len - (i * cipher));
        }

        revslice = slice.reverse();
        return $(this).val(revslice.join(','));
    }

    $.fn.getOnlyNumeric = function(data) {
        var chrTmp, strTmp;
        var len, str;

        if (data == undefined) {
            str = $(this).val();
        } else {
            str = data;
        }

        len = str.length;
        strTmp = '';

        for ( var i = 0; i < len; ++i) {
            chrTmp = str.charCodeAt(i);
            if ((chrTmp > 47 || chrTmp <= 31) && chrTmp < 58) {
                strTmp = strTmp + String.fromCharCode(chrTmp);
            }
        }

        if (data == undefined)
            return strTmp;
        else
            return $(this).val(strTmp);
    }

    var isNumeric = function(data) {
        var len, chrTmp;

        len = data.length;
        for ( var i = 0; i < len; ++i) {
            chrTmp = str.charCodeAt(i);
            if ((chrTmp <= 47 && chrTmp > 31) || chrTmp >= 58) {
                return false;
            }
        }

        return true;
    }
})(jQuery);

//콤마
(function($) {

    $.fn.toMoney = function(options) {
        var opts = $.extend({}, $.fn.toMoney.defaults, options);
        return this.each(function() {
            $this = $(this);
            var o = $.meta ? $.extend({}, opts, $this.data()) : opts;
            var str = $this.html();
            $this.html($this.html().toString().replace(
                    new RegExp("(^\\d{"+ ($this.html().toString().length % 3 || -1)+ "})(?=\\d{3})"), "$1" + o.delimiter).replace(/(\d{3})(?=\d)/g, "$1" + o.delimiter));

        });
    };

    $.fn.toMoney.defaults = {
        delimiter : ','
    };

})(jQuery);

//시간
(function($) {

    $.fn.toDateView = function(options) {
        var opts = $.extend({}, $.fn.toDateView.defaults, options);
        return this.each(function() {
            $this = $(this);
            var o = $.meta ? $.extend({}, opts, $this.data()) : opts;
            var str = $this.html();
            if(str.length == 12){
                $this.html(str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8)+" "+str.substring(8,10)+":"+str.substring(10,12));
            }else{
                $this.html(str);
            }
        });
    };
})(jQuery);


//기본세팅
$.ajaxSetup({
    beforeSend: function(xhr) {
        xhr.setRequestHeader("AJAX", true);
    },
    
    error: function(xhr, status, err) {
        
        //Unauthorized 
        if (xhr.status == 401) {
            alert('go 401 page');
        }
        //Forbidden
        else if (xhr.status == 403) {
            alert('go 403 page');
        }
        //Not Acceptable (세션종료) 
        else if (xhr.status == 406) {
            location.href = loginUri;
        }
        else {
            alert('go exception page');
        }
    }
});