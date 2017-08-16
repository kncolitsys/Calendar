<cfsetting enablecfoutputonly="yes">
<cfparam name="object" default="" />

<cfset upper = uCase(left(object,1)) & right(object,len(object)-1)>
<cfif compareNoCase(right(upper,1),"y") eq 0>
	<cfset upper_pl = left(upper,len(upper)-1) & "ies">
<cfelse>
	<cfset upper_pl = upper & "s">
</cfif>
<cfset lower = lCase(left(object,1)) & right(object,len(object)-1)><br>
<cfif compareNoCase(right(lower,1),"y") eq 0>
	<cfset lower_pl = left(lower,len(lower)-1) & "ies">
<cfelse>
	<cfset lower_pl = lower & "s">
</cfif>

<cfoutput>
<pre>
&lt;cfcomponent displayname=&quot;#lower#Gateway&quot; extends=&quot;calendar.models.dao.Gateway&quot;&gt;

	&lt;cffunction name=&quot;init&quot; access=&quot;public&quot; returntype=&quot;#lower#Gateway&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;dsn&quot; type=&quot;string&quot; required=&quot;true&quot; /&gt;
		&lt;cfargument name=&quot;factory&quot; type=&quot;calendar.models.dao.GatewayFactory&quot; required=&quot;true&quot; /&gt;
		&lt;cfset variables.dsn = arguments.dsn /&gt;
		&lt;cfset variables.factory = arguments.factory /&gt;
		&lt;cfreturn this /&gt;
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;
</pre>
</cfoutput>

<cfsetting showdebugoutput="no">
<cfsetting enablecfoutputonly="no">