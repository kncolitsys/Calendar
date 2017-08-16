<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:
*	 EventEditPanel::display
*
* Description:
*	 Display a panel for editing an event.
*
****************************************************************************
--->
<cfif arguments.event.isArgDefined("newEventBean")>
	<cfset request.eventItem = arguments.event.getArg("newEventBean") />
</cfif>
<cfset eventTO = request.eventItem.getEventTO() />

<!---// Determine the appropriate timezone adjustment. --->
<cfset tz = getProperty("timezoneLibrary") />
<cfset sessionFacade = getProperty("sessionFacade") />
<cfset timezone = iif(sessionFacade.hasUser(), sessionFacade.getUser().getTimezone(), request.timezone) />

<!---// Decode the date time, for use on this form--->
<cfset startDT = trim(tz.toLocal(eventTO.startDateTime,timezone)) />
<cfset duration = val(eventTO.duration)>

<cfif not isDate(startDT)><cfset startDT = now()></cfif>
<cfif not isNumericDate(duration)>
	<cfset duration = 3600>
</cfif>

<!--- // Initialize the necessary variables. --->
<cfparam name="startDT_h" default="0">
<cfparam name="startDT_m" default="0">
<cfparam name="startDT_t" default="0">
<cfparam name="duration_h" default="1">
<cfparam name="duration_m" default="0">

<!---// Pre-process the start time information. --->
<cfif isDefined("allDay")>
	<cfset startDateTime_h = 0>
	<cfset startDateTime_m = 0>
	<cfset startDateTime_t = 0>
	
	<cfset duration_h = 24>
	<cfset duration_m = 0>
<cfelse>
	<cfset startDateTime_h = iif((hour(startDT) mod 12) eq 0, 12, hour(startDT) mod 12)>
	<cfset startDateTime_m = minute(startDT)>
	<cfset startDateTime_t = int(hour(startDT) / 12)>

	<cfset duration_h = int(evaluate(duration / (3600)))>
	<cfset duration_m = int(evaluate((duration - duration_h * 3600) / 60))>
</cfif>

<!--- // Initialize the necessary variables. --->
<cfparam name="recurType" default="n">
<cfparam name="recurCFreq" default="0">
<cfparam name="recurCPeriod" default="">
<cfparam name="recurWFreq" default="0">
<cfparam name="recurWDays" default="">
<cfparam name="recurMFreq" default="0">
<cfparam name="recurMOffset" default="0">
<cfparam name="recurMDay" default="0">
<cfparam name="recurEndDate" default="#now()#">

<cfset recurType = getToken(trim(eventTO.recurrenceRule), 1, "_")>

<!---// Pre-process the recurrence information. --->
<cfswitch expression="#lCase(recurType)#">
	<cfcase value="c">
		<cfset recurCFreq = getToken(trim(eventTO.recurrenceRule), 2, "_")>
		<cfset recurCPeriod = getToken(trim(eventTO.recurrenceRule), 3, "_")>
	</cfcase>
	<cfcase value="w">
		<cfset recurWFreq = getToken(trim(eventTO.recurrenceRule), 2, "_")>
		<cfset recurWDays = getToken(trim(eventTO.recurrenceRule), 3, "_")>
	</cfcase>
	<cfcase value="m">
		<cfset recurMFreq = getToken(trim(eventTO.recurrenceRule), 2, "_")>
		<cfset recurMOffset = getToken(trim(eventTO.recurrenceRule), 3, "_")>
		<cfset recurMDay = getToken(trim(eventTO.recurrenceRule), 4, "_")>
	</cfcase>
</cfswitch>
<cfif len(recurType) eq 0><cfset recurType = "n"></cfif>


<!---// Get a list of all categories associated with this calendar. --->
<!---<cfinvoke component="#eventTO.calendar#" method="getCategories" returnvariable="q_categories">--->
<cfset q_categories = queryNew("categoryDsid") />

<!---// Get the status of the event. --->
<cfinvoke component="#request.eventItem#" method="getStatus" returnvariable="eventStatus" calendarId="#calendarId#">

<script language="JavaScript" type="text/javascript" src="scripts/cfform.js"></script>
<script language="JavaScript" src="scripts/popcalendar.js"></script>

