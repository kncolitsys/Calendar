<cfparam name="request.stylesheetType" default="style">
<cfparam name="request.stylesheet" default="">
<cfparam name="request.contextId" default="">
<cfparam name="request.applicationContextId" default="">
<cfscript>
	qs = "#cgi.query_string#";
	if (len(qs) eq 0)
		redirect = #cgi.script_name#;
	else
		redirect = #cgi.script_name# & "?" & #qs#;
	redirect = urlEncodedFormat(redirect);
</cfscript>

<cfparam name="request.loginRedirect" default="#redirect#">

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheets/application.css" />
		
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
	
	<body style="background-color:##ffffff;">
		<table border="0" cellpadding="0" cellspacing="0" class="bc-page" style="width:100%;">
			<tr>
				<td colspan="2" style="background-color: ##414183;"><img src="images/blank.gif" width="1" height="2"></td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: ##333366; text-align: right;">
					<span style="font-size:18px;color:white;font-weight:bold;align:right;padding:4px;">calendarInfusion</span>
				</td>
			</tr>
			<tr style="background-color:##f0f0f0;">
				<td align="left" valign="top" style="border-left:1px solid ##bfbfbf;">
					<table border="0" cellpadding="0" cellspacing="0" class="bma-style">
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
				<td align="right" valign="top" style="border-right:1px solid ##bfbfbf;">
					<table border="0" cellpadding="0" cellspacing="0" class="bma-style">
						<tr>
							<td><img src="images/tab_angle_l_colored.gif"></td>
							<td class="bma-cell">
								<cfif len(trim(getProperty("sessionFacade").getUser().getUsername())) gt 0 and compareNoCase(getProperty("sessionFacade").getUser().getUsername(),"anonymous_guest_acct") neq 0>
									<a class="administrationMenuText" href="index.cfm?cfevent=main.signout">#application.resource.bundle.text.logout#</a><br>
								<cfelse>
									<a class="administrationMenuText" href="index.cfm?cfevent=main.signin">#application.resource.bundle.text.login#</a><br>
								</cfif>
							</td>
				
							<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("ADMINISTER_APPLICATION"))>
								<td class="bma-separator"><img src="images/tab_angle_l.gif"></td>
								<td class="bma-cell"><a href="index.cfm?cfevent=administrator.home">#application.resource.bundle.text.administrator#</a></td>
							</cfif>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" valign="top" class="bc-border" style="height:200px;">
					<!-- page body starts here. -->
					#request.content#
					<!-- page body ends here. -->
				</td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: ##414183; height:2px;"><img src="images/blank.gif" width="1" height="2"></td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: ##333366;"><img src="images/blank.gif" width="1" height="10"></td>
			</tr>
		</table>
		
		<div align="right">
			<span style="font-size:11px; font-family:Verdana,Arial,Helvetica,sans-serif;"><cfoutput>#application.resource.bundle.text.copyright#</cfoutput></span>
		</div>
	</body>
</html>
</cfoutput>