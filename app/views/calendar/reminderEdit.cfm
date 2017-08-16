<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 ReminderEditPanel::display
*
* Description:
*	 Displays a panel to allow a user to edit a reminder.
*
****************************************************************************
--->

<cfset reminderTO = request.reminder.getReminderTO() />

<script language="javascript">
<!--//
	// Selects a default reminder schedule when 'Send a reminder' is selected
	function checkNoTimes() {
		var val = document.Compose.reminderSchedule.selectedIndex;
		if (val == 0) {
			document.Compose.reminderSchedule.selectedIndex = 1;
		}
	}

	// Selects the 'Send a reminder' radio button when schedule is changed.
	function checkHasReminder() {
		var len = document.Compose.elements.length;
		var i = 0;
		var val = document.Compose.reminderSchedule.selectedIndex;
		for (i = 0; i < len; i++) {
			if (document.Compose.elements[i].name == 'sendReminder') {
				if ((val == 0) && (document.Compose.elements[i].value == '0')) {
					document.Compose.elements[i].checked = true;
				}
				if ((val != 0) && (document.Compose.elements[i].value == '1')) {
					document.Compose.elements[i].checked = true;
				}
			}
		}
	}
//-->
</script>


<cfoutput>
	<form name="Compose" action="index.cfm?cfevent=reminder.edit.submitted&calendarId=#calendarId#&eventId=#request.eventItem.getEventId()#" method="post"> 
		<input name="id" type="hidden" value="#reminderTO.reminderId#">
		<input name="eventId" type="hidden" value="#request.eventItem.getEventId()#">
		<input name="seriesId" type="hidden" value="#request.eventItem.getSeriesId()#">
		
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="bpd-style">
			<tr>
				<td class="bpd-title">#application.resource.bundle.text.reminders#:</td>
			</tr>
			<tr>
				<td valign="top">
				
					<cfif isStruct(reminderTO.methods) and not structIsEmpty(reminderTO.methods)>
						<cfset sendReminder = true>			
					<cfelse>
						<cfset sendReminder = false>
					</cfif>	 
					<input name="sendReminder" type="radio" value="0" <cfif not sendReminder>checked</cfif>> #application.resource.bundle.text.do_not_send_reminder#<br>
					<input name="sendReminder" type="radio" value="1" onClick="checkNoTimes()" <cfif sendReminder>checked</cfif>> #application.resource.bundle.text.send_reminder_1#
	
					<select name="schedule" onChange="checkHasReminder()">
						<option value="0" <cfif reminderTO.schedule eq 0>selected</cfif>>----</option>
						<cfloop index="seconds" list="3600,10800,21600,43200,86400,172800,259200,345600,432000,518400,604800,1209600">
							
				<cfscript>
					if((seconds mod 604800) eq 0) {
					value = seconds/604800;
					if(value eq 1) { period = application.resource.bundle.text.week; } else { period = application.resource.bundle.text.weeks; }
					} else if((seconds mod 86400) eq 0) {
					value = seconds/86400;
					if(value eq 1) { period = application.resource.bundle.text.day; } else { period = application.resource.bundle.text.days; }
					} else if((seconds mod 3600) eq 0) {
					value = seconds/3600;
					if(value eq 1) { period = application.resource.bundle.text.hour; } else { period = application.resource.bundle.text.hours; }			
					} else if((seconds mod 60) eq 0) {
					value = seconds/60;
					if(value eq 1) { period = application.resource.bundle.text.minute; } else { period = application.resource.bundle.text.minutes; }			
					} else {
					value = seconds;
					if(value eq 1) { period = application.resource.bundle.text.second; } else { period = application.resource.bundle.text.seconds; }			
					}
				</cfscript>
				
							<option value="#seconds#" <cfif reminderTO.schedule eq seconds>selected</cfif>>#value# #period#</option>
						</cfloop>
					</select>
					&nbsp;#application.resource.bundle.text.send_reminder_2#:<br>
		
					<cfset remindermethods = "email,mobile">
					<cfloop index="method" list="#remindermethods#">
						<cfset check = method & "ReminderCheck">
						<cfset text	= method & "ReminderText">
						<cfif isStruct(reminderTO.methods) and structKeyExists(reminderTO.methods, method)>
							<cfset success = setVariable(check,true)>
							<cfset success = setVariable(text,structFind(reminderTO.methods,method))>
						<cfelse>
							<cfset success = setVariable(check,false)>
							<cfset success = setVariable(text,"")>
						</cfif>
					</cfloop>
		
					<table border="0" cellpadding="2" cellspacing="0" class="be-style">
						<tr>
							<td style="padding:0px 0px 0px 24px;"><input name="emailReminderCheck" type="checkbox" <cfif emailReminderCheck>checked</cfif>></td>
							<td>#application.resource.bundle.text.email#:</td>
							<td><input name="emailReminderText" type="text" size="40" maxlength="64" value="<cfif emailReminderCheck>#emailReminderText#</cfif>"><br></td>
						</tr>
						<tr>
							<td valign="top" style="padding:0px 0px 0px 24px;"><input name="mobileReminderCheck" type="checkbox" <cfif mobileReminderCheck>checked</cfif>></td>
							<td valign="top">#application.resource.bundle.text.mobile_device#:</td>
							<td>
								<input name="mobileReminderText" type="text" size="40" maxlength="64" value="<cfif mobileReminderCheck>#mobileReminderText#</cfif>"><br>
								<span style="font-size:10px;">#application.resource.bundle.text.mobile_device_details#</span>
							</td>
						</tr>
					</table>
		
					<p align="right">
						<input name="reset" type="reset" value="#application.resource.bundle.button.clear#">
						<input name="submit" type="submit" value="#application.resource.bundle.button.update_reminder#">
					</p>
				</td>
			</tr>
		</table>
	</form>
</cfoutput>