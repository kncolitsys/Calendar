<!---
	DownloadFilter.cfc
	
	I am an event-filter that delivers a file for download.
	
	Define me as a filter like this:
	
	<event-filters>
		...
		<event-filter name="download" type="core.filters.DownloadFilter" />			
		...
	</event-filters>

	Use me in an event handler like this:
	
	<event-handlers>
		...
		<event-handler event="foo">
			<filter name="download" />     
			...
		</event-handler>
		...				
	</event-handlers>		
--->
<cfcomponent extends="MachII.framework.EventFilter">

	<cffunction name="configure" returntype="void" access="public" output="false">
		<!--- perform any initialization --->
	</cffunction>
	
	<cffunction name="filterEvent" returntype="boolean" access="public" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="yes" />
		<cfargument name="paramArgs" type="struct" required="yes" />	
		
		<cfset var curArgs = arguments.eventContext.getCurrentEvent().getArgs() />
		<cfset var downloadDir = "d:/http/core/downloads/" />
		<cfset var fileToDownload = curArgs.fileid />
		<cfset var fileExt = "" />
		<cfset var mimeType  = "" />
		
		<cfscript>
			fileExt = lcase(right(fileToDownload,3));
			switch(fileExt){
				case "bin":{
					mimeType = "application/macbinary";
					break;
				}
				case "hqx":{
					mimeType = "application/mac-binhex40";
					break;
				}
				case "sit":{
					mimeType = "application/x-stuffit";
					break;				
				}
				case "zip":{
					mimeType = "application/x-zip-compressed";
					break;				
				}
				case "pdf":{
					mimeType = "application/pdf";								
					break;				
				}
				default:{
					//application/x-msdownload
					//application/octet-stream
					//application/unknown
					mimeType = "application/octet-stream";
					break;
				}
			}
		</cfscript>
				
		<cfheader name="content-disposition" value="attachment;  filename=#fileToDownload#">
		<CFCONTENT TYPE="#mimeType#" FILE="#downloadDir##fileToDownload#">	   		
		<cfreturn false />	
	</cffunction>
</cfcomponent>
