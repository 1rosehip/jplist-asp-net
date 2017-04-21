using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

using jPList.Models;
using jPList.Log;

namespace jPList.DAL
{
    /// <summary>
    /// This class creates SQL queries per jPList statuses from client side
    /// </summary>
    public class StatusQueries
    {
        private StringBuilder FilterQuery = new StringBuilder();
        private StringBuilder SortQuery = new StringBuilder();
        private List<StatusDTO> PaginationStatuses = new List<StatusDTO>();

        /// <summary>
        /// unnamed parameters list
        /// </summary>
        public List<string> Parameters { get; set; }

        /// <summary>
        /// status queries
        /// </summary>
        /// <param name="statuses"></param>
        public StatusQueries(List<StatusDTO> statuses)
        {
            try
            {
                this.Parameters = new List<string>();

                if (statuses != null)
                {
                    foreach (StatusDTO status in statuses)
                    {
                        switch (status.action)
                        {
                            case "paging":
                                {
                                    this.PaginationStatuses.Add(status);
                                    break;
                                }

                            case "filter":
                                {
                                    this.FilterQuery.Append(this.getFilterQuery(status, this.FilterQuery.ToString(), this.Parameters));
                                    break;
                                }

                            case "sort":
                                {
                                    this.SortQuery.Append(this.getSortQuery(status, this.Parameters));
                                    break;
                                }
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                Logger.Error("StatusQueries: " + ex.Message + " " + ex.StackTrace);
            }
        }

        #region "Public Methods"

        /// <summary>
        /// get count query
        /// </summary>
        /// <returns>sql query</returns>
        public string GetCountQuery()
        {
            string query = "";

            try
            {
                //count database items for pagination
                query = "SELECT count(ID) FROM ItemWebsite " + this.FilterQuery.ToString();
            }
            catch (Exception ex)
            {
                Logger.Error("GetCountQuery: " + ex.Message + " " + ex.StackTrace);
            }

            return query;
        }

        /// <summary>
        /// get select query
        /// </summary>
        /// <param name="count">pagination count</param>
        /// <returns>sql query</returns>
        public string GetSelectQuery(int count)
        {
            string query = "";

            try
            {
                query = "SELECT title, description, image, likes, keyword1, keyword2 FROM ItemWebsite " + this.FilterQuery.ToString() + " " + this.SortQuery.ToString();

                if (this.PaginationStatuses.Count > 0)
                {
                    query = this.getPagingQuery(this.PaginationStatuses, count, this.Parameters, query);
                }
            }
            catch (Exception ex)
            {
                Logger.Error("GetSelectQuery: " + ex.Message + " " + ex.StackTrace);
            }

            return query;
        }

        #endregion

        #region "Private Methods"

        /// <summary>
        /// get query for checkbox group filter
        /// </summary>
        /// <param name="keyword">db field</param>
        /// <param name="pathGroup">list of jquery paths</param>
        /// <param name="parameters">prepeared parameters</param>
        /// <returns></returns>
        private string getCheckboxGroupFilterQuery(string keyword, List<string> pathGroup, List<string> parameters)
        {
            StringBuilder query = new StringBuilder();
            string path;

            try
            {
                for (int i = 0; i < pathGroup.Count; i++)
                {
                    path = pathGroup[i].Replace(".", "");

                    if (i != 0)
                    {
                        query.Append(" or ");
                    }

                    query.Append(" " + keyword + " like @p" + (parameters.Count) + " ");
                    parameters.Add(path);
                }
            }
            catch (Exception ex)
            {
                Logger.Error("getCheckboxGroupFilterQuery: " + ex.Message + " " + ex.StackTrace);
            }

            return query.ToString();
        }

        /// <summary>
        /// get pagination query
        /// </summary>
        /// <param name="status">the status object</param>
        /// <param name="count">all items number (after the filters were applied)</param>
        /// <param name="parameters">unnamed parameters list</param>
        /// <returns></returns>
        private string getPagingQuery(List<StatusDTO> statuses, int count, List<string> parameters, string initialQuery)
        {
            StringBuilder query = new StringBuilder();
            int currentPage = 0;
            string order = " order by id ";
            int number = 0;
            int numberInt = 0;

            try
            {
                if(statuses != null && statuses.Count > 0)
                {
                    foreach(var status in statuses)
                    {
                        if (status != null && status.data != null)
                        {
                            if(status.data.currentPage > 0)
                            {
                                currentPage = status.data.currentPage;
                            }

                            if(Int32.TryParse(status.data.number, out numberInt) && numberInt > 0)
                            {
                                number = numberInt;
                            }
                        }
                    }

                    if (count > number)
                    {
                        var startIndex = currentPage * number;
                        var endIndex = startIndex + number;

                        if (!String.IsNullOrEmpty(this.SortQuery.ToString()))
                        {
                            order = this.SortQuery.ToString();
                        }

                        query.AppendLine(" SELECT * FROM ( SELECT *, ROW_NUMBER() OVER ( " + order + " ) as row FROM ItemWebsite " + this.FilterQuery.ToString() + ") a WHERE row > " + startIndex + " and row <=  " + endIndex);
                    }
                }
                else
                {
                    query.AppendLine(initialQuery);
                }

            }
            catch (Exception ex)
            {
                Logger.Error("getPagingQuery: " + ex.Message + " " + ex.StackTrace);
            }

            return query.ToString();
        }

        /// <summary>
        /// get sort query per status
        /// </summary>
        /// <param name="status">the status object</param>
        /// <param name="parameters">unnamed parameters list</param>
        /// <returns>query part</returns>
        private string getSortQuery(StatusDTO status, List<string> parameters)
        {
            string query = "";
            string order = "asc";

            try
            {
                if (status != null && status.data != null && !String.IsNullOrEmpty(status.data.path))
                {
                    switch (status.data.path)
                    {
                        case ".title":
                            {
                                query = " order by title ";
                                break;
                            }

                        case ".desc":
                            {
                                query = " order by description ";
                                break;
                            }

                        case ".like":
                            {
                                query = " order by likes ";
                                break;
                            }
                    }

                    if (!String.IsNullOrEmpty(status.data.order))
                    {
                        order = status.data.order.ToLower() == "desc" ? "desc" : "asc";

                        if (!String.IsNullOrEmpty(query))
                        {
                            query += " " + order;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.Error("getSortQuery: " + ex.Message + " " + ex.StackTrace);
            }

            return query;
        }

        /// <summary>
        /// get filter query per status
        /// </summary>
        /// <param name="status">the status object</param>
        /// <param name="prevQuery">previous query string</param>
        /// <param name="parameters">unnamed parameters list</param>
        /// <returns>query part</returns>
        private string getFilterQuery(StatusDTO status, string prevQuery, List<string> parameters)
        {
            string query = "";
            string filter = "";

            try
            {
                if (status != null && status.data != null && !String.IsNullOrEmpty(status.name))
                {
                    switch (status.name)
                    {
                        case "title-filter":
                            {
                                if (!String.IsNullOrEmpty(status.data.path) && !String.IsNullOrEmpty(status.data.value))
                                {
                                    if (prevQuery.IndexOf("where") == -1)
                                    {
                                        query = "where title like @p" + (parameters.Count) + " ";
                                    }
                                    else
                                    {
                                        query = " and title like @p" + (parameters.Count) + " ";
                                    }

                                    parameters.Add("%" + status.data.value + "%");
                                }

                                break;
                            }

                        case "desc-filter":
                            {
                                if (!String.IsNullOrEmpty(status.data.path) && !String.IsNullOrEmpty(status.data.value))
                                {
                                    if (prevQuery.IndexOf("where") == -1)
                                    {
                                        query = "where description like @p" + (parameters.Count) + " ";
                                    }
                                    else
                                    {
                                        query = " and description like @p" + (parameters.Count) + " ";
                                    }

                                    parameters.Add("%" + status.data.value + "%");
                                }

                                break;
                            }

                        case "themes":
                            {
                                if (status.data.pathGroup != null && status.data.pathGroup.Count > 0)
                                {
                                    filter = this.getCheckboxGroupFilterQuery("keyword1", status.data.pathGroup, parameters);

                                    if (!String.IsNullOrEmpty(filter))
                                    {
                                        if (prevQuery.IndexOf("where") == -1)
                                        {
                                            query = "where " + filter;
                                        }
                                        else
                                        {
                                            query = " and (" + filter + ")";
                                        }
                                    }
                                }

                                break;
                            }

                        case "colors":
                            {
                                if (status.data.pathGroup != null && status.data.pathGroup.Count > 0)
                                {
                                    filter = this.getCheckboxGroupFilterQuery("keyword2", status.data.pathGroup, parameters);

                                    if (!String.IsNullOrEmpty(filter))
                                    {
                                        if (prevQuery.IndexOf("where") == -1)
                                        {
                                            query = "where " + filter;
                                        }
                                        else
                                        {
                                            query = " and (" + filter + ")";
                                        }
                                    }
                                }

                                break;
                            }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.Error("getFilterQuery: " + ex.Message + " " + ex.StackTrace);
            }

            return query;
        }

        #endregion
    }
}