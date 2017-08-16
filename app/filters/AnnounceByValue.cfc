<!--- 
	AnnounceByValue.cfc (12/05/2003)
	by Rob Schimp (rtschimp@gmail.com)
	
	Description:
		This filter will announce a new event, based on a variable value. Basically acts like a switch for events.

	Parameters:
		VariableNameForAnnounce: The variable name to use to announce the event.
		CopyEventArgs: Whether or not we should copy the event args to the new event. (Default 1).
		ContinueProcessingEvent: Whether or not we should continue processing the current event. (Default 0).
		<eventName>: the event to announce. The value is the value of the variable.
		
	Example:
		<filter name="AnnounceByValue">
			<parameter name="VariableNameForAnnounce" value="status" />
			<parameter name="showSuccess" value="1" />
			<parameter name="showFailure" value="0" />
		</filter>
	
	NOTE:
		All parameters can be either config params or event-handler params.
		However, event-handler params will "supercede" the config params.
--->

<cfcomponent extends="MachII.framework.EventFilter" display="EventToRequest filter"
	hint="I am an event filter that takes a list of request variables and creates corresponding event arguments for each one.">

	<cffunction name="configure" access="public" returntype="void" output="false" 
		displayname="Filter 'Constructor'" hint="I initialize this filter as part of the framework startup.">
	</cffunction>
	
	<cffunction name="filterEvent" access="public" returntype="boolean" 
		displayname="Filter Event" hint="I am invoked by the Mach II framework." output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true"
			displayname="event object" hint="I am the current event object created by the Mach II framework." />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true"
			displayname="eventContext object" hint="I am the current event context object created by the Mach II framework." />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#"
			displayname="paramArgs structure" hint="I am the structure containing the parameters specified in the filter invocation in mach-ii.xml." />

		<cfscript>
			var paramArgsCopy = Duplicate(arguments.paramArgs);
			var configArgsCopy = Duplicate(getParameters());
			var variableName = "";
			var continueEvent = 0;
			var valueToCheck = 0;
			var copyEventArgs = 1;
			var eventStruct = StructNew();
			var currentVariableName = "";
			var newEventArgs = StructNew();

			//get whether or not we should continue processing
			if ( structKeyExists( arguments.paramArgs, "ContinueProcessingEvent" ) ) {
				continueEvent = arguments.paramArgs.ContinueProcessingEvent;
			} else if ( isParameterDefined('ContinueProcessingEvent') ){
				continueEvent = getParameter( "ContinueProcessingEvent" );
			}

			//get our variable to check
			if ( structKeyExists( arguments.paramArgs, "VariableNameForAnnounce" ) ) {
				variableName = arguments.paramArgs.VariableNameForAnnounce;
			} else if ( isParameterDefined('VariableNameForAnnounce') ){
				variableName = getParameter( "VariableNameForAnnounce" );
			}
			
			//get our value to check
			valueToCheck = arguments.event.getArg(variableName);

			//check to see if we have a copyEventArgs passed in.
			if ( structKeyExists( arguments.paramArgs, "CopyEventArgs" ) ) {
				copyEventArgs = arguments.paramArgs.CopyEventArgs;
			} else if ( isParameterDefined('CopyEventArgs') ){
				copyEventArgs = getParameter( "CopyEventArgs" );
			}
			
			//set up the new event args if we should
			if (copyEventArgs)
				newEventArgs = Duplicate(arguments.event.getArgs());
			
			//empty out everything we don't need.
			StructDelete(paramArgsCopy, "CopyEventArgs");
			StructDelete(configArgsCopy, "CopyEventArgs");
			StructDelete(paramArgsCopy, "VariableNameForAnnounce");
			StructDelete(configArgsCopy, "VariableNameForAnnounce");
			
			//append the structs together, so we have all our events for the "switch"
			//event-handler events will override any config events with the same name.
			StructAppend(configArgsCopy, paramArgsCopy, "YES");
			
			//now reverse the events, so that the value is now the key
			eventStruct = StructInvert(configArgsCopy);
		</cfscript>
		
		<cfif StructKeyExists(eventStruct, valueToCheck)>
			<cfscript>
				arguments.eventContext.announceEvent(eventStruct[valueToCheck], newEventArgs);
				return continueEvent;
			</cfscript>
		<cfelse>
			<cfthrow message="The value passed was not found in the events." type="ANNOUNCEBYVALUE" detail="The value passed was not found in the list of events passed to AnnounceByValue.">
		</cfif>
	</cffunction>

	<cffunction name="StructInvert" access="public" returntype="struct" 
		displayname="Struct Invert" hint="This inverts a struct, so that the keys are now the values, and the values are keys. All values must be simple." output="no">
		<cfargument name="OldStruct" type="struct" required="yes">
		<cfscript>
			/**
			 * Takes a struct of simple values and returns the structure with the values and keys inverted.
			 * 
			 * @param st 	 Structure of simple name/value pairs you want inverted. 
			 * @return Returns a structure. 
			 * @author Craig Fisher (craig@altainteractive.com) 
			 * @version 1, November 13, 2001 
			 * 
			 * Tweaked by Rob Schimp; changed error handling.
			 */
			var returnVal = StructNew();
			var lKeys = "";
			var nkey = "";
			var i = 1;
			var error = 0;

			if (NOT IsStruct(OldStruct)) {
				error = 1;
			} else {
				lKeys = StructKeyList(OldStruct);
				
				for (i = 1; i LTE ListLen(lKeys); i = i + 1) {
					nKey = ListGetAt(lkeys, i);
					if (IsSimpleValue(OldStruct[nKey]))
						returnVal[OldStruct[nKey]] = nKey;
					else {
						error = 1;
						break;
					}
				}
			}
		</cfscript>
		<cfif error>
			<cfthrow message="There was a problem with struct invert. Please check usage." type="STRUCTINVERT" />
		<cfelse>
			<cfreturn returnVal />
		</cfif>
	</cffunction>
	
</cfcomponent>

