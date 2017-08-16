<cfform action="index.cfm?cfevent=editor.mail.configuration.edit.submitted" method="post">
	<cfoutput>
		<input name="configuration" type="hidden" value="#configuration#">
		<input name="calendarId" type="hidden" value="#calendarId#">

		<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td>
					#application.resource.bundle.text.subject#:<br>
					<input name="subject" size="75" maxlength="75" value="#request.mailConfiguration.subject#">
				</td>
			</tr>
			<tr>
				<td>
					#application.resource.bundle.text.body#:<br>
					<textarea name="body" rows="15" cols="75" wrap="virtual">#request.mailConfiguration.body#</textarea>
				</td>
			</tr>
		</table>
		<br>
		<table border="0" cellpadding="0" cellspacing="0" class="bpd-style">
			<tr>
				<td align="right">
					<input name="submit" type="submit" value="#application.resource.bundle.button.ok#">
				</td>
			</tr>
		</table>
	</cfoutput>
</cfform>
