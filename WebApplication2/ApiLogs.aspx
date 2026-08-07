<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ApiLogs.aspx.cs"
Inherits="WebApplication2.ApiLogs" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>API Logs</title>

    <style>

        body{
            font-family:Arial;
            margin:30px;
        }

        h2{
            color:#003366;
        }

        .grid{

            width:100%;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<h2>IMPS API Logs</h2>

<asp:GridView ID="gvLogs"
runat="server"
AutoGenerateColumns="False"
CssClass="grid"
BorderWidth="1"
GridLines="Both">

<Columns>

<asp:BoundField DataField="LogID" HeaderText="Log ID"/>

<asp:BoundField DataField="RequestID" HeaderText="Request ID"/>

<asp:BoundField DataField="APIName" HeaderText="API"/>

<asp:BoundField DataField="RequestType" HeaderText="Method"/>

<asp:BoundField DataField="Status" HeaderText="Status"/>

<asp:BoundField DataField="ErrorMessage" HeaderText="Error"/>

<asp:BoundField DataField="CreatedOn" HeaderText="Timestamp"/>

</Columns>

</asp:GridView>

</form>

</body>

</html>