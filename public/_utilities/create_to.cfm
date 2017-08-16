<cfsetting enablecfoutputonly="yes">
<cfparam name="object" />
<cfparam name="fields" />

<cfset variable_names = url.fields />

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

<cfoutput><pre>&lt;cfcomponent displayname="#lower#TO" access="public" hint="#upper# Tranfer Object"&gt;

	&lt;cffunction name="init" access="public" returntype="#lower#TO" output="false" displayname="#upper#TO Constructor" hint="Initializes the #upper# Transfer Object"&gt;
		&lt;cfargument name="#lower#Id" type="string" required="false" default="##createUuid()##" /&gt;		<cfloop index="v" list="#variable_names#"><cfset vupper = uCase(left(v,1)) & right(v,len(v)-1)><cfset vlower = lCase(left(v,1)) & right(v,len(v)-1)>
		&lt;cfargument name="#vlower#" type="string" required="false" default="" /&gt;</cfloop>

		&lt;cfscript&gt;
			this.#lower#Id = arguments.#lower#Id;<cfloop index="v" list="#variable_names#"><cfset vupper = uCase(left(v,1)) & right(v,len(v)-1)><cfset vlower = lCase(left(v,1)) & right(v,len(v)-1)>
			this.#vlower# = arguments.#vlower#;</cfloop>
			return this;
		&lt;/cfscript&gt;
	&lt;/cffunction&gt;

&lt;/cfcomponent&gt;</pre>
</cfoutput>

<cfsetting showdebugoutput="no">
<cfsetting enablecfoutputonly="no">