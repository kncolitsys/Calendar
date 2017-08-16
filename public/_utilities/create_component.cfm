<cfsetting enablecfoutputonly="yes">
<cfparam name="object" />
<cfparam name="fields" />

<cfset upper_obj = uCase(left(object,1)) & right(object,len(object)-1)>
<cfif compareNoCase(right(upper_obj,1),"y") eq 0>
	<cfset upper_pl = left(upper_obj,len(upper_obj)-1) & "ies">
<cfelse>
	<cfset upper_pl = upper_obj & "s">
</cfif>
<cfset lower_obj = lCase(left(object,1)) & right(object,len(object)-1)><br>
<cfif compareNoCase(right(lower_obj,1),"y") eq 0>
	<cfset lower_pl = left(lower_obj,len(lower_obj)-1) & "ies">
<cfelse>
	<cfset lower_pl = lower_obj & "s">
</cfif>
<cfset variable_names = url.fields>

<cfoutput><pre>&lt;cfcomponent displayname=&quot;#lower_obj#&quot;&gt;

	&lt;cfset variables.instance.#lower_obj#Id = createUuid() /&gt;
	<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>&lt;cfset variables.instance.#v# = &quot;&quot; /&gt;
	</cfloop>
	&lt;cffunction name=&quot;init&quot; access=&quot;public&quot; returntype=&quot;#lower_obj#&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;#lower_obj#Id&quot; type=&quot;string&quot; required=&quot;false&quot; default=&quot;##createUuid()##&quot; /&gt;
		<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>&lt;cfargument name=&quot;#v#&quot; type=&quot;string&quot; required=&quot;false&quot; default=&quot;&quot; /&gt;
		</cfloop>
		&lt;cfinvoke component=&quot;##this##&quot; method=&quot;setInfo&quot; info=&quot;##arguments##&quot; /&gt;
		&lt;cfreturn this /&gt;
	&lt;/cffunction&gt;
	
	&lt;cffunction name=&quot;setInfo&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;info&quot; type=&quot;struct&quot; required=&quot;true&quot; /&gt;
		
		&lt;cfscript&gt;
			set#upper_obj#Id(arguments.info.#lower_obj#Id);<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>
			set#upper#(arguments.info.#v#);</cfloop>
		&lt;/cfscript&gt;
	&lt;/cffunction&gt;

	&lt;!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	-------------------------------------------------------------------------------------&gt;

	&lt;cffunction name=&quot;set#upper_obj#Id&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;#lower_obj#Id&quot; type=&quot;string&quot; required=&quot;true&quot; /&gt;
		&lt;cfset variables.instance.#lower_obj#Id = arguments.#lower_obj#Id /&gt;
	&lt;/cffunction&gt;
	&lt;cffunction name=&quot;get#upper_obj#Id&quot; access=&quot;public&quot; returntype=&quot;string&quot; output=&quot;false&quot;&gt;
		&lt;cfreturn variables.instance.#lower_obj#Id /&gt;
	&lt;/cffunction&gt;
	<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>
	&lt;cffunction name=&quot;set#upper#&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;#v#&quot; type=&quot;string&quot; required=&quot;true&quot; /&gt;
		&lt;cfset variables.instance.#v# = arguments.#v# /&gt;
	&lt;/cffunction&gt;
	&lt;cffunction name=&quot;get#upper#&quot; access=&quot;public&quot; returntype=&quot;string&quot; output=&quot;false&quot;&gt;
		&lt;cfreturn variables.instance.#v# /&gt;
	&lt;/cffunction&gt;
	</cfloop>
	
	&lt;!------------------------------------------------------------------------------------
	// Transfer Object methods
	-------------------------------------------------------------------------------------&gt;
	
	&lt;cffunction name=&quot;get#upper_obj#TO&quot; access=&quot;public&quot; returntype=&quot;#lower_obj#TO&quot; output=&quot;false&quot;&gt;
		&lt;cfreturn create#upper_obj#TO() /&gt;
	&lt;/cffunction&gt;
			
	&lt;cffunction name=&quot;set#upper_obj#FromTO&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot; hint=&quot;set the instance data from TO&quot;&gt;
		&lt;cfargument name=&quot;#lower_obj#TO&quot; type=&quot;#lower_obj#TO&quot; required=&quot;true&quot; /&gt;		
		&lt;cfscript&gt;
			set#upper_obj#Id(arguments.#lower_obj#TO.#lower_obj#Id);<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>
			set#upper#(arguments.#lower_obj#TO.#v#);</cfloop>
		&lt;/cfscript&gt;
	&lt;/cffunction&gt;
	
	&lt;cffunction name=&quot;create#upper_obj#TO&quot; access=&quot;package&quot; returntype=&quot;#lower_obj#TO&quot; output=&quot;false&quot;&gt;
		&lt;cfscript&gt;
			var #lower_obj#TO = createObject(&quot;component&quot;, &quot;#lower_obj#TO&quot;).init(argumentcollection=variables.instance);
			return #lower_obj#TO;
		&lt;/cfscript&gt;
	&lt;/cffunction&gt;
	
&lt;/cfcomponent&gt;
</pre>
</cfoutput>

<cfsetting showdebugoutput="no">
<cfsetting enablecfoutputonly="no">