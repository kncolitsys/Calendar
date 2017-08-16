<h3 class="bp-subtitle">Edit Events</h3>

<div class="bp-text">
<p>Events require the most time and effort to manage.	Events are constantly be added, modified, and deleted from the calendar.	In most cases, these activities occur on a daily basis.	The Editor Tool is designed to making managing events as easy as possible.	The information that can be specified for events is:<br><br>

<div style="padding-left: 20px;">
	<span style="font-weight:bold;">Event Information</span>
	<ul>
		<li><span class="bn-input">Status</span> - the current status of the event.	<span class="bn-input">Active</span> events are displayed in the calendar interface.	<span class="bn-input">Pending</span> events are not. (Pending events are only accessible through the Editor Tool interface).</li>
		<li><span class="bn-input">Title</span> - a brief title for the event</li>
		<li><span class="bn-input">Location</span> - the location of the event</li>
		<li><span class="bn-input">Description</span> - a detailed description of the event.</li>
	</ul>
	
	<span style="font-weight:bold;">Scheduling Information</span>
	<ul>
		<li><span class="bn-input">Date</span> - the date on which the event occurs.	(Multi-day events should specify recurrence parameters.)</li>
		<li><span class="bn-input">Start Time</span> - the start time of the event</li>
		<li><span class="bn-input">Duration</span> - the length of the event (hours : minutes)</li>
		<li><span class="bn-input">All Day Event</span> - indicates whether the event is an all-day event (e.g. a birthday).	If it is an all day event, then the <span class="bn-input">Start Time</span> and <span class="bn-input">Duration</span> information are ignored.</li>
	</ul>
	
	<span style="font-weight:bold;">Recurrence Information</span>
	<ul>
		<li>Recurrence Type:<br>
			<ul>
				<li>Cyclical - occurs on a periodic schedule (e.g. every 3 weeks)</li>
				<li>Weekly - a week-based event that occurs on a specific set of days (e.g. every week on Monday, Wednesday, and Friday)</li>
				<li>Offset - a month-based event that occurs at an offset to the beginning of the month (e.g. on the second Monday of the month)</li>
			</ul>
		
		</li>
		<li>Recurrence End Date - the date at which an event stops repeating.	If at all possible, a recurrence end date should be specified.	Having a calendar with numerous recurring events with no recurrence end dates can begin to affect performance.</li>
	</ul>

	<span style="font-weight:bold;">Category Information</span>
	<ul>
		<li><span class="bn-input">Category</span> - a category to associate with an event</li>
	</ul>
	
	<span style="font-weight:bold;">Contact Information</span>
	<ul>
		<li><span class="bn-input">First Name</span> - the first name of the contact person for this event</li>
		<li><span class="bn-input">Last Name</span> - the last name of the contact person for this event</li>
		<li><span class="bn-input">Email</span> - the email address of the contact person for this event</li>
		<li><span class="bn-input">Phone</span> - the phone number of the contact person for this event</li>
	</ul>
</div>
</p>

<p><span class="bp-heading">Create a new event</span><br>
	To modify the mail server configuration, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Events</span> link in the navigation menu of the Editor Tool.</li>
		<li>In the event selection list, select <span class="bn-input">Create a New Event</span>.</li>
		<li>Click the <span class="bn-input">Edit</span> button.</li>
		<li>Enter the event information.	Recurrence, Category, and Contact Information sections can be expanded or collapsed by clicking the [+] or [-] next to the section heading.</li>
		<li>Click the <span class="bn-input">Finish</span> button.</li>
	</ol>
</p>

<p><span class="bp-heading">Modify an existing event</span><br>
	To modify the mail server configuration, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Events</span> link in the navigation menu of the Editor Tool.</li>
		<li>In the event selection list, select the event to modify.</li>
		<li>Click the <span class="bn-input">Edit</span> button.</li>
		<li>Make the appropriate changes to the event information.	Recurrence, Category, and Contact Information sections can be expanded or collapsed by clicking the [+] or [-] next to the section heading.</li>
		<li>Click the <span class="bn-input">Finish</span> button.	The changes will be made immediately.</li>
	</ol>
</p>

<p><span class="bp-heading">Approve submitted events</span><br>
	To modify the mail server configuration, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Events</span> link in the navigation menu of the Editor Tool.</li>
		<li>Click the <span class="bn-input">Approve Events</span> button.</li>
		<li>If there are any event waiting to be approved, they will be displayed.	There are three options for handling these events:
			<ul>
				<li>Select <span class="bn-input">Approve</span> - the event will be approved and displayed in the calendar.</li>
				<li>Select <span class="bn-input">Delete</span> - the event will be permanently deleted from the database.</li>
				<li>Select neither option - the event will remain unchanged in a pending state.	(If an option is accidently selected and should be cleared, the entire list of choices can be cleared by clicking the <span class="bn-input">Reset</span> button.)</li>
			</ul>
		<li>Once the appropriate choices have been made, click the <span class="bn-input">Finish</span> button.</li>
	</ol>
</p>

</div>