<h3 class="bp-subtitle">User and Group Management</h3>

<div class="bp-text">
<p>calendarInfusion is designed to integrate with passportInfusion, Infusion Technology's user and group management system.  passportInfusion provides a mechanism for managing user accounts and groups, in addition to the authentication and authorization of those users.  calendarInfusion integrates with passportInfusion through a standard API.  This provides two benefits to developers:</p>

<ol>
	<li>It eliminates the need for developers to understand the detailed designed of user and group management.  Developers need only understand how to interface with the API and let passportInfusion do the rest.</li>
	<li>By designing calendarInfusion around a standard API, it allows developers to replace passportInfusion altogether.  This provides the opportunity for calendarInfusion to use your organization's existing user and group management system, such as an LDAP database or Active Directory.</li>
</ol>

<p>passportInfusion uses three main objects to provide its user and group management capabilities:</p>

<ol>
	<li>Users</li>
	<li>Groups</li>
	<li>Contexts</li>
</ol>

<p>The definition of Users and Groups should be fairly obvious.  A User is an individual account representing an individual.  A Group is a set of users, that typically have some common characterstics.</p>

<p>A Context is a discrete section of an application (or the entire application itself) that has a set of permissions associated with it.  Users and groups may perform certain actions within a context based on the set of permissions granted to them.  Every time a user accesses an Infusion Technology application, they do so within the constraints of a Context.  For example, each calendar within the calendarInfusion application is considered to be a context.  Users accessing the calendar may perform certain actions, such as submitting events or editing events, based on the rights granted to them for that calendar by the calendarInfusion administrator.</p>

<p>Since the Infusion Technology application framework uses the CFLOGIN framework for its session management, each context can support an unlimited number of privileges.  For example, calendars within calendarInfusion have privileges such as &quot;view calendar,&quot; &quot;submit events,&quot; &quot;approve events,&quot; and &quot;administer calendar&quot; (to name just a few).</p>

<p>When a user accesses a context, the Infusion Technology framework determines the privileges the user has within that context.  The effective privileges that are granted to the user within a context are a result of the combination of the individual user's privileges and the privileges of all of the groups of which that user is a member.  Thus, an individual user may not have been granted the right to administer a calendar, but they may be a member of group that has been granted that right.  Therefore, the user may administer the calendar.</p>

<p>All of the functionality required to interface with passportInfusion is contained within the com.infusion.calendar.PassportInterface and com.infusion.framework.PassportInterface classes.  If desired, you can implement this API with your own custom code and, thus, replace passportInfusion within your own user and group management system.</p>
</div>