<script language="javascript">
<!--//
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_event_warning#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=event.delete&cid=<cfoutput>#calendarId#</cfoutput>';
		return true;
	} else {
		return false;
	}
}

function validateData(form) {
	if	(!_CF_hasValue(form.title, "TEXT" ))
		if	(!_CF_onError(form, form.title, form.title.value, "Please enter the Title of the Event."))
			return false;

	/*
	if	(!_CF_hasValue(form.contactFirstName, "TEXT" ))
		if	(!_CF_onError(form, form.contactFirstName, form.contactFirstName.value, "Please enter the first name of the contact person."))
			return false;

	if	(!_CF_hasValue(form.contactLastName, "TEXT" ))
		if	(!_CF_onError(form, form.contactLastName, form.contactLastName.value, "Please enter the last name of the contact person."))
			return false;

	if	(!_CF_hasValue(form.contactEmail, "TEXT" ))
		if	(!_CF_onError(form, form.contactEmail, form.contactEmail.value, "Please enter an email address for the contact person."))
			return false;

	if(form.categoryId.value.length!=<cfoutput>#len(createUuid())#</cfoutput>) {
		alert("Please select an event category.");
		return false;
	}
	*/
		
	// Check that the event date is a valid date
	d = new Date(form.startDate_y.value,form.startDate_m.value-1,form.startDate_d.value);
	if(d.getDate()!=form.startDate_d.value) {
		alert("<cfoutput>#application.resource.bundle.text.event_date_not_valid#</cfoutput>");
		return false;
	}

	// If the event has a recurrence end date, check that it is a valid date
	d = new Date(form.recurEndDate_y.value,form.recurEndDate_m.value-1,form.recurEndDate_d.value);
	if(typeof(form.recurForever[0]) != "undefined")
		if(form.recurForever[0].checked==true && d.getDate()!=form.recurEndDate_d.value) {
		alert("<cfoutput>#application.resource.bundle.text.recurrence_end_date_not_valid#</cfoutput>");
		return false;
	}

	var valid = true;
	if(form.contactEmail.value.len > 0) {
		valid = validateEmailAddress(form.contactEmail.value);
		if(!valid) {
			alert("The Contact Person email address (" + form.contactEmail.value + ") does not appear to be a valid email address.\n");
			return false;
		}
	}

	// If all validation tests pass, then submit the event
	return true;
}

function validateEmailAddress(email) {
	var pattern = /^\W*[\w\-\.]*\@[\w\-\.]*\.[\w\-]*\W*$/i;
	return pattern.test(email);
}
//-->
</script>

