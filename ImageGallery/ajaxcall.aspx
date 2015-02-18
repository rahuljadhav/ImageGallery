<%@ Page Language="C#"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script runat ="server">
        protected void Page_Load(object sender, EventArgs e)
        {
          //  Response.Write("Hello");
            string data = Request.QueryString["src"];
           // Response.Write(data);
            SqlConnection con = new SqlConnection();
            con.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\rjadhav\Documents\Assignment1.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;

            cmd.CommandText = "select imagename,imagepath,uploaddate,imagesize,imagetype from imagedata where ImagePath='" + data + "'";

            cmd.Connection = con;
            con.Open();
           
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.HasRows)
            {
                
                while (dr.Read())
                {
                    
                    string name = dr["ImageName"].ToString();
                    string path = dr["ImagePath"].ToString();
                    string created = dr["UploadDate"].ToString();
                    string size = dr["ImageSize"].ToString();
                    string type = dr["ImageType"].ToString();

                    Response.Write("<hr/><div class=content><b> Name :</b> " + name + "<br/>");
                    Response.Write("<b>Path :</b> " + path + "<br/>");
                    Response.Write("<b>Upload Date : </b>" + created + "<br/>");
                    Response.Write("<b>Image Size : </b>" + size + "<br/>");
                    Response.Write("<b>Image Type : </b>" + type + "<br/></div>");
                }
            }
            con.Close();
            
        }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
