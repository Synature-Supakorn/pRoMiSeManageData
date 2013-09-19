Imports System.Data
Imports System.Web
Imports System.IO
Imports System.Text
Imports System.Configuration
Imports POSLanguage
Imports POSMySQL.POSControl
Imports CLRUtility
Imports MySql.Data.MySqlClient
Imports pRoMiSe_ManageData_Class
Partial Public Class ExportData
    Inherits System.Web.UI.Page
    Dim objCnn As New MySqlConnection()
    Dim objDB As New CDBUtil()
    Dim LangID As Integer = 1

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            objCnn = objDB.EstablishConnection()

            If Not Page.IsPostBack Then
                ShopList()
                GetDataType()
                date_startdate.InnerHtml = Utilitys.ShowDropDownListDate("date_startdate", "font_large_black", langID, Now.Day, Now.Month, Now.Year, 1, 1, True, True, True, True)
                date_enddate.InnerHtml = Utilitys.ShowDropDownListDate("date_enddate", "font_large_black", langID, Now.Day, Now.Month, Now.Year, 1, 1, True, True, True, True)
            End If
        Catch ex As Exception

        End Try
    End Sub
   
    Sub GetDataType()
        Dim ObjDataType As pRoMiSeExportImportDataProcess
        If ConfigurationSettings.AppSettings("ShopID") = 1 Then
            ObjDataType = New pRoMiSeExportImportDataProcess(ConfigurationSettings.AppSettings("DBServer"), ConfigurationSettings.AppSettings("BDName"), ConfigurationSettings.AppSettings("RegionID"), ConfigurationSettings.AppSettings("ComputerID"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ProgramFor.HeadQuarter)
        Else
            ObjDataType = New pRoMiSeExportImportDataProcess(ConfigurationSettings.AppSettings("DBServer"), ConfigurationSettings.AppSettings("BDName"), ConfigurationSettings.AppSettings("RegionID"), ConfigurationSettings.AppSettings("ComputerID"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ProgramFor.Branch)
        End If
        Dim DtData As New DataTable
        Dim StrSQL As String = ""
        StrSQL = "SELECT tf.DataTypeID,tt.DataTypeCode,tt.DataTypeName" & _
                 " FROM transferdatatypefor tf INNER JOIN transferdatatype tt on tf.DataTypeID=tt.DataTypeID" & _
                 " WHERE 0=0"
        If ConfigurationSettings.AppSettings("ShopID") = 1 Then
            StrSQL &= " And tf.DataTypeFor=1"
        Else
            StrSQL &= " And tf.DataTypeFor=2"
        End If
        DtData = objDB.List(StrSQL, objCnn)
        Dim StrBD As New StringBuilder
        StrBD.Append("<table class=""blue"">")
        StrBD.Append("<tr><th style=""width:5%;""><input type=""checkbox"" id=""chks_13"" type=""checkbox"" class=""chks_13""></th><th style=""width:30%;"">Data Type</th><th>Description</th></tr>")
        For i = 0 To DtData.Rows.Count - 1
            StrBD.Append("<tr><td align=""center""><input type=""checkbox"" id=""cbd" & i & """ class=""chks_14"" name=""chkd"" value=""" & DtData.Rows(i)("DataTypeID") & """></td><td>" & ObjDataType.ReturnDataTypeName(DtData.Rows(i)("DataTypeID")) & "</td><td>" & ObjDataType.ReturnDataTypeDescription(DtData.Rows(i)("DataTypeID")) & "</td></tr>")
        Next
        StrBD.Append("</table>")
        ResponseDataType.InnerHtml = StrBD.ToString
    End Sub
    Sub ShopList()
        Dim strBD As New StringBuilder
        Dim StrSQLAdditional As String = ""
        If ConfigurationSettings.AppSettings("ShopID") = 1 Then
            StrSQLAdditional = " And regionid <>1"
        Else
            StrSQLAdditional = " And regionid=1"
        End If
        Dim dtData As New DataTable
        Dim dtRegionData As New DataTable
        Dim expression As String
        Dim foundRows() As DataRow

        strBD.Append("SELECT DISTINCT regionid FROM productregion WHERE 0=0 " & StrSQLAdditional & " order by regionname")
        dtData = objDB.List(strBD.ToString, objCnn)

        strBD = New StringBuilder
        strBD.Append("SELECT * FROM productregion ORDER BY regionname")
        dtRegionData = objDB.List(strBD.ToString, objCnn)

        strBD = New StringBuilder
        StrBD.Append("<table class=""blue"">")
        strBD.Append("<tr><th style=""width:5%;""><input type=""checkbox"" id=""chks_11"" type=""checkbox"" class=""chks_11""></th><th >RegionName</th></tr>")
        If dtData.Rows.Count > 0 Then
            For i As Integer = 0 To dtData.Rows.Count - 1
                Dim regionName As String = ""
                expression = "regionid=" & dtData.Rows(i)("regionid")
                foundRows = dtRegionData.Select(expression)
                If foundRows.GetUpperBound(0) >= 0 Then
                    regionName = foundRows(0)("regionname")
                Else
                    regionName = dtData.Rows(i)("regionid")
                End If
                strBD.Append("<tr><td align=""center""><input type=""checkbox"" id=""cbs" & i & """ class=""chks_12"" name=""chks"" value=""" & dtData.Rows(i)("regionid") & """></td><td>" & regionName & "</td></tr>")
            Next
        End If
        StrBD.Append("</table>")
        ResponseShop.InnerHtml = StrBD.ToString
    End Sub
    Private Sub ExportData_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        objCnn.Close()
    End Sub
End Class