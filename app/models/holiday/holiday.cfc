<cfcomponent displayname="holiday">

	<cfset variables.instance.holidayId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.global = false />
	<cfset variables.instance.recurrenceRule = "" />
	<cfset variables.instance.comments = "" />
	
	<cffunction name="init" access="public" returntype="holiday" output="false">
		<cfargument name="holidayId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="global" type="boolean" required="false" default="false" />
		<cfargument name="recurrenceRule" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setHolidayId(arguments.info.holidayId);
			setTitle(arguments.info.title);
			setGlobal(arguments.info.global);
			setRecurrenceRule(arguments.info.recurrenceRule);
			setComments(arguments.info.comments);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setHolidayId" access="public" returntype="void" output="false">
		<cfargument name="holidayId" type="string" required="true" />
		<cfset variables.instance.holidayId = arguments.holidayId />
	</cffunction>
	<cffunction name="getHolidayId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.holidayId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setGlobal" access="public" returntype="void" output="false">
		<cfargument name="global" type="boolean" required="true" />
		<cfset variables.instance.global = arguments.global />
	</cffunction>
	<cffunction name="getGlobal" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.global />
	</cffunction>
	
	<cffunction name="setRecurrenceRule" access="public" returntype="void" output="false">
		<cfargument name="recurrenceRule" type="string" required="true" />
		<cfset variables.instance.recurrenceRule = arguments.recurrenceRule />
	</cffunction>
	<cffunction name="getRecurrenceRule" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recurrenceRule />
	</cffunction>
	
	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="comments" type="string" required="true" />
		<cfset variables.instance.comments = arguments.comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.comments />
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getHolidayTO" access="public" returntype="holidayTO" output="false">
		<cfreturn createHolidayTO() />
	</cffunction>
			
	<cffunction name="setHolidayFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="holidayTO" type="holidayTO" required="true" />		
		<cfscript>
			setHolidayId(arguments.holidayTO.holidayId);
			setTitle(arguments.holidayTO.title);
			setGlobal(arguments.holidayTO.global);
			setRecurrenceRule(arguments.holidayTO.recurrenceRule);
			setComments(arguments.holidayTO.comments);
		</cfscript>
	</cffunction>
	
	<cffunction name="createHolidayTO" access="package" returntype="holidayTO" output="false">
		<cfscript>
			var holidayTO = createObject("component", "holidayTO").init(argumentcollection=variables.instance);
			return holidayTO;
		</cfscript>
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// General Object methods
	------------------------------------------------------------------------------------->
	<cffunction name="getInstanceByYear" returntype="date" output="true">
		<cfargument name="year" type="numeric" required="true" />

		<!---// Pre-process the recurrence information. --->
		<cfset year = arguments.year />
		<cfset rule = getRecurrenceRule() />
		<cfswitch expression="#lCase(getToken(rule,1,'_'))#">
			<!---
			// Null recurrence... occurs on one (and only one) specific day.
			// (e.g. a birth date, as opposed to the birthday, which has a
			// date recurrence.)
			--->
			<cfcase value="n">
				<cfset year = getToken(rule, 2, "_") />
				<cfset month = getToken(rule, 3, "_") />
				<cfset day = getToken(rule, 4, "_") />		

				<cftry>
					<cfset startDateTime = createDate(year,month,day) />
					<cfcatch type="any">
						<cfset startDateTime = createDate(year(now()),month(now()),day(now())) />
					</cfcatch>
				</cftry>
			</cfcase>
	
			<!---
			// Date recurrence... occurs on a specific day of the year.
			// (e.g. Christmas: December 25th)
			--->
			<cfcase value="d">
				<cfset year = arguments.year />
				<cfset month = getToken(rule, 2, "_") />
				<cfset day = getToken(rule, 3, "_") />		
		
				<cftry>
					<cfset startDateTime = createDate(year,month,day) />
					<cfcatch type="any">
						<cfset startDateTime = createDate(year(now()),month(now()),day(now())) />
					</cfcatch>
				</cftry>
			</cfcase>
			
			<!---
			// Offset recurrence... occurs during a specific week of a month.
			// (e.g. Labor Day: the first Monday of September)
			--->
			<cfcase value="o">
				<cfset offset = getToken(rule, 2, "_") />
				<cfset dow = getToken(rule, 3, "_") />
				<cfset month = getToken(rule, 4, "_") />
				
				<cfif offset eq 5>
					<cftry>
						<!---// Last week of month. --->
						<cfset ldow = dayOfWeek(createDate(year, month, daysInMonth(createDate(year, month, 1)))) />
						<cfset startDateTime = dateAdd("d", (dow-ldow) - 7*iif(dow lte ldow, 0, 1), createDate(year, month, daysInMonth(createDate(year, month, 1)))) />
						<cfcatch type="any">
							<cfset startDateTime = createDate(year(now()),month(now()),day(now())) />
						</cfcatch>
					</cftry>
				<cfelse>
					<!---// First, second, third, or fourth week of month. --->
					<cftry>					
						<cfset fdow = dayOfWeek(createDate(year, month, 1)) />
						<cfset tmp = dateAdd("d", 7*iif(dow lt fdow, 1, 0) + (dow-fdow), createDate(year, month, 1)) />
						<cfset startDateTime = dateAdd("ww", evaluate(offset)-1, tmp) />
						<cfcatch type="any">
							<cfset startDateTime = createDate(year(now()),month(now()),day(now())) />
						</cfcatch>
					</cftry>
				</cfif>
			</cfcase>
	
			<!---
			// Algorithmic recurrence... occurs on a date determined by an algorithm.
			// (e.g. Easter)
			--->
			<cfcase value="a">
				<cfset algorithm = getToken(rule, 2, "_") />
				
				<!---
				// Apparently the only way to execute dynamic CFML code is to dump the
				// CFML code to a file (using CFFILE) and then use CFMODULE to execute
				// the code. The goal was to write the application so users would never
				// *have* to use CFFILE, which is sometimes restricted in shared web-
				// hosting environments. Unfortunately, this limitation of CF leaves no
				// option... if users want this functionality, they need to be able to
				// use CFFILE.
				--->
				<cfset guid = getHolidayId() />
				<cfset filename = left(getCurrentTemplatePath(),len(getCurrentTemplatePath())-len("Holiday.cfc")) & "temp/#guid#.cfm" />
				<cftry>
					<cfif not fileExists(filename)>
						<cffile action="append" file="#filename#" output="<cfscript>year=attributes.year;#algorithm#caller.startDateTime = holidayInstance;</cfscript>" mode="600" nameconflict="overwrite" />
					</cfif>
					<cfif isNumeric(year)>
						<cfmodule template="/calendar/models/holiday/temp/#guid#.cfm" year="#year#" />
					</cfif>
					<cfcatch type="any">
						<cfset startDateTime = createDate(1970,1,1) />
					</cfcatch>
				</cftry>
			</cfcase>
		</cfswitch>

		<cfreturn startDateTime />
	</cffunction>
	
</cfcomponent>