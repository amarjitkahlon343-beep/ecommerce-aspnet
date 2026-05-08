using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecomwebsite.User
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Url.AbsoluteUri.ToString().Contains("Default.aspx"))
            {
                //Usercontrol load
                Control sliderUserControl = (Control)Page.LoadControl("SliderUserControl.ascx");
                PanelSliderUC.Controls.Add(sliderUserControl);
            }
        }
    }
}