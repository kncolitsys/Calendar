<!---
	RedirectFilter.cfc
	
	I am an event-filter that performs a redirect/cflocation within an event handler.
	(based on the CFLocationFilter posted by mike123 on the Mach-II forums)
	
	Define me as a filter like this:
	
	<event-filters>
		...
		<event-filter name="redirect" type="core.filters.RedirectFilter" />			
		...
	</event-filters>

	Use me to redirect in an event handler like this:
	
	<event-handlers>
		...
		<event-handler event="foo">
			<filter name="redirect" >     
				<parameter name="announceEvent" value="someEvent" />
				<parameter name="argsToCopy" value="anUrlParam" />
			</filter>  			
			...
		</event-handler>
		...				
	</event-handlers>
	
	announceEvent is required.
	It is the event to redirect to.
	argsToCopy is optional.  
	It is a list of event args to append as url parameter in the redirect. As url parameters
	can only be simple values only event args that are simple values will be passed.
	absoluteUrl is optional.
	This is a url that is outside of the mach-ii application, i.e if you want to redirect to http://www.google.com
--->
<cfcomponent extends="MachII.framework.EventFilter">

	<cffunction name="configure" returntype="void" access="public" output="false">
		<!--- perform any initialization --->
	</cffunction>
	
	<cffunction name="filterEvent" returntype="boolean" access="public" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="yes" />
		<cfargument name="paramArgs" type="struct" required="yes" />	
		
		<cfset var curArgs = arguments.eventContext.getCurrentEvent().getArgs() />
		<cfset var evtArgsToCopy = ""/>
		<cfset var qryString = ""/>
		<cfset var urlString = "" />
		<cfset var evtArg = "" />
		
		<cfif StructKeyExists(arguments.paramArgs,"absoluteUrl")>
			<cfset urlString  = arguments.paramArgs["absoluteUrl"] >
		<cfelse>
			<cfif StructKeyExists(arguments.paramArgs,"argsToCopy")>
				<cfset evtArgsToCopy = arguments.paramArgs["argsToCopy"]>
			</cfif>
			<cfloop list="#evtArgsToCopy#" index="evtArg">
				<cfif StructKeyExists(curArgs,evtArg)>
					<cfif IsSimpleValue(StructFind(curArgs,evtArg))>
						<cfset qryString = qryString & "&" & evtArg & "=" & URLENCODEDFORMAT(StructFind(curArgs,evtArg)) />
					</cfif>
				</cfif>
			</cfloop>
			<cfset urlString =  "index.cfm?cfevent=" & arguments.paramArgs['announceEvent'] />			
		</cfif>
		<cflocation url="#urlString##qryString#" addtoken="no">					
		<cfreturn false />	
	</cffunction>
</cfcomponent>
