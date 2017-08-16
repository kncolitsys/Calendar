<h3 class="bp-subtitle">Security Management</h3>

<div class="bp-text">
<p>Security is an important part of any web application.	Security management provides a way to ensure that only authorized users are allowed to perform certain actions.	 The security of calendarInfusion is primarily handled within the &quot;controller&quot; component of the application.	Whenever a user accesses a web page within an Infusion Technology application, one of the first actions that is performed is to verify that a user has the appropriate privileges to access that web page.</p>

<p>Infusion Technology applications use the CFLOGIN framework to manage user security.  The security management code is contained in the &lt;webroot&gt;/shared/includes/session_manager.cfm file and this file acts as a wrapper to the CFLOGIN framework.	Once a user is authenticated, their authorized roles are stored using the CFLOGIN framework.  On subsequent page requests, individual actions are validated against this list of roles.  If the user has been granted the necessary privilege, the page is processed normally.	Otherwise, normal page processing is cancelled and an appropriate error message is displayed.	By performing this authorization check at the beginning of each web page, we can reasonably prevent unauthorized users from performing any inappropriate actions.</p>

</div>