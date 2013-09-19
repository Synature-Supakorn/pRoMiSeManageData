Imports System.Net
Imports System.Data
Imports System.Web
Imports System.IO
Imports System.Text
Imports System.Threading
Imports CLRUtility
Partial Public Class ImportData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim folderName As String = ""
        Dim fileName As String = ""
        Dim pathFile As String = ""
        If Request.QueryString("folder") <> "" And Request.QueryString("filename") <> "" Then
            folderName = Request("folder").ToString()
            fileName = Request("filename").ToString()
            pathFile = Request("fullpath").ToString
            fileDownload(fileName, pathFile)
        End If
    End Sub
   
    Private Sub fileDownload(ByVal fileName As String, ByVal fileUrl As String)
        Page.Response.Clear()
        Dim success As Boolean = Utilitys.ResponseDownloadFile(Page.Request, Page.Response, fileName, fileUrl, 1024000)
        If Not success Then
            Response.Write("Downloading Error!")
        End If
        Page.Response.[End]()

    End Sub
End Class