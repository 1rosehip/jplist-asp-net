<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="jPList._default" MasterPageFile="~/Site.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadPlaceHolder">

</asp:Content>


<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="BodyPlaceHolder">
    <div class="box" style="margin: 40px 0 25px 0">
	    <div class="center grid-menu">   
    
            <!-- row --> 
            <div class="box text-shadow grid-menu-row">
            
                <!-- sorting -->
	            <div class="left grid-menu-cell">
                    <a title="" href="/pages/htmloutput.aspx">
                        <p class="grid-menu-thumb"><i class="fa fa-code"></i></p>
                        <h2 class="p-lr-20">HTML</h2>
                        <ul class="vmenu-2">
				            <li>ASP.NET with SQL Server</li>
				            <li>that returns HTML as output</li>
			            </ul>
                    </a>
                </div>

                <!-- pagination -->
	            <div class="left grid-menu-cell">
                    <a title="" href="/pages/jsonoutput.aspx">
                        <p class="grid-menu-thumb"><i class="fa fa-bars"></i></p>
                        <h2 class="p-lr-20">JSON</h2>
                        <ul class="vmenu-2">
				            <li>ASP.NET with SQL Server with JSON</li>
				            <li>output and Handlebars template</li>
			            </ul>
                    </a>
                </div>

                <!-- filter and search -->
	            <div class="left grid-menu-cell">
                    <a title="" href="/pages/xmloutput.aspx">
                        <p class="grid-menu-thumb"><i class="fa fa-align-left"></i></p>
                        <h2 class="p-lr-20">XML</h2>
                        <ul class="vmenu-2">
				            <li>ASP.NET with SQL Server with XML</li>
				            <li>output and XSLT template</li>
			            </ul>
                    </a>
                </div>

            </div>

              
        </div>
    </div>
</asp:Content>



        

