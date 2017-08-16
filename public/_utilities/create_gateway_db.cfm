<cfsetting enablecfoutputonly="yes">
<cfparam name="object" />
<cfparam name="fields" />
<cfparam name="database" />

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

<cfoutput>
<pre>
&lt;cfcomponent displayname=&quot;#lower_obj#Gateway_#database#&quot; extends=&quot;#lower_obj#Gateway&quot;&gt;

	&lt;!------------------------------------------------------------------------------------
	// CRUD methods
	-------------------------------------------------------------------------------------&gt;

	&lt;cffunction name=&quot;create&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;#lower_obj#&quot; type=&quot;#lower_obj#&quot; required=&quot;true&quot; /&gt;
		&lt;cfargument name=&quot;date&quot; type=&quot;date&quot; required=&quot;false&quot; default=&quot;##now()##&quot; /&gt;
		&lt;cfargument name=&quot;modifier&quot; type=&quot;string&quot; required=&quot;false&quot; default=&quot;00000000-0000-0000-0000000000000000&quot; /&gt;
		
		&lt;cfquery name=&quot;q_create_#lower_obj#&quot; datasource=&quot;##variables.dsn##&quot;&gt;
			INSERT INTO #lower_obj# (
				#lower_obj#Id,
				<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>
				#v#,
				</cfloop>createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'##trim(#lower_obj#.get#upper_obj#Id())##',
				<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>'##trim(#lower_obj#.get#upper#())##',
				</cfloop>&lt;cfif isDate(arguments.date)&gt;##createOdbcDateTime(arguments.date)##&lt;cfelse&gt;NULL&lt;/cfif&gt;, '##trim(arguments.modifier)##',
				&lt;cfif isDate(arguments.date)&gt;##createOdbcDateTime(arguments.date)##&lt;cfelse&gt;NULL&lt;/cfif&gt;, '##trim(arguments.modifier)##'
			)
		&lt;/cfquery&gt;
	&lt;/cffunction&gt;

	&lt;cffunction name=&quot;read&quot; access=&quot;public&quot; returntype=&quot;#lower_obj#&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;id&quot; type=&quot;string&quot; required=&quot;true&quot; /&gt;

		&lt;!---// Query the #lower_obj# info and load it into a struct, then return it to the caller ---&gt;
		&lt;cfquery name=&quot;q_read_#lower_obj#&quot; datasource=&quot;##variables.dsn##&quot;&gt;
			SELECT *
			FROM #lower_obj#
			WHERE #lower_obj#Id = '##trim(arguments.id)##'
		&lt;/cfquery&gt;
		
		&lt;cfif val(q_read_#lower_obj#.recordCount) gt 0&gt;
			&lt;cfscript&gt;
				#lower_obj#Struct = queryRowToStruct(q_read_#lower_obj#);
				#lower_obj# = createObject(&quot;component&quot;,&quot;#lower_obj#&quot;).init(argumentcollection=#lower_obj#Struct);
				addCacheItem(#lower_obj#.get#upper_obj#Id(), #lower_obj#);
				return #lower_obj#;
			&lt;/cfscript&gt;
		&lt;cfelse&gt;
			&lt;cfthrow type=&quot;#uCase(lower_obj)#.MISSING&quot; message=&quot;The requested #lower_obj# does not exist&quot; detail=&quot;#upper_obj# ID: ##arguments.id##&quot;&gt;
		&lt;/cfif&gt;
	&lt;/cffunction&gt;

	&lt;cffunction name=&quot;update&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;#lower_obj#&quot; type=&quot;#lower_obj#&quot; required=&quot;true&quot; /&gt;
		&lt;cfargument name=&quot;date&quot; type=&quot;date&quot; required=&quot;false&quot; default=&quot;##now()##&quot; /&gt;
		&lt;cfargument name=&quot;modifier&quot; type=&quot;string&quot; required=&quot;false&quot; default=&quot;00000000-0000-0000-0000000000000000&quot; /&gt;

		&lt;cfquery name=&quot;q_update_#lower_obj#&quot; datasource=&quot;##variables.dsn##&quot;&gt;
			UPDATE #lower_obj#
			SET
				<cfloop index="v" list="#variable_names#"><cfset upper = uCase(left(v,1)) & right(v,len(v)-1)><cfset lower = lCase(left(v,1)) & right(v,len(v)-1)>
				#lower# = '##trim(#lower_obj#.get#upper#())##',
				</cfloop>updateDate = &lt;cfif isDate(arguments.date)&gt;##createOdbcDateTime(arguments.date)##&lt;cfelse&gt;NULL&lt;/cfif&gt;,
				updateBy = '##trim(arguments.modifier)##'
			WHERE
				#lower_obj#Id = '##trim(#lower_obj#.get#upper_obj#Id())##'
		&lt;/cfquery&gt;
		&lt;cfset removeCacheItem(arguments.#lower_obj#.get#upper_obj#Id()) /&gt;
	&lt;/cffunction&gt;

	&lt;cffunction name=&quot;delete&quot; access=&quot;public&quot; returntype=&quot;void&quot; output=&quot;false&quot;&gt;
		&lt;cfargument name=&quot;id&quot; type=&quot;string&quot; required=&quot;true&quot; /&gt;

		&lt;cfquery name=&quot;q_delete_#lower_obj#&quot; datasource=&quot;##variables.dsn##&quot;&gt;
			DELETE FROM #lower_obj#
			WHERE #lower_obj#Id = '##trim(arguments.id)##'
		&lt;/cfquery&gt;
		&lt;cfset removeCacheItem(arguments.#lower_obj#.get#upper_obj#Id()) /&gt;
	&lt;/cffunction&gt;

	&lt;!------------------------------------------------------------------------------------
	// Non-CRUD methods
	-------------------------------------------------------------------------------------&gt;



&lt;/cfcomponent&gt;
</pre>
</cfoutput>

<cfsetting showdebugoutput="no">
<cfsetting enablecfoutputonly="no">