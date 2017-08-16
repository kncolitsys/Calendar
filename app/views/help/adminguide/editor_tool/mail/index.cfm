<h3 class="bp-subtitle">Edit Automated Mail Responses</h3>

<div class="bp-text">
<p>calendarInfusion includes automated email responses based on specific events.	Specifically, the following actions will generate an automated email:
	<ul>
		<li>A user requests access to a calendar. (User Registration Received)</li>
		<li>A user is granted access to a calendar, either by an editor or automatically. (User Registration Approved)</li>
		<li>A user is denied access to a calendar. (User Registration Denied)</li>
	</ul>
The basic text of these automated email responses can be customized by calendar editors.
</p>

<p>In addition to the static text of these email messages, some basic variable user information can be used to customize these messages.	This information is available through a ColdFusion struct with the name &quot;user&quot;.	The values stored in this struct are: first name, last name, email address, phone, username, and password.	These values can be accessed by including #user.<span style="font-style:italic;">variable_name</span># in the email message (e.g. #user.username#).</p>

<p><span class="bp-heading">Modify the automated email response</span><br>
	To modify one of the automated email responses, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Mail</span> link in the navigation menu.</li>
		<li>In the selection list, select the action for which the email response should be modified.</li>
		<li>Click the <span class="bn-input">Edit</span> button.</li>
		<li>Make the appropriate changes to the email subject and/or body.</li>
		<li>Click the <span class="bn-input">OK</span> button.</li>
	</ol>
</p>
</div>