/**
 * 
 */
function DateTime() {
}

DateTime.prototype.dateFormat = function(dateObject, format) {


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

DateTime.prototype.today = function(format) {
	return this.dateFormat(new Date(), format);
}

DateTime.prototype.addMonth = function( add, format) {
	var today = new Date();
	today.setMonth(today.getMonth() + add);
	
	return this.dateFormat(today, format);
}

DateTime.prototype.addDate = function(add, format) {
	var today = new Date();
	today.setDate(today.getDate() + add);
	console.log("today",today)
	return this.dateFormat(today, format);

}