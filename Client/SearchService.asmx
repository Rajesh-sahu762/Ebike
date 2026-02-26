using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class SearchService : System.Web.Services.WebService
{
    string constr = ConfigurationManager
        .ConnectionStrings["Electronic"].ConnectionString;

    [WebMethod]
    public List<SearchResult> GetSearchResults(string keyword)
    {
        List<SearchResult> list = new List<SearchResult>();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT TOP 5 BikeName, BrandName, Slug
              FROM Bikes
              WHERE IsApproved = 1
              AND (BikeName LIKE @k OR BrandName LIKE @k)", con);

            cmd.Parameters.AddWithValue("@k", "%" + keyword + "%");

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                SearchResult s = new SearchResult();
                s.BikeName = dr["BikeName"].ToString();
                s.BrandName = dr["BrandName"].ToString();
                s.Slug = dr["Slug"].ToString();
                list.Add(s);
            }
        }

        return list;
    }

    public class SearchResult
    {
        public string BikeName { get; set; }
        public string BrandName { get; set; }
        public string Slug { get; set; }
    }
}