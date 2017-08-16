<cfcomponent displayname="ApplicationPlugin" extends="MachII.framework.Plugin" hint="I do initialization tasks.">
		
	<cffunction name="configure" access="public" returntype="void" output="false">								
		<cfscript>		
			var pm = getAppManager().getPropertyManager();

			// get some constants from the xml file			
			var dbDsn = pm.getProperty("dbDsn");
			var dbType = pm.getProperty("dbType");
			var tzLib = pm.getProperty("timezoneLib");
			var valLib = pm.getProperty("validationLib");
			
			request.executionStart = getTickCount();

			// create a bean of application constants and store it in properties
		 	variables.appConstants = createObject("component", "calendar.models.ApplicationConstantsBean").init(dbDsn,dbtype);
			pm.setProperty("appConstants", variables.appConstants);
	
			// create a user facade and store it in properties
			variables.sessionFacade = createObject("component","calendar.models.SessionFacade");
			pm.setProperty("sessionFacade", variables.sessionFacade);
			
			// create the timezone library
			variables.timezoneLibrary = createObject("component",tzLib).init();
			pm.setProperty("timezoneLibrary", variables.timezoneLibrary);
			
			// create the timezone library
			variables.validationLibrary = createObject("component",valLib).init();
			pm.setProperty("validationLibrary", variables.validationLibrary);
		</cfscript>
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;ApplicationPlugin.preProcess()<br /></cfoutput>
		<cfparam name="request.executionStart" default="#getTickCount()#" />
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfscript>
			var event = arguments.eventContext.getCurrentEvent();
			
			// insert the application constants in each event
			event.setArg("appConstants",variables.appConstants);
		</cfscript>
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;ApplicationPlugin.postEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;ApplicationPlugin.preView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;ApplicationPlugin.postView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfif not URL.cleanHtml>
			<cfset request.executionEnd = getTickCount() />
			<cfoutput><div style="text-align:right;font-size:10px;color:##999999;">#evaluate(request.executionEnd-request.executionStart)# ms</div></cfoutput>
		</cfif>
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
		<cfoutput>&nbsp;InitializationPlugin.handleException()<br /></cfoutput>
		<cfoutput>#arguments.exception.getMessage()#</cfoutput>
	</cffunction>

</cfcomponent>
