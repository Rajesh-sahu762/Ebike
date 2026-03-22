<%@ WebHandler Language="C#" Class="SearchSuggestions" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public class SearchSuggestions : IHttpHandler
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    public void ProcessRequest(HttpContext context)
    {
        string q = context.Request["q"];

        List<object> list = new List<object>();

        if (string.IsNullOrEmpty(q))
        {
            context.Response.Write("[]");
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"

-- BIKES (ALL TYPES)
SELECT TOP 5 
'Bike' AS Type,
BikeID AS ID,
ModelName AS Name,
Price,
Image1 AS ImagePath,
Slug,
IsUsed,
IsForRent
FROM Bikes
WHERE IsApproved = 1
AND (
    ModelName LIKE '%' + @q + '%'
    OR BatteryType LIKE '%' + @q + '%'
)

UNION ALL

-- PARTS
SELECT TOP 5 
'Part',
PartID,
PartName,
Price,
Image1,
'' AS Slug,
0,
0
FROM Parts
WHERE IsApproved = 1
AND (
    PartName LIKE '%' + @q + '%'
    OR Category LIKE '%' + @q + '%'
)

UNION ALL

-- CHARGING STATIONS
SELECT TOP 5 
'Station',
StationID,
StationName,
0,
'' AS ImagePath,
'' AS Slug,
0,
0
FROM ChargingStations
WHERE IsApproved = 1
AND (
    StationName LIKE '%' + @q + '%'
    OR City LIKE '%' + @q + '%'
)

UNION ALL

-- SERVICE CENTERS
SELECT TOP 5 
'Service',
ServiceID,
CenterName,
0,
'' AS ImagePath,
'' AS Slug,
0,
0
FROM ServiceCenters
WHERE IsApproved = 1
AND (
    CenterName LIKE '%' + @q + '%'
    OR City LIKE '%' + @q + '%'
)
";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@q", q);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                list.Add(new
                {
                    Type = dr["Type"].ToString(),
                    ID = dr["ID"],
                    Name = dr["Name"].ToString(),
                    Price = dr["Price"].ToString(),
                    ImagePath = dr["ImagePath"] != DBNull.Value ? dr["ImagePath"].ToString() : "",
                    Slug = dr["Slug"] != DBNull.Value ? dr["Slug"].ToString() : "",
                    IsUsed = Convert.ToBoolean(dr["IsUsed"]),
                    IsForRent = Convert.ToBoolean(dr["IsForRent"])
                });
            }
        }

        context.Response.ContentType = "application/json";
        context.Response.Write(new JavaScriptSerializer().Serialize(list));
    }

    public bool IsReusable { get { return false; } }
}