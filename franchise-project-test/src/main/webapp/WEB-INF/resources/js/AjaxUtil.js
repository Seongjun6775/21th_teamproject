function AjaxUtil() {
	this.sendTarget = [
		"input[type=checkbox]:checked",
		"input[type=color]",
		"input[type=date]",
		"input[type=email]",
		"input[type=hidden]",
		"input[type=image]",
		"input[type=month]",
		"input[type=number]",
		"input[type=password]",
		"input[type=radio]:checked",
		"input[type=range]",
		"input[type=tel]",
		"input[type=text]",
		"input[type=url]",
		"input[type=time]",
		"input[type=week]",
		"textarea",
		"select"
	]
}

/**
 * 파일 업로드
 * 
 */									/*보내려는폼*/   /*업로드이후 수행함수*/ 
AjaxUtil.prototype.upload = function(formSelector, url, fnCallback, replaceRule) {
	
	if (!replaceRule) {
		replaceRule = {}
	}
	
	var that = this;
	
    function makeFormData() {
        var formData = new FormData();
		
        var form = $(formSelector); /*join을 사용하면 배열 요소를 ", "으로 연결시킨다.*/
        form.find(that.sendTarget.join(", ")).each(function() {
            inputNm = $(this).attr("name") || $(this).attr("id")
            
            if (inputNm) {
	            if (replaceRule[inputNm]) {
	            	inputNm = replaceRule[inputNm];
	            }
	            formData.append(inputNm, $(this).val())
            }
        });

        form.find("input[type=file]").each(function() {
            inputNm = $(this).attr("name") || $(this).attr("id")
            
            if ($(this)[0].files.length > 0) {
	            if (replaceRule[inputNm]) {
	            	inputNm = replaceRule[inputNm];
	            }
            	formData.append(inputNm, $(this)[0].files[0]);
            }
        });
        return formData;
    }

    function send() {
        $.ajax({
            type: "POST",
            url: url,
            processData: false,
            contentType: false,
            data: makeFormData(),
            success: function(response) {
                fnCallback(response);
            }
        });
    }

    send();

};
