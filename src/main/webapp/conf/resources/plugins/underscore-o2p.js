_.mixin({
    /*^***************字符串相关函数*************************/
    //判断字符对象是否是以某个符号开始，返回true/or
    isStartWith: function(string, start) {
        if (start == null || start == "" || string.length == 0 || start.length > string.length) {
            return false;
        }
        if (string.substr(0, start.length) == start) {
            return true;
        } else {
            return false;
        }
        return true;
    },
    //判断字符对象是否是以某个符号结尾，返回true/or
    isEndWith: function(string, end) {
        if (end == null || end == "" || string.length == 0 || end.length > string.length) {
            return false;
        }
        if (string.substring(string.length - end.length) == end) {
            return true;
        } else {
            return false;
        }
        return true;
    },
    /**
     * url格式校验，支持http,https和ftp协议
     * @param  {[string]}  用于校验的链接
     * @return {Boolean}   返回true/flase
     */
    isURL: function(strUrl) {
        var regular = /^\b(((https?|ftp):\/\/)?[-a-z0-9]+(\.[-a-z0-9]+)*\.(?:com|edu|gov|int|mil|net|org|biz|info|name|museum|asia|coop|aero|[a-z][a-z]|((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]\d)|\d))\b(\/[-a-z0-9_:\@&?=+,.!\/~%\$]*)?)$/i
        if (regular.test(strUrl)) {
            return true;
        } else {
            return false;
        }
    },
    /**
     * 替换字符串中指定的字符,并返回一个新的字符串
     * @param  {[string]} String  待处理的字符串
     * @param  {[string]} targetStr  字符串中即将别替换的字符串段落
     * @param  {[string]} replaceStr 以之替换targetStr
     * @return {[string]}            返回一个新的字符串
     */
    replaceAll: function(string, targetStr, replaceStr) {
        return string.replace(new RegExp(targetStr, "gm"), replaceStr);
    },
    /**
     * 清除字符串左两边的空格
     * @return {[string]} 返回新的字符串
     */
    ltrim: function(string) {
        return string.replace(/^(\s*|　*)/, "");
    },
    /**
     * 清除字符串右两边的空格
     * @return {[string]} 返回新的字符串
     */
    rtrim: function(string) {
        return string.replace(/(\s*|　*)$/, "")
    },
    /**
     * 移除URL的前缀，即'http://' or 'https://' or 'ftp://'
     * @return {[string]} 返回新的字符串
     */
    removeURLPrefix: function(url) {
        var a = url.replace(/：/g, ":").replace(/．/g, ".").replace(/／/g, "/");
        var aa = a.trim().toLowerCase()
        if (aa.indexOf("http://") == 0) {
            a = a.replace(/http:\/\//i, "").trim();
        } else if (aa.indexOf("https://") == 0) {
            a = a.replace(/https:\/\//i, "").trim();
        } else if (aa.indexOf("ftp://") == 0) {
            a = a.replace(/ftp:\/\//i, "").trim();
        }
        return a;
    },
    /*^***************数组相关的函数*************************/
    /**
     * 返回指定值在数组中的索引index，没有找到返回-1
     * @param  {[array]} arr         [数组]
     * @param  {[type]} value       [任意值]
     * @return {[number]}       [返回匹配值的下标]
     */
    indexOf : function(arr,value) {
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] == value) return i;
        }
        return -1;
    },
    /**
     * 移除数组中的指定值
     * @param  {[array]} arr   [数组]
     * @param  {[string]} value [需要移除的值]
     * @return                [无返回，会改变原数组]
     */
    remove : function(arr,value) {
        var index = arr.indexOf(value);
        if (index > -1) {
            arr.splice(index, 1);
        }
    },
    /**
     * 过滤数组中的重复项，返回新的数组
     * @param  {[type]} arr [description]
     * @return {[array]}    [返回新的数组]
     */
    unique :function(arr) {
        arr.sort(); // 先进行数组排序
        var n = [];
        for (var i = 0, y = 0; i < arr.length; i++) {
            // 如果当前项和上一项的值不一样时，则存入结果数组
            if (arr[i] != arr[i - 1]) {
                n[y] = arr[i];
                y++;
            };
        };
        return n;
    },
    /**
     * 按照format格式来格式化数字
     * 0 - (123456) 取整数部分<br>
     * 0.00 - (123456.78) 取2位小数<br>
     * 0.0000 - (123456.7890) 取4位小数<br>
     * 0,000 - (123,456) 取金额格式<br>
     * 0,000.00 - (123,456.78) 取金额格式并2位小数
     * 0,0.00 - (123,456.78)  取简短金额格式
     * 如果需要转换小数位数后为金额格式，需要在format后加 "/i"
     * exp: {value:number('0.00')}
     * 例如: 0.000,00/i
     */
    number: function(v, format) {
        if (!format) {
            return v;
        }
        if (isFinite(v)) {
            v = parseFloat(v);
        }
        v = !isNaN(v) ? v : NaN;
        if (isNaN(v)) {
            return '';
        }
        var comma = ',',
            dec = '.',
            i18n = false,
            neg = v < 0;
        v = Math.abs(v);
        if (format.substr(format.length - 2) == '/i') {
            format = format.substr(0, format.length - 2);
            i18n = true;
            comma = '.';
            dec = ',';
        }
        var hasComma = format.indexOf(comma) != -1,
            psplit = (i18n ? format.replace(/[^\d\,]/g, '') : format.replace(/[^\d\.]/g, '')).split(dec);
        if (1 < psplit.length) {
            v = v.toFixed(psplit[1].length);
        } else if (2 < psplit.length) {
            throw ('NumberFormatException: invalid format, formats should have no more than 1 period: ' + format);
        } else {
            v = v.toFixed(0);
        }
        var fnum = v.toString();
        psplit = fnum.split('.');
        if (hasComma) {
            var cnum = psplit[0],
                parr = [],
                j = cnum.length,
                m = Math.floor(j / 3),
                n = cnum.length % 3 || 3;
            for (var i = 0; i < j; i += n) {
                if (i != 0) {
                    n = 3;
                }
                parr[parr.length] = cnum.substr(i, n);
                m -= 1;
            }
            fnum = parr.join(comma);
            if (psplit[1]) {
                fnum += dec + psplit[1];
            }
        } else {
            if (psplit[1]) {
                fnum = psplit[0] + dec + psplit[1];
            }
        }
        return (neg ? '-' : '') + format.replace(/[\d,?\.?]+/, fnum);
    },
    /**
     * 按照format格式来格式化日期
     * @param  {[object Date]} date   new Date()创建的Date对象
     * @param  {[string]} format  如下
     * yyyy|YYYY - 2016 年份
     * yy|YY - 16 年份
     * MM - 01 月份 补足两位数，下面的日、时、分、秒同理
     * M - 1 月份
     * w|W - 二 周二
     * @return {[type]}        返回字符串
     */
    date: function(date, format) {
        //没有传参，date不是Date对象，format不是字符串，均返回
        if (arguments.length < 2 || !isDate(date) || !isString(format)) {
            alert('arguments is invalid');
            return;
        }
        var str = format;
        var Week = ['日', '一', '二', '三', '四', '五', '六'];
        str = str.replace(/yyyy|YYYY/, date.getFullYear());
        str = str.replace(/yy|YY/, (date.getYear() % 100) > 9 ? (date.getYear() % 100).toString() : '0' + (date.getYear() % 100));
        str = str.replace(/MM/, (date.getMonth() + 1) > 9 ? (date.getMonth() + 1).toString() : '0' + (date.getMonth() + 1));
        str = str.replace(/M/g, (date.getMonth() + 1));
        str = str.replace(/w|W/g, Week[date.getDay()]);
        str = str.replace(/dd|DD/, date.getDate() > 9 ? date.getDate().toString() : '0' + date.getDate());
        str = str.replace(/d|D/g, date.getDate());
        str = str.replace(/hh|HH/, date.getHours() > 9 ? date.getHours().toString() : '0' + date.getHours());
        str = str.replace(/h|H/g, date.getHours());
        str = str.replace(/mm/, date.getMinutes() > 9 ? date.getMinutes().toString() : '0' + date.getMinutes());
        str = str.replace(/m/g, date.getMinutes());
        str = str.replace(/ss|SS/, date.getSeconds() > 9 ? date.getSeconds().toString() : '0' + date.getSeconds());
        str = str.replace(/s|S/g, date.getSeconds());
        return str;
    },
    //通过属性名获取url中？后面对应的属性值
    getURLParameter: function(paramName) {
        var searchString = window.location.search.substring(1),
            i, val, params = searchString.split("&");
        for (i = 0; i < params.length; i++) {
            val = params[i].split("=");
            if (val[0] == paramName) {
                return unescape(val[1]);
            }
        }
        return null;
    },
    /**
     * [getViewPort description]
     * @param  {[Boolean]} includeScollbar true为包含滚动条的宽度，false反之
     * @return {[Object]} 返回一个包含width和height2个属性的对象。width：浏览器视窗的宽度，height为窗口的高度
     */
    getViewPort: function(includeScollbar) {
        var isInclude = includeScollbar || false;
        if (isInclude) {
            var e = window,
                a = 'inner';
            if (!('innerWidth' in window)) {
                a = 'client';
                e = document.documentElement || document.body;
            }
            return {
                width: e[a + 'Width'],
                height: e[a + 'Height']
            }
        } else {
            var de = document.documentElement;
            var db = document.body;
            var viewW = de.clientWidth == 0 ? db.clientWidth : de.clientWidth;
            var viewH = de.clientHeight == 0 ? db.clientHeight : de.clientHeight;
            return {
                width: viewW,
                height: viewH
            }
        }
    },
    /**
     * [scrollTo description]
     * @param  {[jq对象]} el      [jq对象]
     * @param  {[number]} offeset [description]
     */
    scrollTo: function(el, offeset) {
        var pos = (el && el.size() > 0) ? el.offset().top : 0;
        if (el) {
            pos = pos + (offeset ? offeset : -1 * el.height());
        }
        jQuery('html,body').animate({
            scrollTop: pos
        }, 'slow');
    },
    // function to scroll to the top
    scrollTop: function() {
        scrollTo();
    },
    /**
     * 加载远程静态页面
     * @param  {[string]} selector        [选择器]
     * @param  {[string]} url             [请求的远程地址]
     * @param  {[function]} successCallback [成功时执行的方法]
     * @param  {[function]} errorCallback   [失败时执行的方法]
     */
    includeHtml: function(selector, url, successCallback, errorCallback) {
        if (!selector) {
            return
        }
        $(selector).load(url, function(data, textStatus, jqXHR) {
            if (textStatus == 'success') {
                if (successCallback && $.isFunction(successCallback)) {
                    successCallback()
                };
            } else if (textStatus == 'error') {
                if (errorCallback && $.isFunction(errorCallback)) {
                    errorCallback()
                };
            }
        })
    },
    /**
     * 对默认的pluck进行扩展，默认的只能提取一层
     * @param  {[array]} list   [对象数组]
     * @param  {[string]} keys [数组元素的属性名比如“name”,"address.street"]
     * @return {[array]}          返回结果数组
     */
    deepPluck: function(list, keys) {
        if (keys.indexOf(".") < 0) {
            return _.pluck(list, keys)
        }
        var object = _.clone(list);
        var chain = keys.split(".");
        _(chain).each(function(key) {
            object = _.pluck(object, key);
        });
        return object;
    }
});
