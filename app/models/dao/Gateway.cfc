<cfcomponent displayname="Gateway">
	
	<cfset application.cache = evaluate(iif((isDefined("application.cache") and isStruct(application.cache)),de("application.cache"),de("structNew()"))) />	
	<cfset dbprefix = "" />

	<cffunction name="addCacheItem" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfargument name="object" type="any" required="true" />
		<cfset structInsert(application.cache,arguments.id,arguments.object,true) />
	</cffunction>

	<cffunction name="findCacheItem" access="public" returntype="any" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfif structKeyExists(application.cache,arguments.id) and isObject(application.cache[arguments.id])>
			<cfreturn application.cache[arguments.id] />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="removeCacheItem" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />
		<cfset structDelete(application.cache, arguments.id) />
	</cffunction>
	
	<cffunction name="queryRowToStruct" access="public" returntype="struct" output="false">
		<cfargument name="query" required="true" type="query" />
		<cfargument name="row" required="false" type="numeric" default="1" />
		
		<cfset struct = structNew() />
		<cfloop index="col" list="#arguments.query.columnList#">
			<cfset struct[col] = trim(evaluate("arguments.query." & col & "[" & arguments.row & "]")) />
		</cfloop>
		<cfreturn struct />
	</cffunction>

	<cffunction name="queryToStruct" access="public" returntype="struct" output="false">
		<cfargument name="query" required="true" type="query" />
		<cfargument name="key" required="true" type="string" />
		<cfargument name="columns" required="false" type="string" default="#arguments.query.columnList#" />
		
		<cfset struct = structNew() />
		<cfloop query="arguments.query">
			<cfset row = structNew() />
			<cfloop index="col" list="#arguments.query.columnList#">
				<cfset row[col] = trim(evaluate("arguments.query." & col)) />
			</cfloop>
			<cfset structInsert(struct,trim(evaluate("arguments.query." & arguments.key)),row) />
		</cfloop>
		<cfreturn struct />
	</cffunction>

	<cffunction name="transposeQuery" access="public" returntype="query" output="false">
		<cfargument name="query" required="true" type="query" />

		<cfscript>
			columns = arguments.query.columnList;
			columnNames = "field";
			for(i=1; i lte arguments.query.recordCount; i=i+1) {
				columnNames = listAppend(columnNames, "col" & i);
			}
			newQuery = queryNew(columnNames);		
			queryAddRow(newQuery, listLen(columns));
		</cfscript>
		<cfset i = 1 />
		<cfloop index="column" list="#columns#">
			<cfset querySetCell(newQuery, "field", column, i) />
			<cfset j = 1 />
			<cfloop query="arguments.query">
				<cfset querySetCell(newQuery,"col" & j,arguments.query[column],i) />
				<cfset j = j+1 />
			</cfloop>
			<cfset i = i+1 />
		</cfloop>
		<cfreturn newQuery />
	</cffunction>
	
</cfcomponent>