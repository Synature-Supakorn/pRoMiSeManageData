<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExportData.aspx.vb" Inherits="POSManageDataForWeb.ExportData" %>

<html>
<head id="Head1" runat="server">
    <title>Export Data</title>
    <link href="../StyleSheet/admin.css" rel="stylesheet" type="text/css" />

    <script language="JavaScript" src="../StyleSheet/webscript.js"></script>

    <script src="../js/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $('#Next1').attr('disabled', 'disabled');
            $('#Next2').attr('disabled', 'disabled');
            $('#Back1').attr('disabled', 'disabled');
            $('#table2').css('display', 'none');
            $('#table3').css('display', 'none');
            $('#table4').css('display', 'none');
            $('#table5').css('display', 'none');

            // Select Region
            $('.chks_11').live('change', function() {
                $('.chks_12').attr('checked', $(this).is(':checked') ? 'checked' : '');
                if ($('.chks_12').is(':checked') == true) {
                    $('#Next1').attr('disabled', '');
                } else {
                    $('#Next1').attr('disabled', 'disabled');
                }
            });
            $('.chks_12').live('change', function() {
                $('.chks_12').length == $('.chks_12:checked').length ? $('.chks_11').attr('checked', 'checked').next() : $('.chks_11').attr('checked', '').next();
                if ($('.chks_12').is(':checked') == true) {
                    $('#Next1').attr('disabled', '');
                } else {
                    $('#Next1').attr('disabled', 'disabled');
                }
            });
            // Select Data Type
            $('.chks_13').live('change', function() {
                $('.chks_14').attr('checked', $(this).is(':checked') ? 'checked' : '');
                if ($('.chks_14').is(':checked') == true) {
                    $('#Next2').attr('disabled', '');
                } else {
                    $('#Next2').attr('disabled', 'disabled');
                }
            });
            $('.chks_14').live('change', function() {
                $('.chks_14').length == $('.chks_14:checked').length ? $('.chks_13').attr('checked', 'checked').next() : $('.chks_13').attr('checked', '').next();
                if ($('.chks_14').is(':checked') == true) {
                    $('#Next2').attr('disabled', '');

                } else {
                    $('#Next2').attr('disabled', 'disabled');
                }
            });
            $('#Next1').click(function() {
                $('#table1').css('display', 'none');
                $('#table2').css('display', '');
                var arrData = "";
                $('.chks_12').each(function() {
                    if (this.checked) {
                        arrData += "," + this.value;
                    }
                });
                $.ajax({
                    url: 'ExportImportData.aspx?action=1',
                    cache: false,
                    context: document.body,
                    data: ({ regionid: arrData }),
                    success: function(data) {
                        //alert(data);
                        $('#ResponseSelectRegion').html(data);
                    }
                });
            });
            $('#Back2').click(function() {
                $('#table1').css('display', '');
                $('#table2').css('display', 'none');
            });
            $('#Next2').click(function() {
                $('#table1').css('display', 'none');
                $('#table2').css('display', 'none');
                $('#table3').css('display', '');
                if ($('#RdoExportByTime').is(':checked') == true || $('#RdoExportBetweenDate').is(':checked') == true || $('#RdoExportAllData').is(':checked') == true) {
                    $('#Next3').attr('disabled', '');
                } else {
                    $('#Next3').attr('disabled', 'disabled');
                }
                var arrData = "";
                $('.chks_14').each(function() {
                    if (this.checked) {
                        arrData += "," + this.value;
                    }
                });
                $.ajax({
                    url: 'ExportImportData.aspx?action=2',
                    cache: false,
                    context: document.body,
                    data: ({ datatypeid: arrData }),
                    success: function(data) {
                        //alert(data);
                        $('#ResponseSelectDataType').html(data);
                    }
                });
            });
            $('#RdoExportByTime').click(function() {
                $('#Next3').attr('disabled', '');
            });
            $('#RdoExportBetweenDate').click(function() {
                $('#Next3').attr('disabled', '');
            });
            $('#RdoExportAllData').click(function() {
                $('#Next3').attr('disabled', '');
            });
            $('#Back3').click(function() {
                $('#table1').css('display', 'none');
                $('#table2').css('display', '');
                $('#table3').css('display', 'none');
            });
            $('#Next3').click(function() {
                $('#table1').css('display', 'none');
                $('#table2').css('display', 'none');
                $('#table3').css('display', 'none');
                $('#table4').css('display', '');

            });
            $('#Back4').click(function() {
                $('#table1').css('display', 'none');
                $('#table2').css('display', 'none');
                $('#table3').css('display', '');
                $('#table4').css('display', 'none');
            });
            $('#ExportData').click(function() {
                $("#loading").ajaxStart(function() {
                    $(this).show();
                });
                $("#loading").ajaxStop(function() {
                    $(this).hide();
                });

                $('#table1').css('display', 'none');
                $('#table2').css('display', 'none');
                $('#table3').css('display', 'none');
                $('#Back4').attr('disabled', 'disabled');
                $('#ExportData').attr('disabled', 'disabled');
                var selRegion = "";
                var selDatatype = "";
                var selOption = 0;
                $('.chks_12').each(function() {
                    if (this.checked) {
                        selRegion += "," + this.value;
                    }
                });
                $('.chks_14').each(function() {
                    if (this.checked) {
                        selDatatype += "," + this.value;
                    }
                });
                if ($('#RdoExportByTime').is(':checked') == true) {
                    selOption = 0
                }
                if ($('#RdoExportBetweenDate').is(':checked') == true) {
                    selOption = 1
                }
                if ($('#RdoExportAllData').is(':checked') == true) {
                    selOption = 2
                }                
                //alert(selOption);
                $.ajax({
                    url: 'ExportImportData.aspx?action=3',
                    cache: false,
                    context: document.body,
                    data: ({ regionid: selRegion, datatypeid: selDatatype, seloption: selOption, fday: $('#date_startdate_Day').val(), fmonth: $('#date_startdate_Month').val(), fyear: $('#date_startdate_Year').val(), tday: $('#date_enddate_Day').val(), tmonth: $('#date_enddate_Month').val(), tyear: $('#date_enddate_Year').val() }),
                    success: function(data) {
                        //alert(data);
                        $('#ResponseFileName').html(data);
                        $('#table4').css('display', 'none');
                        $('#table5').css('display', '');
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
                    <asp:Label ID="lh" runat="server" Text="Export Data" CssClass="headerText"></asp:Label></div>
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
                <table style="width: 100%;" id="table1">
                    <tr>
                        <td>
                            <%--<fieldset>
                                <legend>
                                    <asp:Label ID="LBSelectShop" runat="server" Text="Select Region For Export Data"></asp:Label></legend>--%>
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <span id="ResponseShop" runat="server"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <button id="Back1" type="button" name="Back1" style="height: 30px; width: 100px;">
                                            Back</button>
                                        <button id="Next1" type="button" name="Next1" style="height: 30px; width: 100px;">
                                            Next</button>&nbsp;
                                    </td>
                                </tr>
                            </table>
                            <%--</fieldset>--%>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" id="table2">
                    <tr>
                        <td>
                            <%-- <fieldset>
                                <legend>
                                    <asp:Label ID="LbDatatype" runat="server" Text="Export Data Type"></asp:Label></legend>--%>
                            <table>
                                <tr>
                                    <td>
                                        <span id="ResponseDataType" runat="server"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <button id="Back2" type="button" name="Back2" style="height: 30px; width: 100px;">
                                            Back</button>
                                        <button id="Next2" type="button" name="Next2" style="height: 30px; width: 100px;">
                                            Next</button>&nbsp;
                                    </td>
                                </tr>
                            </table>
                            <%--</fieldset>--%>
                        </td>
                    </tr>
                </table>
                <table style="width: 550px;" id="table3">
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="Label1" runat="server" Text="Export Time"></asp:Label></legend>
                                <table>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td style="height: 30px;">
                                                        <input id="RdoExportByTime" type="radio" name="ex" value="0" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text="Export From Last Export Time" CssClass="boldText"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 30px;">
                                                        <input id="RdoExportBetweenDate" type="radio" name="ex" value="1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text="Export Between Date" CssClass="boldText"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <div id="date_startdate" runat="server" style="float: left;">
                                                        </div>
                                                        <div id="date_enddate" runat="server" style="float: left;">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 30px;">
                                                        <input id="RdoExportAllData" type="radio" name="ex" value="2" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" Text="Export All Data" CssClass="boldText"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <button id="Back3" type="button" name="Back3" style="height: 30px; width: 100px;">
                                                Back</button>
                                            <button id="Next3" type="button" name="Next3" style="height: 30px; width: 100px;">
                                                Next</button>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" id="table4">
                    <tr>
                        <td>
                            <%--<fieldset>
                                <legend>
                                    <asp:Label ID="LbSelectSummary" runat="server" Text="Export Data Summary"></asp:Label></legend>--%>
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 40%;" valign="top">
                                        <fieldset>
                                            <legend>Region For Export Data</legend>
                                            <asp:Panel ID="Pl1" runat="server" Height="350px" ScrollBars="Auto" Width="100%">
                                                <span id="ResponseSelectRegion" runat="server"></span>
                                            </asp:Panel>
                                        </fieldset>
                                    </td>
                                    <td style="width: 60%;" valign="top">
                                        <fieldset>
                                            <legend>Data Type For Export Data</legend>
                                            <asp:Panel ID="Pl2" runat="server" Height="350px" ScrollBars="Auto" Width="100%">
                                                <span id="ResponseSelectDataType" runat="server"></span>
                                            </asp:Panel>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <button id="Back4" type="button" name="Back4" style="height: 30px; width: 100px;">
                                            Back</button>
                                        <button id="ExportData" type="button" name="ExportData" style="height: 30px; width: 100px;">
                                            Export Data</button>&nbsp;
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
                            <%--</fieldset>--%>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" id="table5">
                    <tr>
                        <td>
                            <a href="ExportData.aspx">Back</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<fieldset>
                                <legend>File Name </legend>--%>
                            <asp:Panel ID="Pl3" runat="server" Height="450px" ScrollBars="Auto" Width="100%">
                                <span id="ResponseFileName"></span>
                            </asp:Panel>
                            <%-- </fieldset>--%>
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
