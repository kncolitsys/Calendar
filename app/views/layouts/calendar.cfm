<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 MainPublicPanel::displayHtmlHeader
*
* Description:
*	 Displays the default HTML header of the public user interface.
*
****************************************************************************
--->
<cfset arguments.event.getArg("sessionFacade").setStyle(type="file",stylesheet=request.calendarDefaultScheme.getFilepath()) />
<cfparam name="request.style" default="#arguments.event.getArg('sessionFacade').getStyle()#">
<cfparam name="calendarDate" default="#now()#">
<cfparam name="request.contextId" default="0">
<cfparam name="request.applicationContextId" default="0">
<cfparam name="request.calendarheader" default="">
<cfparam name="request.calendarfooter" default="">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheets/public.css" />

		<cfoutput>
			<script language="JavaScript" src="scripts/overlib.js"></script>
	
			<cfswitch expression="#lcase(request.style.type)#">
				<cfcase value="file">
					<link type="text/css" rel="stylesheet" href="#request.style.stylesheet#">
				</cfcase>
				<cfcase value="style">
					<style type="text/css">
						#request.style.stylesheet#
					</style>
				</cfcase>
				<cfdefaultcase>
					<link type="text/css" rel="stylesheet" href="#request.style.stylesheet#">
				</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</head>
	
	<body>
		<cfoutput>
			<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
				#request.calendar.getHeader()#
	 
				<table border="0" cellpadding="0" cellspacing="0" class="bc-page" style="width:100%;">
					<tr>
						<td align="left" valign="top">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td style="font-size:10px;padding:0px 6px 0px 6px;background-color:##e6e6e6;border-bottom:1px solid ##bfbfbf;">
										<a class="administrationMenuText" href="index.cfm">#application.resource.bundle.text.home#</a>
									</td>
									<td style="background-color:##e6e6e6;border-bottom:1px solid ##bfbfbf;"><img src="images/tab_angle_r.gif"></td>
									<td style="font-size:10px;padding:0px 6px 0px 6px;background-color:##e6e6e6;border-bottom:1px solid ##bfbfbf;">
										<a class="administrationMenuText" href="index.cfm?cfevent=help&book=userguide" target="_blank">#application.resource.bundle.text.help#</a>
									</td>
									<td><img src="images/tab_angle_r_colored.gif"></td>
								</tr>
							</table>
						</td>
						<td align="right" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" class="bma-style">
								<tr>
									<td><img src="images/tab_angle_l_colored.gif"></td>
									<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
										<td class="bma-cell"><a href="index.cfm?cfevent=main.signout&calendarId=#calendarId#" class="bma-link">#application.resource.bundle.text.logout#</a></td>
									<cfelse>
										<td class="bma-cell"><a href="index.cfm?cfevent=main.signin&calendarId=#calendarId#&redirect=index.cfm?calendarId=#calendarId#" class="bma-link">#application.resource.bundle.text.login#</a></td>
									</cfif>
						
									<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
										<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
										<td class="bma-cell"><a href="index.cfm?cfevent=profile.view&calendarId=#calendarId#" class="bma-link">#application.resource.bundle.text.profile#</a></td>
									</cfif>
						
									<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_ADMINISTER"))>
										<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
										<td class="bma-cell"><a href="index.cfm?cfevent=editor.home&calendarId=#calendarId#" class="bma-link">#application.resource.bundle.text.editor#</a></td>
									</cfif>
						
									<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("ADMINISTER_APPLICATION"))>
										<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
										<td class="bma-cell"><a href="index.cfm?cfevent=administrator.home" class="bma-link">#application.resource.bundle.text.administrator#</a></td>
									</cfif>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="2" valign="top" class="bc-border">
						<!-- page body starts here. -->
						#request.content#<br>
						<!-- page body ends here. -->
					</td>
				</tr>
				<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
					<tr>
						<td colspan="2" align="right" style="font-size:10px;">Currently logged in as: #getProperty("sessionFacade").getUser().getUsername()#&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</cfif>											
			</table>
	
			#request.calendar.getFooter()#
		</cfoutput>
	</body>
</html>