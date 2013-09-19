

function byID(inTagID) {
   
    return document.getElementById(inTagID);
}


var monthtext1 = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
var monthtext2 = ['มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'];

function populatedropdown(dayfield, monthfield, yearfield, LangID) {
    var today = new Date();
    if (dayfield != '') {
        var dayfield = document.getElementById(dayfield);
            for (var i = 1; i < 32; i++) {

            dayfield.options[i] = new Option(i, i);
        }

        dayfield.options[today.getDate()] = new Option(today.getDate(), today.getDate(), true, true); //select today's day
       
      
        
    }

    if (monthfield != '') {
        var monthfield = document.getElementById(monthfield);

        if (LangID == '2') {
            for (var m = 0; m < 12; m++) {
                monthfield.options[m] = new Option(monthtext2[m], m + 1);
            }
            monthfield.options[today.getMonth()] = new Option(monthtext2[today.getMonth()], today.getMonth() + 1, true, true);  //select today's month
            

        }
        else {
            for (var m = 0; m < 12; m++) {
                monthfield.options[m] = new Option(monthtext1[m], m + 1);
            }
            monthfield.options[today.getMonth()] = new Option(monthtext1[today.getMonth()], today.getMonth() + 1, true, true);   //select today's month
            
        }
    }


    var yearfield = document.getElementById(yearfield);
    if (LangID == '2') {
        var thisyear = (today.getFullYear() + 543) - 8;
        for (var y = 0; y < 10; y++) {
            yearfield.options[y] = new Option(thisyear, thisyear - 543);
            thisyear += 1;
        }
        yearfield.options[8] = new Option(today.getFullYear() + 543, today.getFullYear(), true, true); //select today's year
    }
    else {
        debugger;
        var thisyear = (today.getFullYear()) - 8;
        for (var y = 0; y < 10; y++) {
            yearfield.options[y] = new Option(thisyear, thisyear);
            thisyear += 1;
        }
        yearfield.options[8] = new Option(today.getFullYear(), today.getFullYear(), true, true); //select today's year
    }


}


