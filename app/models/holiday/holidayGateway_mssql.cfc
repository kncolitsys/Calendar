<cfcomponent displayname="holidayGateway_mssql" extends="holidayGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="holiday" type="holiday" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_holiday" datasource="#variables.dsn#">
			INSERT INTO holidays (
				holidayId, title, globalObject,
				recurrenceRule, comments,
				createDate, createBy,
				updateDate,	updateBy
			) VALUES (
				'#trim(holiday.getHolidayId())#', '#trim(replace(holiday.getTitle(),"'","''","ALL"))#', #int(holiday.getGlobal())#,
				'#trim(holiday.getRecurrenceRule())#', '#trim(holiday.getComments())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="holiday" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the holiday info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_holiday" datasource="#variables.dsn#">
			SELECT *
			FROM holidays
			WHERE holidayId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_holiday.recordCount) gt 0>
			<cfscript>
				holidayStruct = queryRowToStruct(q_read_holiday);
				holiday = createObject("component","holiday").init(argumentcollection=holidayStruct,global=(q_read_holiday.globalObject eq true));
				addCacheItem(holiday.getHolidayId(), holiday);
				return holiday;
			</cfscript>
		<cfelse>
			<cfthrow type="HOLIDAY.MISSING" message="The requested holiday does not exist" detail="Holiday ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="holiday" type="holiday" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_holiday" datasource="#variables.dsn#">
			UPDATE holidays
			SET
				title = '#trim(replace(holiday.getTitle(),"'","''","ALL"))#',
				globalObject = #int(holiday.getGlobal())#,
				recurrenceRule = '#trim(holiday.getRecurrenceRule())#',
				comments = '#trim(holiday.getComments())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				holidayId = '#trim(holiday.getHolidayId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.holiday.getHolidayId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_holiday" datasource="#variables.dsn#">
			DELETE FROM holidays
			WHERE holidayId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="getHolidays" access="public" returntype="query" output="false">
		<cfargument name="global" type="boolean" required="false" default="false" />
		<cfquery name="q_holidays" datasource="#variables.dsn#">
			SELECT *
			FROM holidays
			WHERE globalObject = #int(arguments.global)#
			ORDER BY title
		</cfquery>
		<cfreturn q_holidays />
	</cffunction>

</cfcomponent>