<cfform name="main" action="index.cfm?cfevent=#cfevent#.submitted&calendarId=#calendarId#" method="post">
	<cfoutput>
		<input name="eventId" type="hidden" value="#eventTO.eventId#" />
		<input name="seriesId" type="hidden" value="#eventTO.seriesId#" />
		<input name="resetForm" type="hidden" value="true">
		<input name="calendarId" type="hidden" value="#trim(request.calendar.getCalendarId())#">
		
		<span class="bp-subtitle" style="font-size: 18px; font-weight: bold;">#iif(true, de(application.resource.bundle.text.event_title_add), de(application.resource.bundle.text.event_title_edit))# #application.resource.bundle.text.event_title_event#</span><br>

		<!---
		// NOTE: This panel is used in both the calendar *AND* the editor tool, so we shouldn't
		// include a standard "Options" menu unless we handle this context difference.	We don't
		// current do so.
		--->
		<!-- Calendar Options -->
		<cfinclude template="../shared/eventViewOptions.cfm" />
	
		<!-- Basic Event Information -->
		<a name="eventSection"></a>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr class="bpd-title">	
				<td colspan="4">#application.resource.bundle.text.event_information#</td>
			</tr>
			<tr class="bpd-subtitle">
				<td colspan="4">#application.resource.bundle.text.event_information_summary#</td>
			</tr>
		
			<!---
			// Check security credentials to determine if user can approve
			// events.	If so, give them the option to edit this.
			--->
		<cfif getProperty("sessionFacade").isSessionAuthorized(uCase("#calendarId#_APPROVE_EVENTS"))>
				<tr>
					<td>#application.resource.bundle.text.status#:</td>
					<td colspan="3">
						<select name="status" size="1">
							<option value="#application.app.global.calendar.status.pending#" <cfif eventStatus eq application.app.global.calendar.status.pending>selected</cfif>>#application.resource.bundle.text.pending#</option>
							<option value="#application.app.global.calendar.status.approved#" <cfif eventStatus eq application.app.global.calendar.status.approved>selected</cfif>>#application.resource.bundle.text.approved#</option>
						</select>
					</td>
				</tr>
			<cfelse>
				<input name="status" type="hidden" value="#eventStatus#">
			</cfif>
			<tr>
				<td>#application.resource.bundle.text.title_of_event#:</td>
				<td colspan="3"><input name="title" type="text" size="30" maxlength="50" value="#trim(eventTO.title)#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.location#:</td>
				<td colspan="3">
					<input name="location" type="text" size="30" maxlength="100" value="#trim(eventTO.location)#">
				</td>
			</tr>
			<tr>
				<td valign="top">#application.resource.bundle.text.description#:</td>
				<td colspan="3">
					<!---// CODE: I should probably make fckeditor an option, rather than require its usage --->
					<cfif true>
						<cfscript>
							fckEditor = createObject("component", "calendar.components.fckeditor.fckeditor");
							fckEditor.instanceName	= "description";
							fckEditor.value			= '#trim(eventTO.description)#';
							fckEditor.basePath		= "scripts/fckeditor/";
							fckEditor.width			= "100%";
							fckEditor.height		= 200;
							fckEditor.create(); // create the editor.
						</cfscript>
					<cfelse>
						<textarea name="description" cols="40" rows="5" wrap="virtual">#trim(eventTO.description)#</textarea>
					</cfif>
				</td>
			</tr>
		</table>
		<br>
		<!-- End Basic Event Information -->

		<!-- Scheduling Information -->
		<a name="scheduleSection"></a>
		<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr class="bpd-title">
				<td colspan="4">#application.resource.bundle.text.scheduling_information#</td>		
			</tr>
			<tr class="bpd-subtitle">
				<td colspan="4">#application.resource.bundle.text.scheduling_information_summary#</td>
			</tr>
			<tr>
				<td>
					#application.resource.bundle.text.date#:
				</td>
				<td colspan="4">
					<input name="startDate" type="text" size="10" maxlength="10" value="#dateformat(startDT,'mm/dd/yyyy')#" />
					<img src="images/icon_calendar.gif" border="0" align="absmiddle" onClick="popUpCalendar(this, document.all.startDate, 'mm/dd/yyyy', 0, 0)" style="cursor:hand;cursor:pointer;"><br />
				</td>
			</tr>
			<tr>
				<td>
					#application.resource.bundle.text.start_time#:
				</td>
				<td>
					<select name="startDateTime_h" <cfif eventTO.allDay eq true>disabled="true"</cfif>>
						<cfloop index="i" from="1" to="12">
							<option value="#i#" <cfif startDateTime_h eq i>selected</cfif>> #numberFormat(i, '00')#</option>
						</cfloop>
					</select>
					<select name="startDateTime_m" <cfif eventTO.allDay eq true>disabled="true"</cfif>>
						<cfloop index="i" from="0" to="55" step="5">
							<option value="#i#" <cfif startDateTime_m eq i>selected</cfif>> #numberFormat(i, '00')#</option>
						</cfloop>
					</select>
					<select name="startDateTime_t" <cfif eventTO.allDay eq true>disabled="true"</cfif>>
						<option value="0" <cfif startDateTime_t eq 0>selected</cfif>>#application.resource.bundle.text.time_marker_am#</option>
						<option value="1" <cfif startDateTime_t eq 1>selected</cfif>>#application.resource.bundle.text.time_marker_pm#</option>
					</select>
				</td>
				<td>
					#application.resource.bundle.text.duration#:
				</td>
				<td>
					<select name="duration_h" <cfif eventTO.allDay eq true>disabled="true"</cfif>>
						<cfloop index="i" from="1" to="23">
							<option value="#i#" <cfif duration_h eq i>selected</cfif>> #numberFormat(i, '00')#</option>
						</cfloop>
					</select> :
					<select name="duration_m" <cfif eventTO.allDay eq true>disabled="true"</cfif>>
						<cfloop index="i" from="0" to="55" step="5">
							<option value="#i#" <cfif duration_m eq i>selected</cfif>> #numberFormat(i, '00')#</option>
						</cfloop>
					</select><br>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<script language="javascript">
						function toggleTimes(form, bool) {
							form.startDateTime_h.disabled = bool;
							form.startDateTime_m.disabled = bool;
							form.startDateTime_t.disabled = bool;
							form.duration_h.disabled = bool;
							form.duration_m.disabled = bool;
						}
					</script>
					<br><input name="allDay" type="checkbox" value="1" onclick="toggleTimes(this.form, this.checked);" <cfif eventTO.allDay eq true>checked</cfif>> #application.resource.bundle.text.all_day_event#<br>
				</td>
			</tr>
		</table>
		</div>
		<!-- End Scheduling Information -->
		<br>
		
		<!-- Category Information -->
		<a name="categoriesSection"></a>
		<cfif isQuery(request.categories) and val(request.categories.recordCount) gt 0>
			<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
				<tr class="bpd-title">	
					<td colspan="4">
						#application.resource.bundle.text.category_information#
					</td>		
				</tr>

				<tr class="bpd-subtitle">
					<td colspan="4">#application.resource.bundle.text.category_information_summary#</td>		
				</tr>
				<tr>
					<td valign="top">#application.resource.bundle.text.category#</td>
					<td>
						<cfset categoryTO = eventTO.category />
						<select name="categoryId" size="1">
							<option value="">(#application.resource.bundle.text.select_category#)</option>
							<cfloop query="request.categories">
								<option value="#trim(categoryId)#" <cfif compareNoCase(trim(categoryTO.getCategoryId()),trim(categoryId)) eq 0>selected</cfif>> #trim(categorytitle)#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
			<br>
		<cfelse>
			<cfif isDefined("eventTO.category.id")>
				<cfset categoryId = trim(eventTO.category.id)>
			<cfelse>
				<cfset categoryId = "">
			</cfif>
			<input name="categoryId" type="hidden" value="#categoryId#">
		</cfif>
		<!-- End Category Information -->
		
		<!-- Contact Information -->
		<a name="contactSection"></a>
		<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr class="bpd-title">	
				<td colspan="4">
					#application.resource.bundle.text.contact_information#
				</td>		
			</tr>
			<tr class="bpd-subtitle">
				<td colspan="4">#application.resource.bundle.text.contact_information_summary#</td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.first_name#</td>
				<td colspan="3"><input name="contactFirstName" type="text" size="30" maxlength="30" value="#trim(eventTO.contactFirstName)#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.last_name#</td>
				<td colspan="3"><input name="contactLastName" type="text" size="30" maxlength="30" value="#trim(eventTO.contactLastName)#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.email#</td>
				<td colspan="3"><input name="contactEmail" type="text" size="30" maxlength="40" value="#trim(eventTO.contactEmail)#"></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.phone#</td>
				<td colspan="3"><input name="contactPhone" type="text" size="20" maxlength="20" value="#trim(eventTO.contactPhone)#"></td>
			</tr>
		</table>
		<!-- End Contact Information -->
		<br>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td colspan="4" align="right">
					<cfif true><input name="delete" type="submit" value="#application.resource.bundle.button.delete#" onClick="return validateDelete(this.form);"></cfif>
					<input name="Submit" type="submit" value="#application.resource.bundle.button.ok#" onClick="return validateData(this.form);">
				</td>
			</tr>
		</table>
		<br>

		<!---// Server-side validation rules. --->
		<input name="title_required" type="hidden" value="#application.resource.bundle.text.enter_title_of_event_warning#">
	</cfoutput>
</cfform>

<script>
	initForm();
	
	function initForm() {
		if(<cfoutput>#val(eventTO.allDay)#</cfoutput> == 1) {
			toggleTimes(document.main, true);
		}
	}
</script>