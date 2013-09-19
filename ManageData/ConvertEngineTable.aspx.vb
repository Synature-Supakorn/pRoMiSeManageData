Imports POSMySQL.POSControl
Imports MySql.Data.MySqlClient
Imports System.Text
Partial Public Class ConvertEngineTable
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objDB As New CDBUtil()
        Dim objCnn As New MySqlConnection()
        Dim dt As New DataTable

        objCnn = objDB.EstablishConnection("127.0.1", "db_dksh_branch")
        dt = objDB.List("SHOW TABLES", objCnn)
        Dim strBD As New StringBuilder
        If dt.Rows.Count > 0 Then
            For i As Integer = 0 To dt.Rows.Count - 1
                strBD.Append("ALTER TABLE " & dt.Rows(i)("tables_in_db_dksh_branch") & " ENGINE=INNODB;" & vbCrLf)
            Next
        End If
        myTable.InnerHtml = strBD.ToString

        objCnn = New MySqlConnection()
        objCnn = objDB.EstablishConnection("127.0.1", "mysql")
        dt = objDB.List("SHOW TABLES", objCnn)
        strBD = New StringBuilder
        If dt.Rows.Count > 0 Then
            For i As Integer = 0 To dt.Rows.Count - 1
                strBD.Append("ALTER TABLE " & dt.Rows(i)("tables_in_mysql") & " ENGINE=INNODB;" & vbCrLf)
            Next
        End If
        mySQL.InnerHtml = strBD.ToString
    End Sub

End Class