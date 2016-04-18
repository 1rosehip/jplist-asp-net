using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

using jPList.Models;
using jPList.DAL;
using jPList.Log;

using Newtonsoft.Json;

namespace jPList.WEB
{
    /// <summary>
    /// Summary description for JSONOutputHandler
    /// </summary>
    public class JSONOutputHandler : IHttpHandler
    {
        /// <summary>
        /// get json wrapper
        /// </summary>
        /// <param name="items">data items</param>
        /// <param name="count">items number - used for pagination control</param>
        /// <returns>json string</returns>
        private string GetWrapper(List<Item> items, int count)
        {
            StringBuilder json = new StringBuilder();
            try
            {
                json.AppendLine("{");
                json.AppendLine("\"count\":" + count);
                json.AppendLine(",\"data\":" + JsonConvert.SerializeObject(items));
                json.AppendLine("}");
            }
            catch (Exception ex)
            {
                Logger.Error("JPList Web: " + ex.Message + " " + ex.StackTrace);
            }

            return json.ToString();
        }

        /// <summary>
        /// entry point
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string statuses;
            List<StatusDTO> statusesList;
            StatusQueries statusQueries;
            DataBase db;

            string countQuery, selectQuery;
            int count = 0;
            List<Item> items;

            try
            {
                items = new List<Item>();

                //get statuses
                statuses = context.Request.Form.Get("statuses");

                if (!String.IsNullOrEmpty(statuses))
                {
                    //decode the url
                    statuses = context.Server.UrlDecode(statuses);
                    statusesList = JsonConvert.DeserializeObject<List<StatusDTO>>(statuses);

                    if (statusesList != null)
                    {
                        //init status queries provider
                        statusQueries = new StatusQueries(statusesList);

                        //init database
                        db = new DataBase();

                        countQuery = statusQueries.GetCountQuery();

                        if (!String.IsNullOrEmpty(countQuery))
                        {
                            count = db.GetNumber(countQuery, statusQueries.Parameters);
                        }

                        selectQuery = statusQueries.GetSelectQuery(count);

                        if (!String.IsNullOrEmpty(selectQuery))
                        {
                            items = db.Select(selectQuery, statusQueries.Parameters);
                        }
                    }

                }

                //draw html
                context.Response.Write(this.GetWrapper(items, count));
            }
            catch (Exception ex)
            {
                Logger.Error("JPList Web: " + ex.Message + " " + ex.StackTrace);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}