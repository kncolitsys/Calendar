<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 MainHelpPanel::display
*
* Description:
*	 Displays the default main panel view of the application help interface.
*
****************************************************************************
--->
<cfparam name="book" default="">
<cfparam name="chapter" default="">
<cfparam name="section" default="">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheets/help.css">
	</head>
	
	<body>
		<cfset path = "../help">
		<cfset chunks = "book,chapter,section">
		<cfloop index="chunk" list="#chunks#">
			<cfset level = evaluate(chunk)>
			<cfif len(level) gt 0>
				<cfset path = path & "/#level#">
				<cfset success = setVariable(chunk,evaluate(chunk))>
			<cfelse>
				<cfbreak>
			</cfif>
		</cfloop>
		<cfset path = path & "/index.cfm">

		<h2 align="center"><cfoutput>#application.resource.bundle.text.calendarinfusion# #application.resource.bundle.text.help#</cfoutput></h2>

		<table align="center" width="95%" cellpadding="8" cellspacing="0" style="border:1px solid navy; background-color: #ffffff; border-collapse: collapse;">
			<tr>
				<td style="border:1px solid navy; background-color: #f9f9f9;">
					<cfoutput>
						<p style="font-size: 12px;" align="left">
							#application.resource.bundle.text.help_lcase#
							<cfif len(book) gt 0>&gt; <a href="index.cfm?cfevent=help&book=#book#">#book#</a></cfif>
							<cfif len(chapter) gt 0>&gt; <a href="index.cfm?cfevent=help&book=#book#&chapter=#chapter#">#chapter#</a></cfif>
							<cfif len(section) gt 0>&gt; <a href="index.cfm?cfevent=help&book=#book#&chapter=#chapter#&section=#section#">#section#</a></cfif>
						</p>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td>			
					<cftry>
						<cfinclude template="#path#">
						<cfcatch type="MissingInclude">
							<p align="center"><cfoutput>#application.resource.bundle.text.unable_to_find_help_page#</cfoutput></p>
						</cfcatch>
					</cftry>
					<br>
				</td>
			</tr>
		</table>

		<div align="right">
			<span style="font-size:11px; font-family:Verdana,Arial,Helvetica,sans-serif;"><cfoutput>#application.resource.bundle.text.copyright#</cfoutput></span>
		</div>
	</body>
</html>
	
