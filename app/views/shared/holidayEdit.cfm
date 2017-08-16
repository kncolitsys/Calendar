<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 HolidayEditPanel::display
*
* Description:
*	 Display a panel for editing a holiday.
*
****************************************************************************
--->

<cfif request.event.isArgDefined("holidayBean")>
	<cfset holidayTO = request.event.getArg("holidayBean").getHolidayTO() />
<cfelse>
	<cfset holidayTO = request.holiday.getHolidayTO() />
</cfif>

<cfswitch expression="#lcase(cfevent)#">
	<cfcase value="administrator.holiday.new">
		<cfset holidayTO.global = true />
	</cfcase>
	<cfcase value="administrator.holiday.edit">
		<cfset holidayTO.global = true />
	</cfcase>
	<cfdefaultcase>
		<cfset holidayTO.global = false />
	</cfdefaultcase>
</cfswitch>

<!---// Decode the recurrence information, so it's usable on this form. --->
<cfset rule = trim(holidayTO.recurrenceRule)>
<cfset type = getToken(rule, 1, "_")>

<!---
// Possible recurrence rule formats:
//	 d_<mm>_<dd>			 // date-based (mm=month, dd=day)
//	 o_<x>_<d>_<mm>	 // offset-based (x=offset, d=dayOfWeek, mm=month)
//	 a_<algorithm>		// algorithm-based (i.e. given a year, calculate the holiday)
--->

<!---// First, initialize all of the possible variables. --->
<cfparam name="recurType" default="d">
<cfparam name="recurNYear" default="0">
<cfparam name="recurNMonth" default="0">
<cfparam name="recurNDay" default="0">
<cfparam name="recurDDay" default="0">
<cfparam name="recurDMonth" default="0">
<cfparam name="recurDDay" default="0">
<cfparam name="recurOOffset" default="0">
<cfparam name="recurODow" default="0">
<cfparam name="recurOMonth" default="0">
<cfparam name="recurAAlgorithm" default="">

<!---// Pre-process the recurrence information. --->
<cfset recurType = type>
<cfswitch expression="#lCase(type)#">
	<cfcase value="d">
		<cfset recurDMonth = getToken(rule, 2, "_")>
		<cfset recurDDay	 = getToken(rule, 3, "_")>
	</cfcase>
	<cfcase value="o">
		<cfset recurOOffset = getToken(rule, 2, "_")>
		<cfset recurODow		= getToken(rule, 3, "_")>
		<cfset recurOMonth	= getToken(rule, 4, "_")>
	</cfcase>
	<cfcase value="a">
		<cfset recurAAlgorithm = getToken(rule, 2, "_")>
	</cfcase>
	<cfcase value="n">
		<cfset recurNYear	= getToken(rule, 2, "_")>
		<cfset recurNMonth = getToken(rule, 3, "_")>
		<cfset recurNDay	 = getToken(rule, 4, "_")>
	</cfcase>
</cfswitch>

<script language="javascript">
<!--//
function validateDelete(form) {
	del = confirm("<cfoutput>#application.resource.bundle.text.delete_holiday_warning#</cfoutput>");
	if(del) {
		form.action='index.cfm?cfevent=holiday.delete&calendarId=<cfoutput>#calendarId#</cfoutput>';
		return true;
	} else {
		return false;
	}
}

function validateData(form) {
	// Check that the event date is a valid date
	i=0;
	while(i < form.recurType.length) {
		if(form.recurType[i].checked==true)
			recurTypeSelected = i;
		i++;
	}

	switch (recurTypeSelected) {
		case 0:	// occurs once
			d = new Date(form.recurNYear.value,form.recurNMonth.value-1,form.recurNDay.value);
			if(d.getDate()!=form.recurNDay.value) {
				alert("<cfoutput>#application.resource.bundle.text.date_not_valid#</cfoutput>");
				return false;
			}
			break;
		case 1:	// occurs every year on particular day
			var dates = new String("31,28,31,30,31,30,31,31,30,31,30,31");
			monthDates = dates.split(",");
			if((monthDates[form.recurDMonth.value-1] - form.recurDDay.value) < 0) {
				alert("<cfoutput>#application.resource.bundle.text.date_not_valid#</cfoutput>");
				return false;
			}
			break;
		case 2:	// occurs every year on particular offset
			break;
		case 3:	// recurrence calculated using algorithm
			break;
		default:
			break;
	}
	
	// If all validation tests pass, then submit the event
	return true;
}
//-->
</script>

