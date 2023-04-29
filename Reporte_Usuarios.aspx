<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="Reporte_Usuarios.aspx.cs" Inherits="Examen_Christopher_Berrocal_Ugalde.Capas.Presentacion.Reporte_Usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 style="color:red; width:50%; margin-left:25%;">BIENVENIDO AL REPORTE DE Usuarios</h1>
    <div>          
                 <br/><br/>
                 <asp:GridView ID="GVUsuarios" runat="server" AutoGenerateColumns="True">
                 <Columns>
                    <asp:BoundField DataField="Nombre_Mascota" HeaderText="Nombre de la mascota" />
                    <asp:BoundField DataField="Proxima_fecha" HeaderText="Proxima fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Medico_Asignado" HeaderText="Medico asignado" />
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                 </asp:GridView>
                 <br/>
           
        </div>
</asp:Content>
