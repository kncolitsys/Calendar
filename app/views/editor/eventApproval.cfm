<cfparam name="request.calendar" default="">
<cfparam name="request.unapprovedEvents" default="">

<cfoutput>
<cfform action="index.cfm?cfevent=editor.events.approve.submitted&calendarId=#calendarId#" method="post">
	<table border="1" cellpadding="0" cellspacing="0" class="bpd-style">
		<tr class="bpd-title">
			<td colspan="3"><span style="font-weight:bold;">#application.resource.bundle.text.events_to_be_approved#</span></td>
		</tr>

		<cfif isQuery(request.unapprovedEvents) and val(request.unapprovedEvents.recordCount) gt 0>
			<tr>
				<th width="10%" align="center">#application.resource.bundle.text.approve#</td>
				<th width="10%" align="center">#application.resource.bundle.text.delete#</td>
				<th align="left">#application.resource.bundle.text.event#</td>
			</tr>
			<cfloop query="request.unapprovedEvents">
				<input name="eventList" type="hidden" value="#trim(request.unapprovedEvents.seriesId)#" />
				<tr>
					<td align="center"><input name="event_approval_#trim(request.unapprovedEvents.seriesId)#" type="radio" value="1"></td>
					<td align="center"><input name="event_approval_#trim(request.unapprovedEvents.seriesId)#" type="radio" value="0"></td>
					<td nowrap><a href="index.cfm?cfevent=event.edit&calendarId=#calendarId#&id=#trim(request.unapprovedEvents.seriesId)#">#trim(title)#</a></td>
				</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td colspan="3" align="center"><br><div>#application.resource.bundle.text.no_events_waiting_for_approval#</div><br></td>
			</tr>
		</cfif>
	</table>
	<br>
	<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
		<tr>
			<td colspan="3" align="right">
				<input name="btn_Reset" type="reset" value="#application.resource.bundle.button.reset#">
				<input name="btn_Finish" type="submit" value="#application.resource.bundle.button.ok#">
			</td>
		</tr>
	</table>
</cfform>
</cfoutput>