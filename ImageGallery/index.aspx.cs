using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Data;

namespace ImageGallery
{
    public partial class index : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            FileStream fs2 = new FileStream(Server.MapPath("ImageName.txt"), FileMode.Open,FileAccess.Read);

            StreamReader sr = new StreamReader(fs2);
            String data = sr.ReadToEnd();

            string[] url = data.Split('|');


            for (int i = 0; i < url.Length; i++)
            {

                HtmlImage obj = new HtmlImage();
                obj.Src = url[i];
                obj.Visible = true;
                obj.Attributes.Add("class", "image");
                divContainer.Controls.Add(obj);


            }
            sr.Close();
            fs2.Close();
           
        }





        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                FileUpload1.SaveAs(Server.MapPath("~//Uploads//" + FileUpload1.FileName));

                FileStream fs1 = new FileStream(Server.MapPath("ImageName.txt"), FileMode.Append, FileAccess.Write);

                StreamWriter sw = new StreamWriter(fs1);
                string url = "~//Uploads//" + FileUpload1.FileName;
                sw.WriteLine(url);

                sw.Write("|");
                sw.Close();
                fs1.Close();


                SqlConnection con = new SqlConnection();
                con.ConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\rjadhav\Documents\Assignment1.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                String name = FileUpload1.FileName;
                String type = FileUpload1.PostedFile.ContentType;
                int size = FileUpload1.PostedFile.ContentLength;
                string url1 = "Uploads/" + FileUpload1.FileName;
                cmd.CommandText = "insert into ImageData values ('" + name + "','" + url1 + "','" + DateTime.Now.ToShortDateString() + "','" + size + "','" + type + "')";

                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();

                con.Close();

                Response.Redirect("~//index.aspx");


            }
            catch (Exception)
            {

            }
        }
    }
}