<cfparam name="request.stylesheetType" default="style">
<cfparam name="request.stylesheet" default="">
<cfparam name="request.contextId" default="">
<cfparam name="request.applicationContextId" default="">

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheets/application.css" />
		<link type="text/css" rel="stylesheet" href="stylesheets/editor.css" />
			
		<cfif request.stylesheetType eq "file">
			<link type="text/css" rel="stylesheet" href="#request.stylesheet#">
		<cfelseif request.stylesheetType eq "style">
			<style type="text/css">
				#request.stylesheet#
			</style>
		<cfelse>
			<!---// Nothing to output. --->
		</cfif>
	</head>

	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-color:##ffffff;">
			<tr>
				<td colspan="2" style="background-color: ##418341;"><img src="images/blank.gif" width="1" height="2"></td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: ##336633; text-align: right;">
					<span style="font-size:18px;color:white;font-weight:bold;align:right;padding:4px;">#application.resource.bundle.text.calendarinfusion#</span>
				</td>
			</tr>
			<tr>
				<td width="18%" rowspan="3" valign="top" style="background-color: ##336633;">
					<span class="bmn-title" style="width:100%; background-color: ##4e9c4e; padding: 0px 5px 0px 5px;color:##ffffff;">#application.resource.bundle.text.edit#</span><br>
					<a class="bmn-link" href="index.cfm?cfevent=editor.calendar&calendarId=#calendarId#">#application.resource.bundle.text.calendar#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=editor.events&calendarId=#calendarId#">#application.resource.bundle.text.events#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=editor.holidays&calendarId=#calendarId#">#application.resource.bundle.text.holidays#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=editor.schemes&calendarId=#calendarId#">#application.resource.bundle.text.schemes#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=editor.categories&calendarId=#calendarId#">#application.resource.bundle.text.categories#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=editor.mail.configuration&calendarId=#calendarId#">#application.resource.bundle.text.mail#</a><br>
				</td>
				<td align="right" valign="top">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="images/tab_angle_l_colored.gif"></td>
							<td class="bma-cell">
								<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
									<a class="bma-link" href="index.cfm?cfevent=main.signout&calendarId=#calendarId#">#application.resource.bundle.text.logout#</a><br>
								<cfelse>
									<a class="bma-link" href="index.cfm?cfevent=main.signin&calendarId=#calendarId#&redirect=index.cfm?cfevent=editor.home&amp;calendarId=#calendarId#">#application.resource.bundle.text.login#</a><br>
		<!---							 <a class="bmn-link" href="index.cfm?cfevent=user.register&calendarId=#calendarId#">#application.resource.bundle.text.register#</a><br> --->
								</cfif>
							</td>
							
							<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
							<td class="bma-cell">
								<a class="bma-link" href="index.cfm?cfevent=calendar.view&calendarId=#calendarId#">#application.resource.bundle.text.calendar#</a>
							</td>
							
							<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#request.contextId#_ADMINISTER"))>
								<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
								<td class="bma-cell">
									<a class="bma-link" href="index.cfm?calendarId=#calendarId#">#application.resource.bundle.text.editor#</a><br>
								</td>
							</cfif>
		
							<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("ADMINISTER_APPLICATION"))>					
								<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
								<td class="bma-cell">
									<a class="bma-link" href="index.cfm?cfevent=administrator.home">#application.resource.bundle.text.administrator#</a>
								</td>
							</cfif>
							<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
							<td class="bma-cell">
								<a class="bma-link" href="index.cfm?cfevent=help&book=adminguide" target="_blank">#application.resource.bundle.text.help#</a>
							</td>
							<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
							<td class="bma-cell">
								<a class="bma-link" href="index.cfm">#application.resource.bundle.text.home#</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="85%" style="padding:2px 10px 2px 10px;height:360px;background-color:##ffffff;" valign="top">
					<!-- page body starts here. -->
					#request.content#
					<!-- page body ends here. -->
				</td>
			</tr>
			<tr>
				<td style="background-color: ##418341;height:2px;"><img src="images/blank.gif" width="1" height="2"></td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: ##336633;"><img src="images/blank.gif" width="1" height="10"></td>
			</tr>
		</table>
		
		<div align="right">
			<span style="font-size:11px; font-family:Verdana,Arial,Helvetica,sans-serif;">#application.resource.bundle.text.copyright#</span>
		</div>
	</body>
</html>
</cfoutput>