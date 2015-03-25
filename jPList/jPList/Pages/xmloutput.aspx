﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xmloutput.aspx.cs" Inherits="jPList.xmloutput" MasterPageFile="~/Site.master" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadPlaceHolder">
    	
        <!-- jPList Core  -->
		<script src="/content/js/jplist/jplist-core.min.js"></script>
		<link href="/content/css/jplist-core.min.css" rel="stylesheet" type="text/css" />
		<link href="/content/css/jplist-demo-pages.min.css" rel="stylesheet" type="text/css" />

        <!-- pagination bundle -->
		<link href="/content/css/jplist-pagination-bundle.min.css" rel="stylesheet" type="text/css" />
		<script src="/content/js/jplist/jplist.pagination-bundle.min.js"></script>
		
		<!-- history bundle -->
		<link href="/content/css/jplist-history-bundle.min.css" rel="stylesheet" type="text/css" />
		<script src="/content/js/jplist/jplist.history-bundle.min.js"></script>
		
		<!-- textbox control -->
		<link href="/content/css/jplist-textbox-control.min.css" rel="stylesheet" type="text/css" />
		<script src="/content/js/jplist/jplist.textbox-control.min.js"></script>
		
		<!-- preloader control -->
		<link href="/content/css/jplist-preloader-control.min.css" rel="stylesheet" type="text/css" />
		<script src="/content/js/jplist/jplist.preloader-control.min.js"></script>
		
		<!-- views control -->
		<link href="/content/css/jplist-views-control.min.css" rel="stylesheet" type="text/css" />
		<script src="/content/js/jplist/jplist.views-control.min.js"></script>
		
		<!-- sort bundle -->
		<script src="/content/js/jplist/jplist.sort-bundle.min.js"></script>
		
		<!-- toggle filter bundle -->
		<link href="/content/css/jplist-filter-toggle-bundle.min.css" rel="stylesheet" type="text/css" />
		<script src="/content/js/jplist/jplist.filter-toggle-bundle.min.js"></script>	

		<script>
		    $('document').ready(function () {

		        var $list = $('#demo .list')
				    , template = $('#xslt-template').html();

		        $('#demo').jplist({

		            itemsBox: '.list'
				        , itemPath: '.list-item'
				        , panelPath: '.jplist-panel'

		            //data source
				        , dataSource: {

				            type: 'server'
					        , server: {

					            //ajax settings
					            ajax: {
					                url: '/web/XMLOutputHandler.ashx'
							        , dataType: 'xml'
							        , type: 'POST'
					            }
					        }

				            //render with handlebars
					        , render: function (dataItem) {

					            var xsltProcessor
							        , srcTree
							        , xsltTree;

					            if (document.implementation && document.implementation.createDocument && window.XSLTProcessor) {

					                if (dataItem.content) {
					                    xsltProcessor = new XSLTProcessor();
					                    xsltProcessor.importStylesheet($.parseXML(template));
					                    $list.html(xsltProcessor.transformToFragment(dataItem.content, document));
					                }
					            }
					            else {//IE ...
					                if (dataItem.responseText) {
					                    //xml
					                    srcTree = new ActiveXObject('Msxml2.DOMDocument.6.0');
					                    srcTree.async = false;
					                    srcTree.loadXML(dataItem.responseText);

					                    //xslt
					                    xsltTree = new ActiveXObject('Msxml2.DOMDocument.6.0');
					                    xsltTree.async = false;
					                    xsltTree.loadXML(template);

					                    //paste
					                    $list.html(srcTree.transformNode(xsltTree));
					                }
					            }
					        }
				        }

		        });
		    });
		</script>
        
        <!-- xslt template -->
        <script id="xslt-template" type="text/xslt-template">
        <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	        <xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="no"/>
	        <xsl:template match="/">
			
		        <xsl:for-each select="//item">
			
			        <div class="list-item box">	
			
				        <div class="img left">
					        <img src="{image}" alt="" title=""/>
				        </div>
				
				        <div class="block right">
					        <p class="title"><xsl:value-of select="title"/></p>
					        <p class="desc"><xsl:value-of select="description"/></p>
					        <p class="like"><xsl:value-of select="likes"/> Likes</p>
					        <p class="theme"><xsl:value-of select="keyword1"/>, <xsl:value-of select="keyword2"/></p>
				        </div>
			        </div>
		        </xsl:for-each>
				
	        </xsl:template>
        </xsl:stylesheet>					
        </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="BodyPlaceHolder">

    <div class="box">
	<div class="center">
				
		<div class="box text-shadow">
			<h1 class="h1-30-normal left">ASP.NET and SQL Server Demo - XML output and XSLT template</h1>
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
						<img src="/content/img/common/ajax-loader-line.gif" alt="Loading..." title="Loading..." />
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
</asp:Content>

