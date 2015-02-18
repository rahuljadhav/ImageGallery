<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="ImageGallery.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="style.css" />
    <script type="text/javascript" src="jquery-1.9.1.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="header">
        <div class="logo">
        </div>
        <div class="fileUpControl">
            <asp:FileUpload ID="FileUpload1" runat="server" BorderColor="#3399FF" BorderStyle="Solid" />
        </div>
        <div class="btnDiv">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" class="btn" />
        </div>
        <%--<div class="imageBig">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Image ID="Image1" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>--%>
            
                    <script type="text/javascript">

                        $(document).ready(function () {              // When site loaded, load the Popupbox First   

                            $('#popupBoxClose').click(function () {
                                unloadPopupBox();
                            });

                            function unloadPopupBox() {    // TO Unload the Popupbox             
                                $('#popup_box').fadeOut("slow");

                            }
                            $(".image").on("click", function () {

                                loadPopupBox();
                                $("#poppedUpImage").attr('src', $(this).attr("src"));
                                var src = $(this).attr("src");
                                $.ajax({
                                    contentType: "text/html; charset=utf-8",
                                    url: "ajaxcall.aspx",
                                    data: "src=" + src,
                                    dataType: "html",
                                    success: onSuccess,
                                    error: onError
                                });

                            });
                            function loadPopupBox() {    // To Load the Popupbox             
                                $('#popup_box').fadeIn("slow");

                            }
                            function onSuccess(result) {
                               $("#content").html(result);
                            }

                            function onError(result) {
                                // ajax call failed
                                alert(result.status + ': ' + result.statusText);
                            }
                        }); 
                    </script>
                    <span runat="server" id="divContainer"></span>
                
        </div>
    <%--</div>--%>
    <div id="popup_box">
        <!-- OUR PopupBox DIV-->
        <span id="img"></span>
        <img id="poppedUpImage" alt="Zoomed image" height="400px" width="650px" />
        <div id="content"></div>
        <a id="popupBoxClose">Close</a>
    </div>
    </form>
</body>
</html>
