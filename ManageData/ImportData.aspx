<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ImportData.aspx.vb" Inherits="POSManageDataForWeb.ImportData" %>

<html>
<head id="Head1" runat="server">
    <title>Exchange Data</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <script src="../js/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $('#table5').css('display', '');
            $('#SendFile').css('color','black');
            $('#BtnImportData1').css('display', 'none');
            $('#BtnImportData').css('display', 'none');
            $.ajax({
                url: 'ExportImportData.aspx?action=4&folders=Send',
                cache: false,
                context: document.body,
                success: function(data) {
                    //alert(data);
                    $('#ResponseFileNameSend').html(data);
                }
            });

            $('#recvfile').click(function() {
                $.ajax({
                    url: 'ExportImportData.aspx?action=4&folders=Recv',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileName').html(data);
                        $('#table1').css('display', '');
                        $('#table2').css('display', 'none');
                        $('#table3').css('display', 'none');
                        $('#table4').css('display', 'none');
                        $('#table5').css('display', 'none');
                        $('#table6').css('display', 'none');
                        $('#recvfile').css('color','black');
                        $('#rejectfile').css('color','blue');
                        $('#Errorfile').css('color','blue');
                        $('#SendFile').css('color','blue');
                        $('#BackupFile').css('color', 'blue');
                        $('#LogWebservice').css('color', 'blue');
                        $('#BtnImportData').css('display', '');
                        $('#BtnImportData1').css('display', '');
                    }
                });

            });
            $('#rejectfile').click(function() {
                $.ajax({
                    url: 'ExportImportData.aspx?action=4&folders=Reject',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileNameReject').html(data);
                        $('#table1').css('display', 'none');
                        $('#table2').css('display', '');
                        $('#table3').css('display', 'none');
                        $('#table4').css('display', 'none');
                        $('#table5').css('display', 'none');
                        $('#table6').css('display', 'none');
                        $('#recvfile').css('color','blue');
                        $('#rejectfile').css('color','black');
                        $('#Errorfile').css('color','blue');
                        $('#SendFile').css('color','blue');
                        $('#BackupFile').css('color', 'blue');
                        $('#LogWebservice').css('color', 'blue');
                    }
                });

            });
            $('#Errorfile').click(function() {
                $.ajax({
                    url: 'ExportImportData.aspx?action=4&folders=error',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileNameError').html(data);
                        $('#table1').css('display', 'none');
                        $('#table2').css('display', 'none');
                        $('#table3').css('display', '');
                        $('#table4').css('display', 'none');
                        $('#table5').css('display', 'none');
                        $('#table6').css('display', 'none');
                        $('#recvfile').css('color','blue');
                        $('#rejectfile').css('color','blue');
                        $('#Errorfile').css('color','black');
                        $('#SendFile').css('color','blue');
                        $('#BackupFile').css('color', 'blue');
                        $('#LogWebservice').css('color', 'blue');
                    }
                });

            });
            $('#BackupFile').click(function() {
                $.ajax({
                    url: 'ExportImportData.aspx?action=4&folders=backup',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileNameBackup').html(data);
                        $('#table1').css('display', 'none');
                        $('#table2').css('display', 'none');
                        $('#table3').css('display', 'none');
                        $('#table4').css('display', '');
                        $('#table5').css('display', 'none');
                        $('#table6').css('display', 'none');
                        $('#recvfile').css('color','blue');
                        $('#rejectfile').css('color','blue');
                        $('#Errorfile').css('color','blue');
                        $('#SendFile').css('color','blue');
                        $('#BackupFile').css('color', 'black');
                        $('#LogWebservice').css('color', 'blue');
                    }
                });

            });
            $('#SendFile').click(function() {
                $.ajax({
                    url: 'ExportImportData.aspx?action=4&folders=send',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileNameSend').html(data);
                        $('#table1').css('display', 'none');
                        $('#table2').css('display', 'none');
                        $('#table3').css('display', 'none');
                        $('#table4').css('display', 'none');
                        $('#table5').css('display', '');
                        $('#table6').css('display', 'none');
                        $('#recvfile').css('color','blue');
                        $('#rejectfile').css('color','blue');
                        $('#Errorfile').css('color','blue');
                        $('#SendFile').css('color','black');
                        $('#BackupFile').css('color', 'blue');
                        $('#LogWebservice').css('color', 'blue');

                    }
                });

            });
            $('#LogWebservice').click(function() {
                $.ajax({
                url: 'ExportImportData.aspx?action=4&folders=LogFileWebService',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                    $('#ResponseFileLogFileWebService').html(data);
                        $('#table1').css('display', 'none');
                        $('#table2').css('display', 'none');
                        $('#table3').css('display', 'none');
                        $('#table4').css('display', 'none');
                        $('#table5').css('display', 'none');
                        $('#table6').css('display', '');
                        $('#recvfile').css('color', 'blue');
                        $('#rejectfile').css('color', 'blue');
                        $('#Errorfile').css('color', 'blue');
                        $('#SendFile').css('color', 'blue');
                        $('#BackupFile').css('color', 'blue');
                        $('#LogWebservice').css('color', 'black');

                    }
                });

            });
            $('#BtnImportData').click(function() {
                $('#BtnImportData').attr('disabled', 'disabled');
                $('#BtnImportData1').attr('disabled', 'disabled');
                $("#loading").ajaxStart(function() {
                    $(this).show();
                });
                $("#loading").ajaxStop(function() {
                    $(this).hide();
                });
                $.ajax({
                    url: 'ExportImportData.aspx?action=5&folders=Recv',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileName').html(data);
                        $('#table1').css('display', '');
                        $('#table2').css('display', 'none');
                        $('#BtnImportData').attr('disabled', '');
                        $('#BtnImportData1').attr('disabled', '');
                    }
                });

            });
            $('#BtnImportData1').click(function() {
                $('#BtnImportData').attr('disabled', 'disabled');
                $('#BtnImportData1').attr('disabled', 'disabled');
                $("#loading").ajaxStart(function() {
                    $(this).show();
                });
                $("#loading").ajaxStop(function() {
                    $(this).hide();
                });
                $.ajax({
                    url: 'ExportImportData.aspx?action=5&folders=Recv',
                    cache: false,
                    context: document.body,
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileName').html(data);
                        $('#table1').css('display', '');
                        $('#table2').css('display', 'none');
                        $('#BtnImportData').attr('disabled', '');
                        $('#BtnImportData1').attr('disabled', '');
                    }
                });

            });
        });
      
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <table bgcolor="White" cellpadding="0" cellspacing="0">
        <tr style="background-color: #EEEEEE">
            <td height="35" style="background-image: url('../images/headerstub.jpg')">
                &nbsp; &nbsp;
            </td>
            <td colspan="2" style="background-image: url('../images/headerbg2000.jpg')">
                <div>
                    <asp:Label ID="lh" runat="server" Text="Exchange Data" CssClass="headerText"></asp:Label></div>
            </td>
            <td rowspan="99" style="background-color: #003366; width: 1px;">
                <img src="../images/clear.gif" height="1px" width="1px">
            </td>
        </tr>
        <tr style="background-color: #666666">
            <td width="3%" height="1">
            </td>
            <td width="94%">
            </td>
            <td width="3%">
            </td>
        </tr>
        <tr>
            <td height="10" colspan="3">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <a id="SendFile" href="#">Send</a> &nbsp;| &nbsp;<a id="recvfile" href="#">Recv</a>
                            &nbsp;| &nbsp; <a id="rejectfile" href="#">Reject</a> &nbsp;| &nbsp; <a id="BackupFile"
                                href="#">Backup</a> &nbsp;| &nbsp; <a id="Errorfile" href="#">Error</a> &nbsp;| &nbsp;<a id="LogWebservice" href="#"> Log WebService</a>
                            <table style="width: 100%;" id="table5">
                                <tr>
                                    <td>
                                        <span id="ResponseFileNameSend"></span>
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%;" id="table1">
                                <tr>
                                    <td align="right" colspan="2">
                                        <button id="BtnImportData1" type="button" name="BtnImportData1" style="height: 30px;
                                            width: 100px;">
                                            Import Data</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span id="ResponseFileName"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <button id="BtnImportData" type="button" name="BtnImportData" style="height: 30px;
                                            width: 100px;">
                                            Import Data</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div id="loading" style="display: none">
                                            <img src="../images/loading4.gif" />
                                            Loading...
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%;" id="table2">
                                <tr>
                                    <td>
                                        <span id="ResponseFileNameReject"></span>
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%;" id="table3">
                                <tr>
                                    <td>
                                        <span id="ResponseFileNameError"></span>
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%;" id="table4">
                                <tr>
                                    <td>
                                        <span id="ResponseFileNameBackup"></span>
                                    </td>
                                </tr>
                            </table>
                             <table style="width: 100%;" id="table6">
                                <tr>
                                    <td>
                                        <span id="ResponseFileLogFileWebService"></span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" height="30">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
        <tr>
            <td height="50" colspan="3" style="background-image: url('../images/footerbg2000.gif')">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #999999; height: 1px;">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
