<cfcomponent displayname="AuthenticationPlugin" extends="MachII.framework.Plugin" hint="I do initialization tasks.">

	<cfset this.INVALID_EVENT_PARAM = "invalidEvent" />
	<cfset this.INVALID_MESSAGE_PARAM = "invalidMessage" />
	<cfset this.CLEAR_EVENT_QUEUE_PARAM = "clearEventQueue" />
	
	<cffunction name="configure" access="public" returntype="void" output="false">
		<cfscript>
			var pm = getAppManager().getPropertyManager();
			variables.sessionFacade = pm.getProperty("sessionFacade");
		</cfscript>
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfscript>
//			var sf = variables.sessionFacade;
//			if(not sf.hasAccount()) {
//				if(not (isDefined("cfevent") and compareNoCase(cfevent,"calendar.signin.submitted") eq 0)) {
//					arguments.eventContext.clearEventQueue();
//					arguments.eventContext.announceEvent("calendar.signin");
//				}
//			}
		</cfscript>
		<cfoutput>&nbsp;AuthenticationPlugin.preProcess()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfscript>
			// set the session user transfer object in the event using the facade
			var event = arguments.eventContext.getCurrentEvent();
			event.setArg("sessionFacade", variables.sessionFacade);
			
			// if a cookie exists, automatically login the user using the cookie data
			if(variables.sessionFacade.hasUser() eq false and isDefined("cookie.userlogin") and isDefined("cookie.useruuid")) {
				if(len(cookie.userlogin) gt 0 and len(cookie.useruuid) gt 0) {
					appConstants = getAppManager().getPropertyManager().getProperty("appConstants");
					dsn = appConstants.getDbDsn();
					dbType = appConstants.getDbType();
					user = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getUserGateway().getUserByUsername(cookie.userlogin);
					if(user.getUserId() eq cookie.useruuid) {
						variables.sessionFacade.openSession(user, structKeyList(user.getPermissions()));
					}
				}
			}
		</cfscript>
		<!---<cfoutput>&nbsp;AuthenticationPlugin.preEvent()<br /></cfoutput>--->
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;AuthenticationPlugin.postEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;AuthenticationPlugin.preView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;AuthenticationPlugin.postView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;AuthenticationPlugin.postProcess()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
		<cfoutput>&nbsp;InitializationPlugin.handleException()<br /></cfoutput>
		<cfoutput>#arguments.exception.getMessage()#</cfoutput>
	</cffunction>

</cfcomponent>
