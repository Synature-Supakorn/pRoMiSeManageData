function ExportToExcel() {
		var strCopy = document.getElementById("MyTable").innerHTML;
		exportFile("ExportData",strCopy);
		//window.clipboardData.setData("Text", strCopy);
		//var xlApp = new ActiveXObject("Excel.Application");
		// Silent-mode:
		//xlApp.Visible = true;
		//xlApp.DisplayAlerts = false;
		//var xlBook = xlApp.Workbooks.Add();
		//xlBook.worksheets("Sheet1").activate;
		//var XlSheet = xlBook.activeSheet;
		//XlSheet.Name="Export Data";
		//XlSheet.Paste;
}


function createIframe (iframeName, width, height) {
var iframe;
if (document.createElement && (iframe =
document.createElement('iframe'))) {
iframe.name = iframe.id = iframeName;
iframe.width = width;
iframe.height = height;
iframe.src = 'about:blank';
document.body.appendChild(iframe);
}
return iframe;
}

function exportFile(exportAs,exportText) {
var iframe = createIframe ('iframe0', 0, 0);
if (iframe) {
var iframeDoc;
if (iframe.contentDocument) {
iframeDoc = iframe.contentDocument;
}
else if (iframe.contentWindow) {
iframeDoc = iframe.contentWindow.document;
}
else if (window.frames[iframe.name]) {
iframeDoc = window.frames[iframe.name].document;
}
if (iframeDoc) {
iframeDoc.open();
iframeDoc.charset = "utf-8";
iframeDoc.write(exportText);
iframeDoc.close();
var fileName = exportAs+".html";
iframeDoc.execCommand("SaveAs", null,fileName);
}
}
}
