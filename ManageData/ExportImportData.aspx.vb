Imports System.Data
Imports System.Web
Imports System.IO
Imports System.Text
Imports POSMySQL.POSControl
Imports CLRUtility
Imports pRoMiSe_ManageData_Class
Imports MySql.Data.MySqlClient
Imports System.Net

Partial Public Class ExportImportData
    Inherits System.Web.UI.Page
    Dim objDB As New CDBUtil()
    Dim objCnn As New MySqlConnection()
    Dim LangID As Integer = 1
    Dim StaffID As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            If Session("StaffID") Is Nothing Then
                StaffID = 2
            Else
                StaffID = Session("StaffID")
            End If
            objCnn = objDB.EstablishConnection()
            Select Case Request.QueryString("action")
                Case Is = 1
                    Dim StrRegionID As String = "0"
                    StrRegionID &= Request.Params("regionid")
                    SelectShopList(StrRegionID)
                Case Is = 2
                    Dim StrDataTypeID As String = "0"
                    StrDataTypeID &= Request.Params("datatypeid")
                    SelectDataType(StrDataTypeID)
                Case Is = 3
                    Dim StrRegionID As String = "0"
                    Dim StrDataTypeID As String = "0"
                    Dim FromDate As Date
                    Dim ToDate As Date
                    Dim SelOption As Integer

                    StrRegionID &= Request.Params("regionid")
                    StrDataTypeID &= Request.Params("datatypeid")
                    SelOption = Request.Params("seloption")
                    Try
                        FromDate = New Date(Request.Params("fyear"), Request.Params("fmonth"), Request.Params("fday"))
                        ToDate = New Date(Request.Params("tyear"), Request.Params("tmonth"), Request.Params("tday"))
                        ExportData(StrRegionID, StrDataTypeID, SelOption, FromDate, ToDate)

                    Catch ex As Exception

                    End Try
                Case Is = 4
                    GetFilesImportExport(ConfigurationSettings.AppSettings("ExchangeDirectory") & Request.QueryString("folders") & "\", Request.QueryString("folders"))
                Case Is = 5
                    ImportData(Request.QueryString("folders"))
            End Select
        Catch ex As Exception

        End Try
    End Sub
    Sub SelectDataType(ByVal DataTypeIDList As String)
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
                 " WHERE 0=0 And tf.DataTypeID in(" & DataTypeIDList & ")"
        If ConfigurationSettings.AppSettings("ShopID") = 1 Then
            StrSQL &= " And tf.DataTypeFor=1"
        Else
            StrSQL &= " And tf.DataTypeFor=2"
        End If
        DtData = objDB.List(StrSQL, objCnn)
        objCnn.Close()

        'แสดงประเภทข้อมูล
        Dim StrBD As New StringBuilder
        StrBD.Append("<table class=""blue"">")
        StrBD.Append("<tr><th style=""width:5%;"">#</th><th style=""width:30%;"">Data Type</th><th>Description</th></tr>")
        For i = 0 To DtData.Rows.Count - 1
            StrBD.Append("<tr><td align=""center"">" & i + 1 & "</td><td>" & ObjDataType.ReturnDataTypeName(objCnn, DtData.Rows(i)("DataTypeID")) & "</td><td>" & ObjDataType.ReturnDataTypeDescription(DtData.Rows(i)("DataTypeID")) & "</td></tr>")
        Next
        StrBD.Append("</table>")
        Response.Write(StrBD.ToString)
    End Sub
    Sub SelectShopList(ByVal ShopList As String)
        Dim strBD As New StringBuilder
        Dim dtData As New DataTable
        strBD.Append("Select pl.productlevelid,pg.regionid,pg.regionname,pl.productlevelcode,pl.productlevelname from productlevel pl inner join productregion pg on pl.productlevelid=pg.productlevelid where pl.deleted=0 and pl.showinreport=1 And pg.RegionID IN(" & ShopList & ") order by pl.productlevelname")
        dtData = objDB.List(strBD.ToString, objCnn)
        objCnn.Close()

        strBD = New StringBuilder
        strBD.Append("<table class=""blue"">")
        strBD.Append("<tr><th style=""width:5%;"">#</th><th style=""width:30%;"">RegionName</th><th>Shop In Region</th></tr>")
        If dtData.Rows.Count > 0 Then
            For i As Integer = 0 To dtData.Rows.Count - 1
                strBD.Append("<tr><td align=""center"">" & i + 1 & "</td><td>" & dtData.Rows(i)("regionname") & "</td><td>" & dtData.Rows(i)("productlevelCode") & ":" & dtData.Rows(i)("productlevelName") & "</td></tr>")
            Next
        End If
        strBD.Append("</table>")
        Response.Write(strBD.ToString)
    End Sub
    Sub ExportData(ByVal SelRegionID As String, ByVal SelDataTypeID As String, ByVal SelOption As Integer, ByVal FromDate As Date, ByVal ToDate As Date)
        Try

            Dim ObjDataType As pRoMiSeExportImportDataProcess
            If ConfigurationSettings.AppSettings("ShopID") = 1 Then
                ObjDataType = New pRoMiSeExportImportDataProcess(ConfigurationSettings.AppSettings("DBServer"), ConfigurationSettings.AppSettings("BDName"), ConfigurationSettings.AppSettings("RegionID"), ConfigurationSettings.AppSettings("ComputerID"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ProgramFor.HeadQuarter)
            Else
                ObjDataType = New pRoMiSeExportImportDataProcess(ConfigurationSettings.AppSettings("DBServer"), ConfigurationSettings.AppSettings("BDName"), ConfigurationSettings.AppSettings("RegionID"), ConfigurationSettings.AppSettings("ComputerID"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ProgramFor.Branch)
            End If

            Dim StrBD As New StringBuilder
            Dim DtShopData As New DataTable
            StrBD.Append("select a.RegionID,a.RegionName,b.ProductLevelID,b.ProductLevelName from productregion a, productlevel b where a.productlevelid=b.productlevelid and b.deleted=0 and a.RegionID in(" & SelRegionID & ")")
            StrBD.Append(" group by  a.RegionID,a.RegionName,b.ProductLevelID,b.ProductLevelName")
            DtShopData = objDB.List(StrBD.ToString, objCnn)

            StrBD = New StringBuilder
            Dim DtDataType As New DataTable

            StrBD.Append("SELECT tf.DataTypeID,tt.DataTypeCode,tt.DataTypeName")
            StrBD.Append(" FROM transferdatatypefor tf INNER JOIN transferdatatype tt on tf.DataTypeID=tt.DataTypeID")
            StrBD.Append(" WHERE 0=0 And tf.DataTypeID in(" & SelDataTypeID & ")")
            If ConfigurationSettings.AppSettings("ShopID") = 1 Then
                StrBD.Append(" And tf.DataTypeFor=1")
            Else
                StrBD.Append(" And tf.DataTypeFor=2")
            End If
            DtDataType = objDB.List(StrBD.ToString, objCnn)

            'ExportDataToFolder
            Dim strDateFrom As String = ""
            Dim strDateTo As String = ""

            Select Case SelOption
                Case Is = 0
                    strDateFrom = ""
                    strDateTo = ""
                Case Is = 1
                    strDateFrom = Utilitys.FormatDate(FromDate)
                    strDateTo = Utilitys.FormatDate(ToDate.AddDays(1))
                Case Is = 2
                    strDateFrom = Utilitys.FormatDate(Now.AddYears(-10))
                    strDateTo = ""
            End Select

            Dim regionid() As String
            Dim ToShopID As Integer
            Dim FromShopID As Integer
            If ConfigurationSettings.AppSettings("ShopID") = 1 Then
                FromShopID = 1
            Else
                FromShopID = ConfigurationSettings.AppSettings("ShopID")
            End If


            Dim expression As String
            Dim foundRows() As DataRow

            If SelRegionID.IndexOf(",") >= 0 Then
                regionid = SelRegionID.Split(",")
                For i As Integer = 0 To regionid.Length - 1
                    expression = "regionid=" & regionid(i)
                    foundRows = DtShopData.Select(expression)
                    If foundRows.GetUpperBound(0) >= 0 Then
                        For n As Integer = 0 To foundRows.Length - 1
                            For k = 0 To DtDataType.Rows.Count - 1
                                ObjDataType.ExportDataToSendFolder(DtDataType.Rows(k)("DataTypeID"), objCnn, regionid(i), FromShopID, foundRows(n)("productlevelid"), strDateFrom, strDateTo, StaffID, ProgramCommandData.ExportSelectData)
                            Next k
                        Next
                    End If
                Next
            Else
                expression = "regionid=" & SelRegionID
                foundRows = DtShopData.Select(expression)
                If foundRows.GetUpperBound(0) >= 0 Then
                    For n As Integer = 0 To foundRows.Length - 1
                        For k = 0 To DtDataType.Rows.Count - 1
                            ObjDataType.ExportDataToSendFolder(DtDataType.Rows(k)("DataTypeID"), objCnn, SelRegionID, FromShopID, foundRows(n)("ProductlevelId"), strDateFrom, strDateTo, StaffID, ProgramCommandData.ExportSelectData)
                        Next k
                    Next
                End If
            End If
            GetFilesImportExport(ConfigurationSettings.AppSettings("ExchangeDirectory") & "Send\", "Send")
            objCnn.Close()
        Catch ex As Exception
            Dim StrBD As StringBuilder
            StrBD = New StringBuilder
            StrBD.Append("<table class=""blue"">")
            StrBD.Append("<tr><th style=""width:5%;"">#</th><th>File Name</th></tr>")
            StrBD.Append("<tr><td align=""left"">" & ex.ToString & "</td> </tr>")
            StrBD.Append("</table>")
            Response.Write(StrBD.ToString)
        End Try
    End Sub

    Sub ImportData(ByVal Folders As String)
        Dim ObjDataType As pRoMiSeExportImportDataProcess
        If ConfigurationSettings.AppSettings("ShopID") = 1 Then
            ObjDataType = New pRoMiSeExportImportDataProcess(ConfigurationSettings.AppSettings("DBServer"), ConfigurationSettings.AppSettings("BDName"), ConfigurationSettings.AppSettings("RegionID"), ConfigurationSettings.AppSettings("ComputerID"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ProgramFor.HeadQuarter)
        Else
            ObjDataType = New pRoMiSeExportImportDataProcess(ConfigurationSettings.AppSettings("DBServer"), ConfigurationSettings.AppSettings("BDName"), ConfigurationSettings.AppSettings("RegionID"), ConfigurationSettings.AppSettings("ComputerID"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ConfigurationSettings.AppSettings("ExchangeDirectory"), ProgramFor.Branch)
        End If
        Try
            If ObjDataType.ImportDataFromReceiveFolder() = True Then
                GetFilesImportExport(ConfigurationSettings.AppSettings("ExchangeDirectory") & Folders & "\", Folders)
            Else
                GetFilesImportExport(ConfigurationSettings.AppSettings("ExchangeDirectory") & Folders & "\", Folders)
            End If
        Catch ex As Exception
            GetFilesImportExport(ConfigurationSettings.AppSettings("ExchangeDirectory") & Folders & "\", Folders)
        End Try
    End Sub
    Sub GetFilesImportExport(ByVal PathFile As String, ByVal FolderName As String)
        Dim strBD As New StringBuilder
        Dim Files As String()
        Dim FilesForDel As String()
        Dim FilesQty As Integer = 50
        Dim CurrentDate As Date
        CurrentDate = New Date(Now.Year, Now.Month, 1)
        If PathFile = "D:\pRoMiSe6\ExchangeData\LogFileWebService\" Then
            FilesForDel = Directory.GetFiles(PathFile, "*")
            For i As Integer = 0 To FilesForDel.Length - 1
                Dim MyFileInfo As FileInfo = New FileInfo(FilesForDel(i))
                If MyFileInfo.LastWriteTime < CurrentDate Then
                    File.Delete(FilesForDel(i))
                End If
            Next
        End If
        Files = Directory.GetFiles(PathFile, "*")
        strBD = New StringBuilder
        strBD.Append("<table class=""blue"">")
        strBD.Append("<tr><th style=""width:5%;"">#</th><th>File Name</th><th style=""width:10%;"">Size</th><th style=""width:15%;"">Date</th></tr>")
        For i As Integer = 0 To Files.Length - 1
            Dim MyFileInfo As FileInfo = New FileInfo(Files(i))
            If MyFileInfo.CreationTime > CurrentDate Or MyFileInfo.CreationTime = CurrentDate Then
                If MyFileInfo.Extension = ".zip" Or MyFileInfo.Extension = ".rar" Or MyFileInfo.Extension = ".txt" Then
                    strBD.Append("<tr><td align=""center"">" & i + 1 & ".</td><td><a href=""ImportData.aspx?filename=" & MyFileInfo.Name & "&folder=" & FolderName & "&fullPath=" & MyFileInfo.FullName & """>" & MyFileInfo.Name & "</a></td><td align=""right"">" & Format((MyFileInfo.Length / 1024), "#,##0") & " KB</td><td align=""right"">" & MyFileInfo.CreationTime & "</td></tr>")
                End If
            End If
        Next
        strBD.Append("</table>")
        Response.Write(strBD.ToString)
    End Sub
End Class