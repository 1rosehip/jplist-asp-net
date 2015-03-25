using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace jPList.Demo.Log
{
    /// <summary>
    /// basic logger - should be replaced by other standard logger
    /// </summary>
    public class Logger
    {
        /// <summary>
        /// error log
        /// </summary>
        /// <param name="msg"></param>
        public static void Error(string msg)
        {
            HttpContext.Current.Response.Write(msg);
        }

        /// <summary>
        /// error log
        /// </summary>
        /// <param name="msg"></param>
        public static void Info(string msg)
        {
            HttpContext.Current.Response.Write(msg);
        }
    }
}