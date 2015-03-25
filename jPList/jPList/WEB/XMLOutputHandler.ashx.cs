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
    /// Summary description for XMLOutputHandler
    /// </summary>
    public class XMLOutputHandler : IHttpHandler
    {
        /// <summary>
        /// get item XML
        /// </summary>
        /// <param name="item">data item</param>
        /// <returns>item xml</returns>
        private string GetItemXML(Item item)
        {
            StringBuilder xml = new StringBuilder();

            try
            {
                xml.AppendLine("<item>");

                xml.AppendLine("<image>" + item.Image + "</image>");
                xml.AppendLine("<title>" + item.Title + "</title>");
                xml.AppendLine("<description>" + item.Description + "</description>");
                xml.AppendLine("<likes>" + item.Likes + "</likes>");
                xml.AppendLine("<keyword1>" + item.Keyword1 + "</keyword1>");
                xml.AppendLine("<keyword2>" + item.Keyword2 + "</keyword2>");

                xml.AppendLine("</item>");
            }
            catch (Exception ex)
            {
                Logger.Error("JPList Web: " + ex.Message + " " + ex.StackTrace);
            }

            return xml.ToString();
        }

        /// <summary>
        /// get XML output
        /// </summary>
        /// <param name="items">data items</param>
        /// <param name="count">items number - used for pagination control</param>
        /// <returns>xml string</returns>
        private string GetXML(List<Item> items, int count)
        {
            StringBuilder xml = new StringBuilder();
            try
            {
                xml.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                xml.AppendLine("<root count=\"" + count + "\">");

                foreach (Item item in items)
                {
                    xml.AppendLine(this.GetItemXML(item));
                }
               
                xml.AppendLine("</root>");
            }
            catch (Exception ex)
            {
                Logger.Error("JPList Web: " + ex.Message + " " + ex.StackTrace);
            }

            return xml.ToString();
        }

        /// <summary>
        /// entry point
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/xml";

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
                context.Response.Write(this.GetXML(items, count));
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