<cfform action="index.cfm?cfevent=#cfevent#.submitted&calendarId=#calendarId#" method="post">
	<input name="holidayId" type="hidden" value="<cfoutput>#holidayTO.holidayId#</cfoutput>" />
	<input name="global" type="hidden" value="<cfoutput>#holidayTO.global#</cfoutput>" />

	<table class="bpd-style">
		<tr>
			<td><cfoutput>#application.resource.bundle.text.holiday#</cfoutput>:</td>
			<td>
				<input name="title" type="text" size="30" maxlength="50" value="<cfoutput>#trim(holidayTO.title)#</cfoutput>">
			</td>
		</tr>
		<tr>
			<td colspan="4"><input name="recurrenceMaximized" type="hidden" value="1"></td>
		</tr>
		<tr>
			<td valign="top" colspan="4">
				<input name="recurType" type="radio" value="n" <cfif recurType eq "n">checked</cfif>>&nbsp;<cfoutput>#application.resource.bundle.text.occurs_once_on#</cfoutput>
				<select name="recurNMonth" onFocus="this.form.recurType[0].checked='true'">
					<cfloop index="i" from="1" to="12">
						<cfoutput><option value="#i#" <cfif recurNMonth eq i>selected</cfif>>#monthAsString(i)#</option></cfoutput>
					</cfloop>
				</select>
				
				<select name="recurNDay" onFocus="this.form.recurType[0].checked='true'">
					<cfloop index="i" from="1" to="31">
						<cfoutput><option value="#i#" <cfif recurNDay eq i>selected</cfif>>#i#</option></cfoutput>
					</cfloop>
				</select>
				
				<cfset year = year(now())>
				<cfif recurNYear lt evaluate(year-1)>
					<cfset recurNYear = year(now())>
				</cfif>
				<select name="recurNYear" onFocus="this.form.recurType[0].checked='true'">
					<cfloop index="i" from="#evaluate(year-1)#" to="#evaluate(year+8)#">
						<cfoutput><option value="#i#" <cfif recurNYear EQ i>selected</cfif>>#i#</option></cfoutput>
					</cfloop>
				</select>
				<br>
				
				<input name="recurType" type="radio" value="d" <cfif recurType eq "d">checked</cfif>>&nbsp;<cfoutput>#application.resource.bundle.text.recurrence_year#</cfoutput>
				<select name="recurDMonth" onFocus="this.form.recurType[1].checked='true'">
					<cfloop index="i" from="1" to="12">
						<cfoutput><option value="#i#" <cfif recurDMonth eq i>selected</cfif>>#monthAsString(i)#</option></cfoutput>
					</cfloop> 
				</select>
				
				<select name="recurDDay" onFocus="this.form.recurType[1].checked='true'">
					<cfloop index="i" from="1" to="31">
						<cfoutput><option value="#i#" <cfif recurDDay eq i>selected</cfif>>#i#</option></cfoutput>
					</cfloop>
				</select>
				<br>
				
				<input name="recurType" type="radio" value="o" <cfif recurType eq "o">checked</cfif>>&nbsp;<cfoutput>#application.resource.bundle.text.recurrence_years_1#</cfoutput>
				<cfset periods = application.resource.bundle.text.recurrence_years_2>
				<select name="recurOOffset" onFocus="this.form.recurType[2].checked='true'">
					<cfloop index="i" from="1" to="5">
						<cfoutput><option value="#i#" <cfif recurOOffset eq i>selected</cfif>>#listGetAt(periods,i)#</option></cfoutput>
					</cfloop>						
				</select>
				
				<select name="recurODow" onFocus="this.form.recurType[2].checked='true'">
					<cfloop index="i" from="1" to="7">
						<cfoutput><option value="#i#" <cfif recurODow EQ i>selected</cfif>>#dayOfWeekAsString(i)#</option></cfoutput>
					</cfloop>
				</select>
				<cfoutput>#application.resource.bundle.text.recurrence_years_3#</cfoutput>
				<select name="recurOMonth" onFocus="this.form.recurType[2].checked='true'">
					<cfloop index="i" from="1" to="12">
						<cfoutput><option value="#i#" <cfif recurOMonth eq i>selected</cfif>>#monthAsString(i)#</option></cfoutput>
					</cfloop> 
				</select>
				<br>
				
				<input name="recurType" type="radio" value="a" <cfif recurType eq "a">checked</cfif>>&nbsp;<cfoutput>#application.resource.bundle.text.use_algorithm#</cfoutput>:<br>
				<textarea name="recurAAlgorithm" rows="5" cols="60" onFocus="this.form.recurType[3].checked='true'"><cfoutput>#trim(recurAAlgorithm)#</cfoutput></textarea> 
				<br>						
			</td>
		</tr>
	</table>
	<br>
	<table class="bpd-style">
		<tr>
			<td class="bpd-style" colspan="2" align="right">
				<input name="delete" type="submit" value="<cfoutput>#application.resource.bundle.button.delete#</cfoutput>" onclick="return validateDelete(this.form);">
				<input name="submit" type="submit" value="<cfoutput>#application.resource.bundle.button.ok#</cfoutput>" onClick="return validateData(this.form);">
			</td>
		</tr>
	</table>
</cfform>

