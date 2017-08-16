<cfcomponent displayname="categoryGateway_msaccess" extends="categoryGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="category" type="category" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_category" datasource="#variables.dsn#">
			INSERT INTO categories (
				categoryId, title,
				description, bgColor,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(category.getCategoryId())#', '#trim(category.getTitle())#',
				'#trim(category.getDescription())#', '#trim(category.getBgColor())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="category" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the category info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_category" datasource="#variables.dsn#">
			SELECT *
			FROM categories
			WHERE categoryId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_category.recordCount) gt 0>
			<cfscript>
				categoryStruct = queryRowToStruct(q_read_category);
				category = createObject("component","category").init(argumentcollection=categoryStruct);
				addCacheItem(category.getCategoryId(), category);
				return category;
			</cfscript>
		<cfelse>
			<cfthrow type="CATEGORY.MISSING" message="The requested category does not exist" detail="Category ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="category" type="category" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_category" datasource="#variables.dsn#">
			UPDATE categories
			SET
				title = '#trim(category.getTitle())#',
				description = '#trim(category.getDescription())#',
				bgColor = '#trim(category.getBgColor())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				categoryId = '#trim(category.getCategoryId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.category.getCategoryId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_category" datasource="#variables.dsn#">
			DELETE FROM categories
			WHERE categoryId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="getCategories" access="public" returntype="query">
		<cfquery name="q_categories" datasource="#variables.dsn#">
			SELECT *
			FROM categories
		</cfquery>
		<cfreturn q_categories />
	</cffunction>

</cfcomponent>