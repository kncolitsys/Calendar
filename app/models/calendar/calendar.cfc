<cfcomponent displayname="calendar">

	<cfset variables.instance.calendarId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.status = "pending" />
	<cfset variables.instance.description = "" />
	<cfset variables.instance.header = "" />
	<cfset variables.instance.footer = "" />
	<cfset variables.instance.exitUrl = "" />
	<cfset variables.instance.scheme = createobject('component','calendar.models.scheme.scheme').init() />
	<cfset variables.instance.privileges = structNew() />
	<cfset variables.instance.options = initOptions() />
	
	<cffunction name="init">
		<cfargument name="calendarId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="pending" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="header" type="string" required="false" default="" />
		<cfargument name="footer" type="string" required="false" default="" />
		<cfargument name="exitUrl" type="string" required="false" default="" />
		<cfargument name="scheme" type="calendar.models.scheme.scheme" required="false" default="#createobject('component','calendar.models.scheme.scheme').init()#" />
		<cfargument name="privileges" type="struct" required="false" default="#structNew()#" />
		<cfargument name="options" type="struct" required="false" default="#initOptions()#" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" returntype="void" access="public" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setCalendarId(arguments.info.calendarId);
			setTitle(arguments.info.title);
			setStatus(arguments.info.status);
			setDescription(arguments.info.description);
			setHeader(arguments.info.header);
			setFooter(arguments.info.footer);
			setExitUrl(arguments.info.exitUrl);
			setScheme(arguments.info.scheme);
			setPrivileges(arguments.info.privileges);
			setOptions(arguments.info.options);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setCalendarId" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfset variables.instance.calendarId = arguments.calendarId />
	</cffunction>
	<cffunction name="getCalendarId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.calendarId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setStatus" access="public" returntype="void" output="false">
		<cfargument name="status" type="string" required="true" />
		<cfset variables.instance.status = arguments.status />
	</cffunction>
	<cffunction name="getStatus" access="public" returntype="string" output="false">
		<cfreturn variables.instance.status />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="description" type="string" required="true" />
		<cfset variables.instance.description = arguments.description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.description />
	</cffunction>
	
	<cffunction name="setHeader" access="public" returntype="void" output="false">
		<cfargument name="header" type="string" required="true" />
		<cfset variables.instance.header = arguments.header />
	</cffunction>
	<cffunction name="getHeader" access="public" returntype="string" output="false">
		<cfreturn variables.instance.header />
	</cffunction>
	
	<cffunction name="setFooter" access="public" returntype="void" output="false">
		<cfargument name="footer" type="string" required="true" />
		<cfset variables.instance.footer = arguments.footer />
	</cffunction>
	<cffunction name="getFooter" access="public" returntype="string" output="false">
		<cfreturn variables.instance.footer />
	</cffunction>
	
	<cffunction name="setExitUrl" access="public" returntype="void" output="false">
		<cfargument name="exitUrl" type="string" required="true" />
		<cfset variables.instance.exitUrl = arguments.exitUrl />
	</cffunction>
	<cffunction name="getExitUrl" access="public" returntype="string" output="false">
		<cfreturn variables.instance.exitUrl />
	</cffunction>

	<cffunction name="setScheme" access="public" returntype="void" output="false">
		<cfargument name="scheme" type="calendar.models.scheme.scheme" required="true" />
		<cfset variables.instance.scheme = arguments.scheme />
	</cffunction>
	<cffunction name="getScheme" access="public" returntype="calendar.models.scheme.scheme" output="false">
		<cfreturn variables.instance.scheme />
	</cffunction>

	<cffunction name="setPrivileges" access="public" returntype="void" output="false">
		<cfargument name="privileges" type="struct" required="true" />
		<cfset variables.instance.privileges = arguments.privileges />
	</cffunction>
	<cffunction name="getPrivileges" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.privileges />
	</cffunction>

	<cffunction name="setOptions" access="public" returntype="void" output="false">
		<cfargument name="options" type="struct" required="true" />
		<cfset variables.instance.options = arguments.options />
	</cffunction>
	<cffunction name="getOptions" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.options />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getCalendarTO" access="public" returntype="calendarTO" output="false">
		<cfreturn createCalendarTO() />
	</cffunction>
			
	<cffunction name="setCalendarFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="calendarTO" type="calendarTO" required="true" />		
		<cfscript>
			setCalendarId(arguments.calendarTO.calendarId);
			setTitle(arguments.calendarTO.title);
			setStatus(arguments.calendarTO.status);
			setDescription(arguments.calendarTO.description);
			setHeader(arguments.calendarTO.header);
			setFooter(arguments.calendarTO.footer);
			setExitUrl(arguments.calendarTO.exitUrl);
			setScheme(arguments.calendarTO.scheme);
			setPrivileges(arguments.calendarTO.privileges);
			setOptions(arguments.calendarTO.options);
		</cfscript>
	</cffunction>
	
	<cffunction name="createCalendarTO" access="package" returntype="calendarTO" output="false">
		<cfscript>
			var calendarTO = createObject("component", "calendarTO").init(argumentcollection=variables.instance);
			return calendarTO;
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// General Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="initOptions" access="private" returntype="struct" output="false">
		<cfscript>
			options = structNew();
			options['weekStart'] = 1;
			options['weekEnd'] = 7;
			options['displayWorkHours'] = 0;
			options['searchEnabled'] = 1;
			options['defaultGroup'] = '';
			options['calendarExportEnabled'] = 1;
			options['userApprovalRequired'] = 0;
			options['publicId'] = createUuid();
			options['publicUsername'] = 'public' & options['publicId'];
			options['publicPassword'] = 'password' & options['publicId'];
			options['publicPermissions'] = 'VIEW,SEARCH,RECEIVE_EMAIL,ATTACH_DOCUMENTS';
			return options;
		</cfscript>
	</cffunction>
	
</cfcomponent>