<cfparam name="request.stylesheetType" default="style">
<cfparam name="request.stylesheet" default="">
<cfparam name="request.contextId" default="">
<cfparam name="request.applicationContextId" default="">

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheets/application.css" />
		<link type="text/css" rel="stylesheet" href="stylesheets/administrator.css" />
		
		<cfif request.stylesheetType eq "file">
			<link type="text/css" rel="stylesheet" href="#request.stylesheet#">
		<cfelseif request.stylesheetType eq "style">
			<style type="text/css">
				<cfoutput>#request.stylesheet#</cfoutput>
			</style>
		<cfelse>
			<!---// Nothing to output. --->
		</cfif>
	</head>

	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2" style="background-color: ##663333; text-align: right;">
					<span style="font-size:18px;color:white;font-weight:bold;align:right;padding:4px;">#application.resource.bundle.text.calendarinfusion#</span>
				</td>
			</tr>
			<tr>
				<td width="18%" rowspan="3" valign="top" style="background-color: ##663333;">
					<span class="bmn-title" style="width:100%; background-color: ##9c4e4e; padding: 0px 5px 0px 5px;color:##ffffff;">#application.resource.bundle.text.administer#</span><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.server">#application.resource.bundle.text.server#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.calendar">#application.resource.bundle.text.calendar#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.holidays">#application.resource.bundle.text.holidays#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.schemes">#application.resource.bundle.text.schemes#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.search">#application.resource.bundle.text.search#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.language">#application.resource.bundle.text.language#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.groups">#application.resource.bundle.text.groups#</a><br>
					<a class="bmn-link" href="index.cfm?cfevent=administrator.users">#application.resource.bundle.text.users#</a><br>
					<!---// CODE: Should I just remove the debugging option??? --->
					<!---<a class="bmn-link" href="index.cfm?cfevent=administrator.debug">#application.resource.bundle.text.debugging#</a><br>--->
					<br><br>
				</td>
				<td align="right" valign="top" style="background-color:##f0f0f0;">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="images/tab_angle_l_colored.gif"></td>
							<td class="bma-cell">
								<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
									<a class="administrationMenuText" href="index.cfm?cfevent=main.signout">#application.resource.bundle.text.logout#</a><br>
								<cfelse>
									<a class="administrationMenuText" href="index.cfm?cfevent=user.login&redirect=index.cfm">#application.resource.bundle.text.login#</a><br>
								</cfif>
							</td>
					
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
				<td width="85%" valign="top" style="padding:2px 10px 2px 10px;background-color:##f0f0f0;height:360px;">
					<!-- page body starts here. -->
					#request.content#
					<!-- page body ends here. -->
				</td>
			</tr>
			<tr>
				<td style="background-color: ##834141;"><img src="images/blank.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: ##663333;"><img src="images/blank.gif" width="1" height="10"></td>
			</tr>
		</table>
	
		<div align="right">
			<span style="font-size:11px; font-family:Verdana,Arial,Helvetica,sans-serif;">#application.resource.bundle.text.copyright#</span>
		</div>
	</body>
</html>
</cfoutput>