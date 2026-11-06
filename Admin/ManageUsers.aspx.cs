using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

public partial class Admin_ManageUsers : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    private static readonly string[] AllowedUserSortColumns = new string[] { "UserID", "FullName", "Email", "Role", "IsActive", "CreatedAt" };

    string SortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    string SortExpression
    {
        get { return ViewState["SortExpression"] as string ?? "UserID"; }
        set { ViewState["SortExpression"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        if (!IsPostBack)
            LoadUsers();
    }

    void LoadUsers()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = "SELECT * FROM Users WHERE 1=1";

            if (ddlRole.SelectedValue != "")
                query += " AND Role=@role";

            if (txtSearch.Text.Trim() != "")
                query += " AND (FullName LIKE @search OR Email LIKE @search)";

            // Whitelist sort expression and sort direction against SQL injection
            string safeColumn = SecurityHelper.SanitizeSortColumn(SortExpression, AllowedUserSortColumns, "UserID");
            string safeDirection = SecurityHelper.SanitizeSortDirection(SortDirection);
            query += " ORDER BY " + safeColumn + " " + safeDirection;

            SqlCommand cmd = new SqlCommand(query, con);

            if (ddlRole.SelectedValue != "")
                cmd.Parameters.AddWithValue("@role", ddlRole.SelectedValue);

            if (txtSearch.Text.Trim() != "")
                cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text.Trim() + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }
    }

    protected void gvUsers_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvUsers.PageIndex = e.NewPageIndex;
        LoadUsers();
    }

    protected void gvUsers_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        SortExpression = SecurityHelper.SanitizeSortColumn(e.SortExpression, AllowedUserSortColumns, "UserID");
        SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
        LoadUsers();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadUsers();
    }

    protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        int userId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "ToggleUser")
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Users SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END WHERE UserID=@id", con);
                cmd.Parameters.AddWithValue("@id", userId);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "DeleteUser")
            {
                // Prevent self-deletion of currently logged in admin
                int currentAdminId = 0;
                int.TryParse(Session["AdminID"].ToString(), out currentAdminId);
                if (userId == currentAdminId)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Cannot delete your own admin account.');", true);
                    return;
                }

                // 1️⃣ Get profile image path
                SqlCommand imgCmd = new SqlCommand("SELECT ProfileImage FROM Users WHERE UserID=@id", con);
                imgCmd.Parameters.AddWithValue("@id", userId);

                string imgPath = imgCmd.ExecuteScalar() as string;

                if (!string.IsNullOrEmpty(imgPath))
                {
                    string fullPath = Server.MapPath(imgPath.StartsWith("~") ? imgPath : ("~/" + imgPath.TrimStart('/')));
                    if (System.IO.File.Exists(fullPath))
                    {
                        System.IO.File.Delete(fullPath);
                    }
                }

                // Delete tokens if table exists
                try
                {
                    using (SqlCommand delTokens = new SqlCommand("DELETE FROM UserAuthTokens WHERE UserID=@id", con))
                    {
                        delTokens.Parameters.AddWithValue("@id", userId);
                        delTokens.ExecuteNonQuery();
                    }
                }
                catch (SqlException) { }

                // 2️⃣ Delete related bikes + their images
                SqlCommand bikeCmd = new SqlCommand("SELECT Image1, Image2, Image3 FROM Bikes WHERE DealerID=@id", con);
                bikeCmd.Parameters.AddWithValue("@id", userId);

                using (SqlDataReader dr = bikeCmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        for (int i = 0; i < 3; i++)
                        {
                            string bikeImg = dr[i] as string;
                            if (!string.IsNullOrEmpty(bikeImg))
                            {
                                string bikeFullPath = Server.MapPath(bikeImg.StartsWith("~") ? bikeImg : ("~/Uploads/Bikes/" + bikeImg));
                                if (System.IO.File.Exists(bikeFullPath))
                                    System.IO.File.Delete(bikeFullPath);
                            }
                        }
                    }
                }

                // 3️⃣ Delete bikes
                SqlCommand deleteBikes = new SqlCommand("DELETE FROM Bikes WHERE DealerID=@id", con);
                deleteBikes.Parameters.AddWithValue("@id", userId);
                deleteBikes.ExecuteNonQuery();

                // 4️⃣ Delete user
                SqlCommand deleteUser = new SqlCommand("DELETE FROM Users WHERE UserID=@id", con);
                deleteUser.Parameters.AddWithValue("@id", userId);
                deleteUser.ExecuteNonQuery();
            }

            if (e.CommandName == "ViewUser")
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE UserID=@id", con);
                cmd.Parameters.AddWithValue("@id", userId);

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        string profileImage = dr["ProfileImage"] == DBNull.Value
                            ? "/Uploads/user.jpg"
                            : HttpUtility.HtmlAttributeEncode(dr["ProfileImage"].ToString());

                        string roleBadge = "<span class='badge-role'>" + HttpUtility.HtmlEncode(dr["Role"].ToString()) + "</span>";

                        string statusBadge = Convert.ToBoolean(dr["IsActive"])
                            ? "<span class='badge-active'>Active</span>"
                            : "<span class='badge-inactive'>Inactive</span>";

                        string details = "<h4 class='fw-bold'>" + HttpUtility.HtmlEncode(dr["FullName"].ToString()) + "</h4><br/>";
                        details += "<b>Email:</b> " + HttpUtility.HtmlEncode(dr["Email"].ToString()) + "<br/><br/>";
                        details += "<b>City:</b> " + HttpUtility.HtmlEncode(dr["City"] != DBNull.Value ? dr["City"].ToString() : "") + "<br/><br/>";
                        details += roleBadge + " &nbsp; " + statusBadge;

                        ClientScript.RegisterStartupScript(this.GetType(),
                            "ShowModal",
                            "document.getElementById('modalUserImage').src='" + profileImage + "';" +
                            "document.getElementById('modalUserContent').innerHTML=\"" + details.Replace("\"", "\\\"") + "\";" +
                            "var myModal = new bootstrap.Modal(document.getElementById('userModal')); myModal.show();",
                            true);
                    }
                }
            }
        }

        LoadUsers();
    }
}
