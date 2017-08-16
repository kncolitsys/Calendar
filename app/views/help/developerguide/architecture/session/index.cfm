<h3 class="bp-subtitle">Session Management</h3>

<div class="bp-text">
<p>The session management mechanism is used to provide a basic framework to allow Infusion Technology applications to authorize users to perform certains actions.	The framework interfaces with the native ColdFusion CFLOGIN framework, which provides the actual authorization mechanism.</p>

<p>Under normal circumstances, when a user accesses an Infusion Technology application for the first time, the user is authenticated as an anonymous user (and, in most cases, anonymous users are granted fairly limited privileges to an application).  If the user logs into the application, the user is then authenticated using the passportInfusion API.  If the user successfully authenticates, their effective privileges are determined (again, using the passportInfusion API) and the user session is initialized within the CFLOGIN framework.  If a user later logs out of a context or a session timeout occurs (by default, after 30 minutes), the CFLOGIN framework is reset and the next time the user accesses the application he will again be authenticated as an anonymous user.  All of this logic is contained within the &lt;webroot&gt;/shared/includes/session_manager.cfm file.</p>

<p>In addition, when a user authenticates themselves, they also have the option to store their authentication information in the form of a cookie.	If their login is successful, the cookie is set and the next time the user returns to the context (even if it is during a different user session), their permissions will be automatically set to the appropriate values.	(Note: Any cookies that are set expire within 30 days, requiring the user to login once again after that time.)</p>
</div>