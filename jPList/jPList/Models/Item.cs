using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace jPList.Models
{
    /// <summary>
    /// jPList Item Model
    /// </summary>
    public class Item
    {
        /// <summary>
        /// title
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// image
        /// </summary>
        public string Image { get; set; }

        /// <summary>
        /// description
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// likes
        /// </summary>
        public int Likes { get; set; }

        /// <summary>
        /// keyword 1
        /// </summary>
        public string Keyword1 { get; set; }

        /// <summary>
        /// keyword 2
        /// </summary>
        public string Keyword2 { get; set; }
    }
}