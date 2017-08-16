<cfcomponent displayname="GatewayFactory for Microsoft SQL Server" extends="GatewayFactory">

	<cffunction name="getApplicationGateway" access="public" returntype="calendar.models.application.applicationGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.application.applicationGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>
	
	<cffunction name="getCalendarGateway" access="public" returntype="calendar.models.calendar.calendarGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.calendar.calendarGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getCategoryGateway" access="public" returntype="calendar.models.category.categoryGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.category.categoryGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getEventGateway" access="public" returntype="calendar.models.event.eventGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.event.eventGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getEventSeriesGateway" access="public" returntype="calendar.models.eventSeries.eventSeriesGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.eventSeries.eventSeriesGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getGroupGateway" access="public" returntype="calendar.models.group.groupGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.group.groupGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getHolidayGateway" access="public" returntype="calendar.models.holiday.holidayGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.holiday.holidayGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getMailServerGateway" access="public" returntype="calendar.models.mailserver.mailserverGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.mailserver.mailserverGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getMessageGateway" access="public" returntype="calendar.models.message.messageGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.message.messageGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>
	
	<cffunction name="getReminderGateway" access="public" returntype="calendar.models.reminder.reminderGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.reminder.reminderGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getSchemeGateway" access="public" returntype="calendar.models.scheme.schemeGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.scheme.schemeGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getSearchGateway" access="public" returntype="calendar.models.search.searchGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.search.searchGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getSearchIndexGateway" access="public" returntype="calendar.models.searchindex.searchindexGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.searchindex.searchindexGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>

	<cffunction name="getUserGateway" access="public" returntype="calendar.models.user.userGateway" output="false">
		<cfset var gateway = "" />
		<cfset gateway = createObject("component","calendar.models.user.userGateway_msaccess").init(variables.dsn,this) />
		<cfreturn gateway />
	</cffunction>
	
</cfcomponent>