<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 SearchPanel::display
*
* Description:
*	 Displays a form to allow user to search the calendar.
*
****************************************************************************
--->
<cfparam name="calendarDate" default="#now()#">
<cfparam name="attributes.categories" default="">

<script language="JavaScript" type="text/javascript" src="scripts/cfform.js"></script>
<script language="JavaScript" src="scripts/popcalendar.js"></script>

<div class="bp-title"><cfoutput>#application.resource.bundle.text.calendar_search#</cfoutput></div>

<!-- Calendar Options -->
<cfinclude template="../shared/searchOptions.cfm" />

<table border="0" cellpadding="5" cellspacing="0" class="bpd-style">
	<cfform action="index.cfm?cfevent=calendar.search.results&calendarId=#calendarId#" method="post">
		<input name="startRow" type="hidden" value="1">
		<cfoutput>
			<tr>
				<td colspan="2">
					#application.resource.bundle.text.enter_search_criteria_below#
				</td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.keyword#</td>
				<td><input name="criteria" type="text" size="30" maxlength="30" value=""></td>
			</tr>
			<tr>
				<td>#application.resource.bundle.text.search_dates_1#</td>
				<td>
					#application.resource.bundle.text.search_dates_2#: <cfinput name="startDate" type="text" size="10" maxlength="10" value="" validate="date" message="#application.resource.bundle.text.start_date_invalid#">
					<img src="images/icon_calendar.gif" border="0" align="absmiddle" onClick="popUpCalendar(this, document.all.startDate, 'mm/dd/yyyy', 0, 0)" style="cursor:hand;cursor:pointer;">
					&nbsp;&nbsp;&nbsp;#application.resource.bundle.text.search_dates_3#: <cfinput name="endDate" type="text" size="10" maxlength="10" value="" validate="date" message="#application.resource.bundle.text.end_date_invalid#">
					<img src="images/icon_calendar.gif" border="0" align="absmiddle" onClick="popUpCalendar(this, document.all.endDate, 'mm/dd/yyyy', 0, 0)" style="cursor:hand;cursor:pointer;">
				</td>
			</tr>
		</cfoutput>
		
		<cfif isQuery(attributes.categories) and val(attributes.categories.recordCount) gt 0>
			<tr class="bpd-style">
				<td valign="top"><cfoutput>#application.resource.bundle.text.category#</cfoutput></td>
				<td>
					<select name="categories" multiple size="5">
						<cfoutput query="attributes.categories"><option value="#trim(id)#">#trim(title)#</option></cfoutput>
					</select>
				</td>
			</tr>
		</cfif>
		
		<tr>
			<td valign="top"><cfoutput>#application.resource.bundle.text.results_per_page#</cfoutput>:</td>
			<td>
				<select name="maxRows">
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="20">20</option>
				</select>
		</tr>
	</table>
	<br>
		
	<table border="0" cellpadding="5" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="2" align="right">
				<cfoutput>
					<input name="reset" type="reset" value="#application.resource.bundle.button.reset#">
					<input name="submit" type="submit" value="#application.resource.bundle.button.search#">
				</cfoutput>
			</td>
		</tr>
	</cfform>
</table>
