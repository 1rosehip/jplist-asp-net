﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="jPList.Demo._default" %>
<!DOCTYPE html>

<html>
    
    <head runat="server">
        <title>ASP.NET and SQL Server Demo | jPList - jQuery Data Grid Controls</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!-- css -->
        <link href="//fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" href="content/css/vendor/normalize.css" />
		<link rel="stylesheet" href="content/css/styles.min.css" />

        <!-- jQuery -->		
        <script src="content/js/vendor/jquery-1.10.0.min.js"></script>
        
		<!-- jPList Core  -->
		<script src="content/js/jplist/jplist-core.min.js"></script>
		<link href="content/css/jplist-core.min.css" rel="stylesheet" type="text/css" />
		<link href="content/css/jplist-demo-pages.min.css" rel="stylesheet" type="text/css" />

        <!-- pagination bundle -->
		<link href="content/css/jplist-pagination-bundle.min.css" rel="stylesheet" type="text/css" />
		<script src="content/js/jplist/jplist.pagination-bundle.min.js"></script>
		
		<!-- history bundle -->
		<link href="content/css/jplist-history-bundle.min.css" rel="stylesheet" type="text/css" />
		<script src="content/js/jplist/jplist.history-bundle.min.js"></script>
		
		<!-- textbox control -->
		<link href="content/css/jplist-textbox-control.min.css" rel="stylesheet" type="text/css" />
		<script src="content/js/jplist/jplist.textbox-control.min.js"></script>
		
		<!-- preloader control -->
		<link href="content/css/jplist-preloader-control.min.css" rel="stylesheet" type="text/css" />
		<script src="content/js/jplist/jplist.preloader-control.min.js"></script>
		
		<!-- views control -->
		<link href="content/css/jplist-views-control.min.css" rel="stylesheet" type="text/css" />
		<script src="content/js/jplist/jplist.views-control.min.js"></script>
		
		<!-- sort bundle -->
		<script src="content/js/jplist/jplist.sort-bundle.min.js"></script>
		
		<!-- toggle filter bundle -->
		<link href="content/css/jplist-filter-toggle-bundle.min.css" rel="stylesheet" type="text/css" />
		<script src="content/js/jplist/jplist.filter-toggle-bundle.min.js"></script>		

		<script>
		    $('document').ready(function () {
		        $('#demo').jplist({

		            itemsBox: '.list'
				, itemPath: '.list-item'
				, panelPath: '.jplist-panel'

				, effect: 'fade'

		            //data source
				, dataSource: {

				    type: 'server'
					, server: {

					    //ajax settings
					    ajax: {
					        url: 'server.ashx'
							, dataType: 'html'
							, type: 'POST'
					    }
					}
				}

		        });
		    });
		</script>	
    </head>

    <body>
        <form id="DefaultForm" runat="server">
            
            <div class="box">
			    <div class="center">
				
				    <div class="box text-shadow">
					    <h1 class="h1-30-normal left">ASP.NET and SQL Server Demo</h1>
				    </div>

				    <div class="box text-shadow">

					    <!-- jPList DEMO START -->
					    <div id="demo" class="box jplist">
							
						    <!-- ios button: show/hide panel -->
						    <div class="jplist-ios-button">
							    <i class="fa fa-sort"></i>
							    jPList Actions
						    </div>
								
						    <!-- panel -->
						    <div class="jplist-panel box panel-top">						

							    <!-- reset button -->
							    <button 
								    type="button" 
								    class="jplist-reset-btn"
								    data-control-type="reset" 
								    data-control-name="reset" 
								    data-control-action="reset">
								    Reset &nbsp;<i class="fa fa-share"></i>
							    </button>

                                <!-- items per page dropdown -->
							    <div
								    class="jplist-drop-down"
								    data-control-type="items-per-page-drop-down"
								    data-control-name="paging"
								    data-control-action="paging">

								    <ul>
									    <li><span data-number="3"> 3 per page </span></li>
									    <li><span data-number="5"> 5 per page </span></li>
									    <li><span data-number="10" data-default="true"> 10 per page </span></li>
									    <li><span data-number="all"> View All </span></li>
								    </ul>
							    </div>

                                <!-- sort dropdown -->
							    <div
								    class="jplist-drop-down"
								    data-control-type="sort-drop-down"
								    data-control-name="sort"
								    data-control-action="sort">

								    <ul>
									    <li><span data-path="default">Sort by</span></li>
									    <li><span data-path=".title" data-order="asc" data-type="text">Title A-Z</span></li>
									    <li><span data-path=".title" data-order="desc" data-type="text">Title Z-A</span></li>
									    <li><span data-path=".desc" data-order="asc" data-type="text">Description A-Z</span></li>
									    <li><span data-path=".desc" data-order="desc" data-type="text">Description Z-A</span></li>
									    <li><span data-path=".like" data-order="asc" data-type="number">Likes asc</span></li>
									    <li><span data-path=".like" data-order="desc" data-type="number">Likes desc</span></li>
								    </ul>
							    </div>

							    <!-- filter by title -->
							    <div class="text-filter-box">
																	
								    <!--[if lt IE 10]>
								    <div class="jplist-label">Filter by Title:</div>
								    <![endif]-->
										
								    <input 
									    data-path=".title" 
									    data-button="#title-search-button"
									    type="text" 
									    value="" 
									    placeholder="Filter by Title" 
									    data-control-type="textbox" 
									    data-control-name="title-filter" 
									    data-control-action="filter"
								    />
										
								    <button 
									    type="button" 
									    id="title-search-button">
									    <i class="fa fa-search"></i>
								    </button>
							    </div>
									
							    <!-- filter by description -->
							    <div class="text-filter-box">
																		
								    <!--[if lt IE 10]>
								    <div class="jplist-label">Filter by Description:</div>
								    <![endif]-->
										
								    <input 
									    data-path=".desc" 
									    data-button="#desc-search-button"
									    type="text" 
									    value="" 
									    placeholder="Filter by Description" 
									    data-control-type="textbox" 
									    data-control-name="desc-filter" 
									    data-control-action="filter"
								    />	
										
								    <button 
									    type="button" 
									    id="desc-search-button">
									    <i class="fa fa-search"></i>
								    </button>
							    </div>

							    <!-- list / grid view control -->
							    <div 
								    class="jplist-views" 
								    data-control-type="views" 
								    data-control-name="views" 
								    data-control-action="views"
								    data-default="jplist-list-view">
									   
								    <button type="button" class="jplist-view jplist-list-view" data-type="jplist-list-view"></button>
								    <button type="button" class="jplist-view jplist-grid-view" data-type="jplist-grid-view"></button>
							    </div>
									
							    <!-- checkbox filters -->
							    <div
								    class="jplist-group"
								    data-control-type="checkbox-group-filter"
								    data-control-action="filter"
								    data-control-name="themes">

								    <input
									    data-path=".architecture"
									    id="architecture"
									    type="checkbox"
								    />

								    <label for="architecture">Architecture</label>

								    <input
									    data-path=".christmas"
									    id="christmas"
									    type="checkbox"
								    />

								    <label for="christmas">Christmas</label>

								    <input
									    data-path=".nature"
									    id="nature"
									    type="checkbox"
								    />

								    <label for="nature">Nature</label>

								    <input
									    data-path=".lifestyle"
									    id="lifestyle"
									    type="checkbox"
								    />

								    <label for="lifestyle">Lifestyle</label>
							    </div>

							    <div
								    class="jplist-group"
								    data-control-type="checkbox-group-filter"
								    data-control-action="filter"
								    data-control-name="colors">

								    <input
									    data-path=".red"
									    id="red-color"
									    type="checkbox"
								    />

								    <label for="red-color">Red</label>

								    <input
									    data-path=".green"
									    id="green-color"
									    type="checkbox"
								    />

								    <label for="green-color">Green</label>

								    <input
									    data-path=".blue"
									    id="blue-color"
									    type="checkbox"
								    />

								    <label for="blue-color">Blue</label>

								    <input
									    data-path=".brown"
									    id="brown-color"
									    type="checkbox"
								    />

								    <label for="brown-color">Brown</label>
										
							    </div>
									
							    <!-- pagination results -->
							    <div 
								    class="jplist-label" 
								    data-type="Page {current} of {pages}" 
								    data-control-type="pagination-info" 
								    data-control-name="paging" 
								    data-control-action="paging">
							    </div>
										
							    <!-- pagination -->
							    <div 
								    class="jplist-pagination" 
								    data-control-type="pagination" 
								    data-control-name="paging" 
								    data-control-action="paging">
							    </div>	

                                <!-- preloader for data sources -->
							    <div 
								    class="jplist-hide-preloader jplist-preloader"
								    data-control-type="preloader" 
								    data-control-name="preloader" 
								    data-control-action="preloader">
								    <img src="content/img/common/ajax-loader-line.gif" alt="Loading..." title="Loading..." />
							    </div>

						    </div>
														
						    <!-- ajax content here -->   
						    <div class="list box text-shadow"></div>
								
						    <!-- no result found -->
						    <div class="box jplist-no-results text-shadow align-center jplist-hidden">
							    <p>No results found</p>
						    </div>
								
						    <!-- ios button: show/hide panel -->
						    <div class="jplist-ios-button">
							    <i class="fa fa-sort"></i>
							    jPList Actions
						    </div>
								
						    <!-- panel -->
						    <div class="jplist-panel box panel-bottom">						
									
                                <!-- items per pafe dropdown -->						
							    <div 
								    class="jplist-drop-down left" 
								    data-control-type="items-per-page-drop-down" 
								    data-control-name="paging" 
								    data-control-action="paging"
								    data-control-animate-to-top="true">
										
								    <ul>
									    <li><span data-number="3"> 3 per page </span></li>
									    <li><span data-number="5"> 5 per page </span></li>
									    <li><span data-number="10" data-default="true"> 10 per page </span></li>
									    <li><span data-number="all"> View All </span></li>
								    </ul>
							    </div>

                                <!-- sort dropdown -->
							    <div 
								    class="jplist-drop-down left" 
								    data-control-type="sort-drop-down" 
								    data-control-name="sort" 
								    data-control-action="sort"
								    data-control-animate-to-top="true">
										
								    <ul>
									    <li><span data-path="default">Sort by</span></li>
									    <li><span data-path=".title" data-order="asc" data-type="text">Title A-Z</span></li>
									    <li><span data-path=".title" data-order="desc" data-type="text">Title Z-A</span></li>
									    <li><span data-path=".desc" data-order="asc" data-type="text">Description A-Z</span></li>
									    <li><span data-path=".desc" data-order="desc" data-type="text">Description Z-A</span></li>
									    <li><span data-path=".like" data-order="asc" data-type="number">Likes asc</span></li>
									    <li><span data-path=".like" data-order="desc" data-type="number">Likes desc</span></li>
								    </ul>
							    </div>
									
							    <!-- pagination results -->
							    <div 
								    class="jplist-label" 
								    data-type="{start} - {end} of {all}" 
								    data-control-type="pagination-info" 
								    data-control-name="paging" 
								    data-control-action="paging">
							    </div>
										
							    <!-- pagination -->
							    <div 
								    class="jplist-pagination" 
								    data-control-type="pagination" 
								    data-control-name="paging" 
								    data-control-action="paging"
								    data-control-animate-to-top="true">
							    </div>					
						    </div>
					    </div>
					    <!-- jPList DEMO END -->		

				    </div>

			   
			    </div>
		    </div>

        </form>
    </body>
</html>