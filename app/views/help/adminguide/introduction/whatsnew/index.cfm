<h3 class="bp-subtitle">What's New in calendarInfusion</h3>

<div class="bp-text">

<p>The easier question is "What <span style="font-weight">isn't<span> new in calendarInfusion?"	The answer... very little.	calendarInfusion 2.0 was developed from the ground up, taking the best features of the eDay Event Calendar (aka calendarInfusion 1.0) and completely re-architecting it.	The result is an application with an improved set of features, an simpler development framework, and an architecture that more closely ties into the latest version of ColdFusion.</p>

<p>The biggest change for calendarInfusion 2.0 is the completely new architecture.	calendarInfusion 2.0 uses a modified version of <a href="http://www.cfobjects.com/" target="_blank">cfObjects</a>, a framework for &quot;object-oriented&quot; ColdFusion development.	By using objects, calendarInfusion functionality is better encapsulated in discrete components.	These components are easier to extend, easier to debug, and the end result is a better application.</p>

<p>In addition to the use of objects, calendarInfusion also uses a MVC (Model-View-Controller) architecture.	This separates the user interface, business logic, and user interaction into distinct areas, which can be managed and modified fairly independently.	This also makes it easier to manage the development and administration of the calendarInfusion application.	A side-effect of this architecture is also improved security.	The ColdFusion templates that contain the application's business logic are no longer accessible through the web server, so it makes it more difficult for a malicious user to get information about the network/system environment in which your application is running.</p>

<p>Another huge benefit of this new architecture is that it more closely ties into the new features being integrated into the latest version of ColdFusion.	ColdFusion Server has better Java support and the ability to separate the user interface from the enterprise business logic, which may be running in a different process or a completely different server.	The new architecture allows future versions of calendarInfusion to make better use of these capabilities.</p>

<p>A short list of new features in calendarInfusion 2.0:
	
	<ul>
		<li>cfObjects and MVC architecture improves encapsulation, development, and security.</li>
		<li>Recurring events, with a wide variety of recurrence options.</li>
		<li>Event reminders to send email or pages prior to an event occurring.</li>
		<li>Automated email responses when users register, are approved, or are denied.</li>
		<li>Separation of user authentication and authorization into a dedicated user management system (passportInfusion).</li>
		<li>Separation of application and calendar management functionality, in order to distribute the administration workload.</li>
		<li>Pre-defined color schemes, with the ability to create your own.</li>
		<li>Support for holidays.	A number of holidays are pre-defined, and the ability exists to create your own.</li>
	</ul>
</p>
	
</div>