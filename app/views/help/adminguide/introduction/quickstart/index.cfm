<h3 class="bp-subtitle">Quick-Start Guide</h3>

<div class="bp-text">
There are some basic tasks that you will want to perform to make full use of all of the features of calendarInfusion.	The first set of tasks will require use of the calendarInfusion Administrator Tool, which provides general application-level administration.	To login to the Administrator Tool, follow these steps:
<ol>
	<li>Go to the main webpage for your calendarInfusion installation.</li>
	<li>Click on the <span class="bn-input">Login</span> link and login using the main administrator account that was specified when installing calendarInfusion.</li>
	<li>Once you have successfully logged into the application with an account with administrative privileges, an <span class="bn-input">Administrator</span> link should be displayed.	Click this link to access the Administrator Tool.</li>
</ol>

After performing the application-level configuration, the vast majority of the calendar-level administration will be complete using the calendarInfusion Editor Tool.	To access the Editor Tool, follow these steps:
<ol>
	<li>Go to the main webpage for your calendarInfusion installation.</li>
	<li>Click on the link for the calendar you are interested in administering.</li>
	<li>If you have not already done so, login to a user account that has administrative privileges for this calendar.</li>
	<li>Once you have successfully logged into the application with an account with administrative privileges, an <span class="bn-input">Editor</span> link should be displayed at the top of the page.	Click this link to access the Editor Tool.</li>
</ol>

Now that you are familiar with how to access the various administrative interfaces, you can now begin to customize calendarInfusion for your use.
<ul>
	<li>One of the first things you will probably want to do is rename the default calendar to something more meaningful:
		<ol>
			<li>Login to the Administrator Tool and click on the <span class="bn-input">Calendar</span> link in the navigation menu.</li>
			<li>Select the default calendar from the drop-down list and click the <span class="bn-input">Edit</span> button.</li>
			<li>Edit the calendar title and click the <span class="bn-input">OK</span> button.</li>
		</ol>
	</li>
	<br>
	
	<li>In order to use the email features of calendarInfusion (event reminders and automated mail responses), you will need to configure a mail server for use by calendarInfusion:
		<ol>
			<li>Login to the Administrator Tool and click on the <span class="bn-input">Mail</span> link in the navigation menu.</li>
			<li>Edit the mail server information for your environment.	In many cases, you will simply need to update the server name.	In rare circumstances, you may need to modify the default values for the port (25) and timeout (10).	These values directly correspond to the values used by the CFMAIL tag.</li>
		</ol>
	</li>
	<br>
	
	<li>In many cases, you may want to allow users to access calendars without requiring them to have individual user accounts.	In this situation, you will want to create an anonymous user account:
		<ol>
			<li>Login to the Administrator Tool and click on the <span class="bn-input">passportInfusion</span> link in the navigation menu.	This will open the passportInfusion Administrator Tool.	(You could also go directly to the passportInfusion administrator tool.)</li>
			<li>Login to the passportInfusion Administrator Tool.</li>
			<li>Click on the <span class="bn-input">Users</span> link in the navigation menu.</li>
			<li>Select <span class="bn-input">Create a new user</span> in the drop-down list and click the <span class="bn-input">Edit</span>.</li>
			<li>Create the anonymous user.</li>
			<li>Once you have created the user, select this user from the drop-down list and click <span class="bn-input">Edit</span> button.</li>
			<li>Select the default caledar from the <span class="bn-input">Context</span> drop-down list and click the <span class="bn-input">Change Context</span> button.</li>
			<li>You should now see a list of permissions that can be granted to this user for this calendar. Select the appropriate permissions and click the <span class="bn-input">OK</span> button.</li>
			<li>You have now create and configured the anonymous user account.	The final step will be to associate this account with the calendar.</li>
		</ol>
	</li>
	<br>
	
	<li>If you previously used the eDay Web Event Calendar application, you may import the eDay event data into calendarInfusion using the database import process:
		<ol>
			<li>Login to the Administrator Tool and click on the <span class="bn-input">DB Import</span> link in the navigation menu.</li>
			<li>Follow the detailed instructions to import the eDay database.</li>
		</ol>
	</li>
</ul>

</div>