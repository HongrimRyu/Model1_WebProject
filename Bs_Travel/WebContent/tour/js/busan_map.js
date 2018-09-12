Number.prototype.formatMoney = function (c, d, t) {
    var n = this,
        c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};

$(document).ready(function () {
   
    $('.dynomap').dynomap({
        'background': {
            'image': '../tour/img/busan_background.png',
            'title': ''
        },
        'hotSpots': [
            {
                'area': '182, 204,149, 205,135, 213,130, 222,123, 220,117, 211,111, 209,111, 213,117, 223,99, 221,87, 225,75, 239,75, 246,81, 254,92, 277,99, 283,91, 285,61, 280,39, 293,23, 294,10, 290,4, 294,20, 323,42, 329,44, 340,49, 347,55, 352,53, 356,43, 361,47, 364,43, 371,34, 371,33, 384,3, 408,3, 451,36, 508,47, 514,57,501,69, 475,71, 423,76, 415,114, 419,130, 403,133, 373,138, 367,139, 353,203, 190,201, 209,192, 228,192, 239,178, 245,171, 255,170, 296,160, 333,153, 344,146, 352',
                'title': '강서구',
                'overImg': '../tour/img/busan_gangseogu.png',
                'downImg': '../tour/img/busan_gangseogu.png',
                'clickedImg': '../tour/img/busan_gangseogu.png',
                'visitedImg': ''
            },
            {
                'area': '232, 143,214, 162,203, 190,201, 209,192, 228,192, 239,205, 248,228, 249,242, 238,249, 238,250, 233,259, 231,260, 214,250, 148,242, 162,252, 173,252, 181,258, 183,252, 197,266, 202,267, 207',
                'title': '북구',
                'overImg': '../tour/img/busan_bukgu.png',
                'downImg': '../tour/img/busan_bukgu.png',
                'clickedImg': '../tour/img/busan_bukgu.png',
                'visitedImg': ''
            },
            {
                'area': '178, 245,171, 255,170, 296,160, 333,173, 334,183, 341,188, 341,195, 336,212, 330,213, 325,211, 314,214, 312,192, 239,205, 248,228, 249,228, 258,219, 270,219, 281,226, 292,225, 307,221, 311',
                'title': '사상구',
                'overImg': '../tour/img/busan_sasanggu.png',
                'downImg': '../tour/img/busan_sasanggu.png',
                'clickedImg': '../tour/img/busan_sasanggu.png',
                'visitedImg': ''
            },
            {
                'area': '153, 344,146, 352,148, 360,146, 368,146, 379,156, 371,156, 359,161, 353,167, 354,168, 365,163, 373,163, 406,167, 417,176, 426,181, 431,178, 443,188, 431,185, 428,195, 427,196, 421,187, 419,188, 411,198, 408,201, 414,204, 426,207, 429,213, 420,212, 415,206, 410,206, 386,211, 377,216, 380,160, 333,173, 334,183, 341,188, 341,195, 336,212, 330,212, 344,219, 350,218, 358,224, 365,226, 371,220, 378,224, 386,216, 384',
                'title': '사하구',
                'overImg': '../tour/img/busan_sahagu.png',
                'downImg': '../tour/img/busan_sahagu.png',
                'clickedImg': '../tour/img/busan_sahagu.png',
                'visitedImg': ''
            },
            {
                'area': '291, 109,278, 125,262, 116,250, 148,242, 162,252, 173,252, 181,258, 183,252, 197,266, 202,267, 207,283, 202,295, 216,304, 217,314,224,319, 222,330, 215,323, 204,338, 198,312, 104,338, 118,333, 126,335, 138,325, 149,337,163,352, 175',
                'title': '금정구',
                'overImg': '../tour/img/busan_geumjeonggu.png',
                'downImg': '../tour/img/busan_geumjeonggu.png',
                'clickedImg': '../tour/img/busan_geumjeonggu.png',
                'visitedImg': ''
            },
            {
                'area': '255, 244,273, 244,287, 236,299, 244,317, 245,249, 238,250, 233,259, 231,260, 214,267, 207,283, 202,295, 216,304, 217,314,224,319, 222,328,241,325, 260',
                'title': '동래구',
                'overImg': '../tour/img/busan_dongnaegu.png',
                'downImg': '../tour/img/busan_dongnaegu.png',
                'clickedImg': '../tour/img/busan_dongnaegu.png',
                'visitedImg': ''
            },
            {
                'area': '258, 254,268, 257,275, 264,288, 264,287, 276,291, 288,303, 283,305, 268,307, 259,318, 263,325, 260,255, 244,273, 244,287, 236,299, 244,317, 245',
                'title': '연제구',
                'overImg': '../tour/img/busan_yeonjegu.png',
                'downImg': '../tour/img/busan_yeonjegu.png',
                'clickedImg': '../tour/img/busan_yeonjegu.png',
                'visitedImg': ''
            },
            {
                'area': '228, 258,219, 270,219, 281,226, 292,225, 307,221, 311,224, 317,231, 315,234, 317,240, 317,249, 303,256, 302,266,309,228, 249,242, 238,249, 238,255, 244,258, 254,268, 257,275, 264,288, 264,287, 276,291, 288,285, 299,276, 301,274, 309',
                'title': '부산진구',
                'overImg': '../tour/img/busan_busanjingu.png',
                'downImg': '../tour/img/busan_busanjingu.png',
                'clickedImg': '../tour/img/busan_busanjingu.png',
                'visitedImg': ''
            },
            {
                'area': '212, 344,219, 350,218, 358,224, 365,226, 371,220, 378,224, 386,216, 384,221, 416,224, 419,233, 410,233, 400,227, 391,229, 388,237, 388,239, 385,239, 366,231, 355,236, 346,221, 311,224, 317,231, 315,234, 317,212, 330,213, 325,211, 314,214, 312,232, 332,237, 338',
                'title': '서구',
                'overImg': '../tour/img/busan_seogu.png',
                'downImg': '../tour/img/busan_seogu.png',
                'clickedImg': '../tour/img/busan_seogu.png',
                'visitedImg': ''
            },
            {
                'area': '232, 332,237, 338,246, 340,252, 345,261, 342,260, 329,265, 335,270, 335,270, 327,274, 309,275, 326,234, 317,240, 317,249, 303,256, 302,266,309',
                'title': '동구',
                'overImg': '../tour/img/busan_donggu.png',
                'downImg': '../tour/img/busan_donggu.png',
                'clickedImg': '../tour/img/busan_donggu.png',
                'visitedImg': ''
            },
            {
                'area': '246, 366,250, 363,251, 355,257, 354,253, 350,237, 338,246, 340,252, 345,239, 366,231, 355,236, 346',
                'title': '중구',
                'overImg': '../tour/img/busan_junggu.png',
                'downImg': '../tour/img/busan_junggu.png',
                'clickedImg': '../tour/img/busan_junggu.png',
                'visitedImg': ''
            },
            {
                'area': '336, 34,328, 79,312, 104,338, 118,333, 126,335, 138,325, 149,337,163,352, 175,361, 178,364, 192,378, 207,368, 220,372, 231,391, 233,394, 248,406, 234,418, 253,433, 252,464, 95,489, 75,502, 87,506, 71,484, 55,488, 40,465, 4,424, 14,400, 3,396, 40,374, 48',
                'title': '기장군',
                'overImg': '../tour/img/busan_gijanggun.png',
                'downImg': '../tour/img/busan_gijanggun.png',
                'clickedImg': '../tour/img/busan_gijanggun.png',
                'visitedImg': ''
            },
            {
                'area': '328,241,325, 260,337, 280,348, 291,363, 291,375, 284,389, 386,403, 282,407, 264,352, 175,361, 178,364, 192,378, 207,368, 220,372, 231,391, 233,394, 248,406, 234,319, 222,330, 215,323, 204,338, 198',
                'title': '해운대구',
                'overImg': '../tour/img/busan_haeundaegu.png',
                'downImg': '../tour/img/busan_haeundaegu.png',
                'clickedImg': '../tour/img/busan_haeundaegu.png',
                'visitedImg': ''
            },
            {
                'area': '312, 306,319, 312,328, 311,325, 291,336, 289,325, 260,337, 280,348, 291,303, 283,305, 268,307, 259,318, 263',
                'title': '수영구',
                'overImg': '../tour/img/busan_suyeonggu.png',
                'downImg': '../tour/img/busan_suyeonggu.png',
                'clickedImg': '../tour/img/busan_suyeonggu.png',
                'visitedImg': ''
            },
            {
                'area': '285, 299,276, 301,274, 309,275, 326,380, 329,278, 341,281, 348,286, 351,299, 345,304, 348,305,362,321, 355,332, 360,340, 353,340, 334,329, 319,291, 288,303, 283,312, 306,319, 312',
                'title': '남구',
                'overImg': '../tour/img/busan_namgu.png',
                'downImg': '../tour/img/busan_namgu.png',
                'clickedImg': '../tour/img/busan_namgu.png',
                'visitedImg': ''
            },
            {
                'area': '245, 375,250, 383,264, 389,273, 397,284, 406,290, 407,297, 419,303, 421,309, 408,307, 402,301, 398,294, 396,295, 392,305, 392,307, 383,302, 387,294, 388,294, 381,284, 365,266, 356,259, 362,246, 366,250, 363',
                'title': '영도구',
                'overImg': '../tour/img/busan_yeongdogu.png',
                'downImg': '../tour/img/busan_yeongdogu.png',
                'clickedImg': '../tour/img/busan_yeongdogu.png',
                'visitedImg': ''
            }
        ],
        // Click event callback
        clicked: function ($this, index) {
            var title = [
                '강서구',
                '북구',
                '사상구',
                '사하구',
                '금정구',
                '동래구',
                '연제구',
                '부산진구',
                '서구',
                '동구',
                '중구',
                '기장군',
                '해운대구',
                '수영구',
                '남구',
                '영도구'
            ];

            //alert('title['+index+']=' + title[index] + '\n');
            gis_print_gu_info(title[index]);
        }
    });

    function gis_print_gu_info(addressGu) {
    	var s ="";
    	if(addressGu=="수영구") s="sooyoung";
    	else if(addressGu=="동래구") s="dongrae";
    	else if(addressGu=="해운대구") s="haundae";
    	else if(addressGu=="기장군") s="kijang";
    	else if(addressGu=="중구") s="junggu";
    	else if(addressGu=="부산진구") s="busanjin";
    	else s="soon"

    	
        var output = '\n';
        output += '                    <section>\n';
        output += '                        <h2 style="width: 700px;">이 지역은 부산광역시 ' + addressGu + ' 입니다.</h2>\n';
        output += '                        <img src="../images/tour/'+ s +'.png" style="width: 700px; height:481px;">\n';
        output += '                    </section>\n';    

        $('.gis-gu-info').html(output);
    }
});

