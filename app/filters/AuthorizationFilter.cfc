<!---
Author: Ben Edwards (ben@ben-edwards.com)

SessionFilter
	This event-filter tests an event for required permissions specified.
	If the required permissions are not possessed by the user then event
	processing is aborted and a specified event is announced.
	
Configuration Parameters:
	["requiredPrivileges"] - default comma delimited list of permission keys required to process the event
	["invalidEvent"] - default event to announce if all required permissions are not possessed by the user
	["invalidMessage"] - default message to provide if the all required permissions are not possessed by the user 
	["clearEventQueue"] - whether or not to clear the event queue if the permissions are invalid (defaults to true)
	
Event-Handler Parameters:
	"requiredPrivileges" - a comma delimited list of permission keys required to process the event
	"invalidEvent" - the event to announce if all required permissions are not possessed by the user
	["invalidMessage"] - the message to provide if the all required permissions are not possessed by the user 
	["clearEventQueue"] - whether or not to clear the event queue if the permissions are invalid (defaults to true)
--->
<cfcomponent 
	displayname="AuthorizationFilter" 
	extends="MachII.framework.EventFilter"
	output="false"
	hint="A robust EventFilter for testing that a user has the proper permissions to execute and event.">
	
	<!--- PROPERTIES --->
	<cfset this.REQUIRED_PRIVILEGES_PARAM = "requiredPrivileges" />
	<cfset this.INVALID_EVENT_PARAM = "invalidEvent" />
	<cfset this.INVALID_MESSAGE_PARAM = "invalidMessage" />
	<cfset this.CLEAR_EVENT_QUEUE_PARAM = "clearEventQueue" />

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="configure" access="public" returntype="void" output="false">
	</cffunction>
	
	<cffunction name="filterEvent" access="public" returntype="boolean" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var isContinue = true />
		<cfset var requiredPrivileges = '' />
		<cfset var invalidEvent = '' />
		<cfset var invalidMessage = '' />
		<cfset var clearEventQueue = '' />
		<cfset var userPermissions = '' />
		<cfset var newEventArgs = 0 />
				
		<!--- requiredPrivileges --->
		<cfif StructKeyExists(arguments.paramArgs,this.REQUIRED_PRIVILEGES_PARAM)>
			<cfset requiredPrivileges = paramArgs[this.REQUIRED_PRIVILEGES_PARAM] />
		<cfelse>
			<cfset requiredPrivileges = getParameter(this.REQUIRED_PRIVILEGES_PARAM,'') />
		</cfif>
		<!--- invalidEvent --->
		<cfif StructKeyExists(arguments.paramArgs,this.INVALID_EVENT_PARAM)>
			<cfset invalidEvent = paramArgs[this.INVALID_EVENT_PARAM] />
		<cfelse>
			<cfset invalidEvent = getParameter(this.INVALID_EVENT_PARAM,'') />
		</cfif>
		<!--- invalidMessage --->
		<cfif StructKeyExists(arguments.paramArgs,this.INVALID_MESSAGE_PARAM)>
			<cfset invalidMessage = paramArgs[this.INVALID_MESSAGE_PARAM] />
		<cfelse>
			<cfset invalidMessage = getParameter(this.INVALID_MESSAGE_PARAM,'') />
		</cfif>
		<!--- clearEventQueue --->
		<cfif StructKeyExists(arguments.paramArgs,this.CLEAR_EVENT_QUEUE_PARAM)>
			<cfset clearEventQueue = paramArgs[this.CLEAR_EVENT_QUEUE_PARAM] />
		<cfelse>
			<cfset clearEventQueue = getParameter(this.CLEAR_EVENT_QUEUE_PARAM,true) />
		</cfif>
		
		<!--- Ensure required parameters are specified. --->
		<cfif NOT (requiredPrivileges EQ '' OR invalidEvent EQ '')>
			<cfset isContinue = validatePermissions(requiredPrivileges) />
		<cfelse>
			<cfset throwUsageException() />
		</cfif>
		
		<cfif isContinue>
			<!--- If the permissions are acceptable then return true to continue processing the current event. --->
			<cfreturn true />
		<cfelse>
			<!--- Clear the event queue if supposed to. --->
			<cfif clearEventQueue>
				<cfset arguments.eventContext.clearEventQueue() />
			</cfif>
			<!--- Announce the invalidEvent. --->
			<cfset newEventArgs = arguments.event.getArgs() />
			<cfset newEventArgs[this.INVALID_MESSAGE_PARAM] = invalidMessage />
			<cfset arguments.eventContext.announceEvent(invalidEvent, newEventArgs) />
			<!--- Return false to abort the processing of the current event. --->
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="validatePermissions" access="public" returntype="boolean">
		<cfargument name="requiredPrivileges" type="string" required="true" />
		<cfreturn arguments.event.getArg("sessionFacade").isSessionAuthorized(arguments.requiredPrivileges) />
	</cffunction>
	
	<!--- PROTECTED FUNCTIONS --->
	<cffunction name="throwUsageException" access="private" returntype="void" output="false">
		<cfset var throwMsg = "SessionFilter requires the following usage parameters: " & this.REQUIRED_PRIVILEGES_PARAM & ", " & this.INVALID_EVENT_PARAM & "." />
		<cfthrow message="#throwMsg#" />
	</cffunction>
	
</cfcomponent>