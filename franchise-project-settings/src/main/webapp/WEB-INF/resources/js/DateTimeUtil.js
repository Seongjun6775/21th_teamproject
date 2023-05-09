/**
 * 
 */
function DateTime() {
}

DateTimeUtil.prototype.dateFormat = function(dateObject, format) {
	if (!format) {
		format = "YYYY-MM-DD"
	}
	
	var year = dateObject.getFullYear();
	var month = dateObject.getMonth() + 1;
	var date = dateObject.getDate();
	
	var result = format.toUpperCase();
	result = result.replace("YYYY", year);
	result = result.replace("MM", month < 10 ? "0" + month : month);
	result = result.replace("DD", date < 10 ? "0" + date : date);
	return result;
}

DateTimeUtil.prototype.today = function(format) {
	return dateFormat(new Date(), format);
}

DateTimeUtil.prototype.addMonth = function(date, add, format) {
	var today = new Date();
	today.setMonth(today.getMonth() + add);
	
	return dateFormat(today, format);
}

DateTimeUtil.prototype.addDate = function(date, add, format) {
	var today = new Date();
	today.setDate(today.getDate() + add);
	
	return dateFormat(today, format);
}