<cfsetting enablecfoutputonly="yes">
<cfparam name="listener" />
<cfparam name="components" />

<cfset upper_listener = uCase(left(listener,1)) & right(listener,len(listener)-1)>
<cfif compareNoCase(right(upper_listener,1),"y") eq 0>
	<cfset upper_listener_pl = left(upper_listener,len(upper_listener)-1) & "ies">
<cfelse>
	<cfset upper_listener_pl = upper_listener & "s">
</cfif>
<cfset lower_listener = lCase(left(listener,1)) & right(listener,len(listener)-1)><br>
<cfif compareNoCase(right(lower_listener,1),"y") eq 0>
	<cfset lower_listener_pl = left(lower_listener,len(lower_listener)-1) & "ies">
<cfelse>
	<cfset lower_listener_pl = lower_listener & "s">
</cfif>

<cfset variable_names = url.components>

<cfoutput>
<pre>
&lt;cfcomponent displayname=&quot;#upper_listener#Listener&quot; extends=&quot;MachII.framework.Listener&quot;&gt;

	&lt;cffunction name=&quot;configure&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;true&quot; displayname=&quot;Listener Constructor&quot;&gt;
		&lt;cfscript&gt;
			var appConstants = getAppManager().getPropertyManager().getProperty(&quot;appConstants&quot;);
			var dsn = appConstants.getDbDsn();
			var dbType = appConstants.getDbType();<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>
			variables.#lower#Gateway = createObject(&quot;component&quot;, &quot;#lower_listener#.models.dao.GatewayFactory&quot;).init(dsn).getGatewayFactory(dbType).get#upper#Gateway();</cfloop>
		&lt;/cfscript&gt;
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;
</pre>
</cfoutput>

<cfsetting showdebugoutput="no">
<cfsetting enablecfoutputonly="no">