<cfparam name="selected" default=""/>
<cfparam name="calendarId" default=""/>

<cfoutput>#request.holidaySelectionList#</cfoutput>

<br/><br/>

<cfset cols = 3 />

<div>
<cfoutput>
Display Holidays:<br/><br/>
<form action="index.cfm?cfevent=editor.holidays.display.submitted&calendarId=#calendarId#" method="post">
	<table width="100%" style="border:1px solid silver;">
		<tr>
			<td width="#evaluate(100/cols)#%" valign="top">
				<cfloop query="request.holidays">
					<cfset id = holidayId />
					<cfset checked = false />
					<cfloop query="request.displayedHolidays">
						<cfif id eq holidayId>
							<cfset checked = checked or true />
						</cfif>
					</cfloop>
					<input name="acceptedHolidays" type="checkbox" onChange="document.getElementById('#holidayId#').style.backgroundColor='##cccccc';" value="#trim(request.holidays.holidayId)#" <cfif checked>checked</cfif> /> <span id="#holidayId#">#trim(title)#</span><br/>
					<cfif request.holidays.currentRow mod ceiling(request.holidays.recordCount/cols) eq 0>
						</td><td width="#evaluate(100/cols)#%" valign="top">
					</cfif>
				</cfloop>
			</td>
		</tr>
		<tr>
			<td colspan="#cols#" align="right">
				<input name="submit" type="submit" value="Update"/>
			</td>
		</tr>
	</table>
</form>
</cfoutput>
</div>