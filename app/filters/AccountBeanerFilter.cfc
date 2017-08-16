
<!---
	This filter makes sure there is always a Account instance in the event.
--->

<cfcomponent display="AccountBeanerFilter" extends="MachII.framework.EventFilter">
	
	<cffunction name="filterEvent" access="public" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />

		<cfif request.event.isArgDefined('Account')>
			<!--- Do nothing, it's already there. --->
		<cfelseif IsDefined('request.Account')>
			<!--- Take it from the request and put in the event. --->
			<cfset arguments.event.setArg('Account', request.Account) />
		<cfelse>
			<!--- Create it based on parameters in the request. --->
			<cfset Account = CreateObject('component','calendar.models.Account') />
			
			<cfset Account.setFirstName(arguments.event.getArg('firstName','')) />
			<cfset Account.setLastName(arguments.event.getArg('lastName','')) />
			<cfset Account.setStreet(arguments.event.getArg('street','')) />
			<cfset Account.setCity(arguments.event.getArg('city','')) />
			<cfset Account.setState(arguments.event.getArg('state','')) />
			<cfset Account.setZip(arguments.event.getArg('zip','')) />
			
			<cfset arguments.event.setArg('Account', Account) />
		</cfif>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>