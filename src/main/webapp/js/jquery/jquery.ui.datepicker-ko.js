/* Korean initialisation for the jQuery calendar extension. */
/* Written by DaeKwon Kang (ncrash.dk@gmail.com). */

/**
 * Calendar 기본옵션
 */

var calendarDefaultOption = {
        dateFormat: 'yy-mm-dd',
        showButtonPanel: true,
        showAnim: "slideDown",
//        showOn: "button",
//        buttonImageOnly : true,
//        buttonImage: "images/btn/btn_m.gif",
        buttonText:'달력',
        onSelect: function( selectedDate, inst ) {
                instance = $( this ).data( "datepicker" );
                var option = this.id == instance.settings.minObjId ? "minDate" : "maxDate",
                date = $.datepicker.parseDate(
                                        instance.settings.dateFormat || $.datepicker._defaults.dateFormat,
                                        selectedDate, 
                                        instance.settings );
                var obj = (option == 'minDate') ? instance.settings.maxObjId : instance.settings.minObjId;
                $('#' + obj ).datepicker( "option", option, date );
        }
    };

jQuery(function($){	
    
    $.datepicker.regional['ko'] = {
         //yearRange : "c-30:c+10",
         closeText: '닫기',
         prevText: '이전달',
         nextText: '다음달',
         currentText: '오늘',
         monthNames: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         dayNames: ['일','월','화','수','목','금','토'],
         dayNamesShort: ['일','월','화','수','목','금','토'],
         dayNamesMin: ['일','월','화','수','목','금','토'],
         firstDay: 0,
         shortYearCutoff: 50 ,
         isRTL: false
     };

     // datepicker 설정.
     $.datepicker.setDefaults(
             $.extend(
                 {
                     showMonthAfterYear: true, 
                     showButtonPanel: true,
                     changeMonth: true,
                     changeYear: true
                 },
                 $.datepicker.regional['ko']
             )
     );
});