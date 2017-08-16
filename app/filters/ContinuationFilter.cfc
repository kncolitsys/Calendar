<!---
	$Id: ContinuationFilter.cfc,v 1.1 2004/03/16 08:32:59 seancorfield Exp $
	
	I am an event filter that announces a continuation event.
	Example:
		An application protects an event with a login gate.
		When login is required, the event handler announces loginPage but
		needs a way to get back to that event handler after successful
		login. It sets continuationEvent in the event object and after a
		successful login, this filter is called to announce that event.
	Usage:
		<event-filter name="continue" type="openxcf.machii.filters.ContinuationFilter" />
		
		<event-handler event="doSomething" access="public">
			<event-arg name="continuationEvent" value="doSomethingElse" />
			<announce event="intermediate" />
		</event-handler>
		
		<event-handler event="intermediate" access="private">
			<filter name="continue" />
		</event-handler>
		
		<event-handler event="doSomethingElse" access="private">
			<!-- continuation filter gets us here -->
		</event-handler>
	Parameters:
		copyEventArgs				optional	should the filter copy the current event args
									default		true
		clearEventQueue				optional	should the filter clear the event queue
									default		false
		abortEvent					optional	should the filter abort the current event
									default		true
		continuationEventArgName	optional	name of event argument containing continuation event name
									default		continuationEvent
	Event arguments:
		continuationEvent**			optional	event to announce
									default		do not announce an event
		** the actual name of the argument is determined by continuationEventArgName
--->
<cfcomponent extends="MachII.framework.EventFilter" output="no" displayname="Continuation Event Filter"
		hint="I am an event filter that supports event chaining using continuation events.">
	<cffunction name="configure" access="public" returntype="void" output="false" displayname="Mach II Constructor"
			hint="I perform configuration for this event filter.">
	</cffunction>
	<cffunction name="filterEvent" access="public" returntype="boolean" output="false" displayname="Filter Event Implementation"
			hint="I implement the continuation filter logic by announcing the continuationEvent if present.">
		<cfargument name="event" type="MachII.framework.Event" required="yes" displayname="The Current Event"
				hint="I am the current event object and may contain a continuationEvent argument." />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="yes" displayname="The Current Event Context"
				hint="I am the current event context object." />
		<cfargument name="paramArgs" type="struct" default="#structNew()#" displayname="Invocation Parameters"
				hint="I contain any optional parameter values specified at invocation." />
		<!--- set up parameter values and defaults --->
		<cfset var copyEventArgs			= getParameter("copyEventArgs",true) />
		<cfset var clearEventQueue			= getParameter("clearEventQueue",false) />
		<cfset var abortEvent				= getParameter("abortEvent",true) />
		<cfset var continuationEventArgName	= getParameter("continuationEventArgName","continuationEvent") />
		<cfset var continuationEvent		= "" />
		<cfset var continuationArgs			= 0 />
		<!--- override with invocation parameters if present --->
		<cfif structKeyExists(arguments.paramArgs,"copyEventArgs")>
			<cfset copyEventArgs = arguments.paramArgs.copyEventArgs />
		</cfif>
		<cfif structKeyExists(arguments.paramArgs,"clearEventQueue")>
			<cfset clearEventQueue = arguments.paramArgs.clearEventQueue />
		</cfif>
		<cfif structKeyExists(arguments.paramArgs,"abortEvent")>
			<cfset abortEvent = arguments.paramArgs.abortEvent />
		</cfif>
		<cfif structKeyExists(arguments.paramArgs,"continuationEventArgName")>
			<cfset continuationEventArgName = arguments.paramArgs.continuationEventArgName />
		</cfif>
		<!--- process continuation --->
		<cfif arguments.event.isArgDefined(continuationEventArgName)>
			<cfset continuationEvent = arguments.event.getArg(continuationEventArgName) />
			<cfset arguments.event.removeArg(continuationEventArgName) />
			<cfif copyEventArgs>
				<cfset continuationArgs = arguments.event.getArgs() />
			<cfelse>
				<cfset continuationArgs = structNew() />
			</cfif>
			<cfif clearEventQueue>
				<cfset arguments.eventContext.clearEventQueue() />
			</cfif>
			<cfset arguments.eventContext.announceEvent(continuationEvent,continuationArgs) />
			<cfreturn not abortEvent />
		</cfif>
		<cfreturn true />
	</cffunction>
</cfcomponent>
