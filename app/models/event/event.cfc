<cfcomponent displayname="event">

	<cfset variables.instance.eventId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.description = "" />
	<cfset variables.instance.category = createObject('component','calendar.models.category.category') />
	<cfset variables.instance.eventUrl = "" />
	<cfset variables.instance.startDateTime = now() />
	<cfset variables.instance.duration = 3600 />
	<cfset variables.instance.location = "" />
	<cfset variables.instance.allDay = false />
	<cfset variables.instance.recurrence = false />
	<cfset variables.instance.recurrenceRule = "" />
	<cfset variables.instance.recurrenceEndDate = now() />
	<cfset variables.instance.seriesId = "" />
	<cfset variables.instance.contactFirstName = "" />
	<cfset variables.instance.contactLastName = "" />
	<cfset variables.instance.contactPhone = "" />
	<cfset variables.instance.contactEmail = "" />
	<cfset variables.instance.comments = "" />
	<cfset variables.instance.approvedDate = now() />
	<cfset variables.instance.approvedBy = "" />
	
	<cffunction name="init" access="public" returntype="event" output="false">
		<cfargument name="eventId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="category" type="calendar.models.category.category" required="false" default="#createObject('component','calendar.models.category.category')#" />
		<cfargument name="eventUrl" type="string" required="false" default="" />
		<cfargument name="startDateTime" type="date" required="false" default="#now()#" />
		<cfargument name="duration" type="numeric" required="false" default="0" />
		<cfargument name="location" type="string" required="false" default="" />
		<cfargument name="allDay" type="boolean" required="false" default="false" />
		<cfargument name="recurrence" type="boolean" required="false" default="false" />
		<cfargument name="recurrenceRule" type="string" required="false" default="" />
		<cfargument name="recurrenceEndDate" type="date" required="false" default="#now()#" />
		<cfargument name="seriesId" type="string" required="false" default="" />
		<cfargument name="contactFirstName" type="string" required="false" default="" />
		<cfargument name="contactLastName" type="string" required="false" default="" />
		<cfargument name="contactPhone" type="string" required="false" default="" />
		<cfargument name="contactEmail" type="string" required="false" default="" />
		<cfargument name="comments" type="string" required="false" default="" />
		<cfargument name="approvedDate" type="date" required="false" default="#now()#" />
		<cfargument name="approvedBy" type="string" required="false" default="" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setEventId(arguments.info.eventId);
			setTitle(arguments.info.title);
			setDescription(arguments.info.description);
			setCategory(arguments.info.category);
			setEventUrl(arguments.info.eventUrl);
			setStartDateTime(arguments.info.startDateTime);
			setDuration(arguments.info.duration);
			setLocation(arguments.info.location);
			setAllDay(arguments.info.allDay);
			setRecurrence(arguments.info.recurrence);
			setRecurrenceRule(arguments.info.recurrenceRule);
			setRecurrenceEndDate(arguments.info.recurrenceEndDate);
			setSeriesId(arguments.info.seriesId);
			setContactFirstName(arguments.info.contactFirstName);
			setContactLastName(arguments.info.contactLastName);
			setContactPhone(arguments.info.contactPhone);
			setContactEmail(arguments.info.contactEmail);
			setComments(arguments.info.comments);
			setApprovedDate(arguments.info.approvedDate);
			setApprovedBy(arguments.info.approvedBy);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setEventId" access="public" returntype="void" output="false">
		<cfargument name="eventId" type="string" required="true" />
		<cfset variables.instance.eventId = arguments.eventId />
	</cffunction>
	<cffunction name="getEventId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.eventId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="description" type="string" required="true" />
		<cfset variables.instance.description = arguments.description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.description />
	</cffunction>
	
	<cffunction name="setCategory" access="public" returntype="void" output="false">
		<cfargument name="category" type="calendar.models.category.category" required="true" />
		<cfset variables.instance.category = arguments.category />
	</cffunction>
	<cffunction name="getCategory" access="public" returntype="calendar.models.category.category" output="false">
		<cfreturn variables.instance.category />
	</cffunction>
	
	<cffunction name="setEventUrl" access="public" returntype="void" output="false">
		<cfargument name="eventUrl" type="string" required="true" />
		<cfset variables.instance.eventUrl = arguments.eventUrl />
	</cffunction>
	<cffunction name="getEventUrl" access="public" returntype="string" output="false">
		<cfreturn variables.instance.eventUrl />
	</cffunction>
	
	<cffunction name="setStartDateTime" access="public" returntype="void" output="false">
		<cfargument name="startDateTime" type="date" required="true" />
		<cfset variables.instance.startDateTime = arguments.startDateTime />
	</cffunction>
	<cffunction name="getStartDateTime" access="public" returntype="date" output="false">
		<cfreturn variables.instance.startDateTime />
	</cffunction>
	
	<cffunction name="setDuration" access="public" returntype="void" output="false">
		<cfargument name="duration" type="numeric" required="true" />
		<cfset variables.instance.duration = arguments.duration />
	</cffunction>
	<cffunction name="getDuration" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.duration />
	</cffunction>
	
	<cffunction name="setLocation" access="public" returntype="void" output="false">
		<cfargument name="location" type="string" required="true" />
		<cfset variables.instance.location = arguments.location />
	</cffunction>
	<cffunction name="getLocation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.location />
	</cffunction>
	
	<cffunction name="setAllDay" access="public" returntype="void" output="false">
		<cfargument name="allDay" type="boolean" required="true" />
		<cfset variables.instance.allDay = arguments.allDay />
	</cffunction>
	<cffunction name="getAllDay" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.allDay />
	</cffunction>
	
	<cffunction name="setRecurrence" access="public" returntype="void" output="false">
		<cfargument name="recurrence" type="boolean" required="true" />
		<cfset variables.instance.recurrence = arguments.recurrence />
	</cffunction>
	<cffunction name="getRecurrence" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.recurrence />
	</cffunction>
	
	<cffunction name="setRecurrenceRule" access="public" returntype="void" output="false">
		<cfargument name="recurrenceRule" type="string" required="true" />
		<cfset variables.instance.recurrenceRule = arguments.recurrenceRule />
	</cffunction>
	<cffunction name="getRecurrenceRule" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recurrenceRule />
	</cffunction>
	
	<cffunction name="setRecurrenceEndDate" access="public" returntype="void" output="false">
		<cfargument name="recurrenceEndDate" type="string" required="true" />
		<cfset variables.instance.recurrenceEndDate = arguments.recurrenceEndDate />
	</cffunction>
	<cffunction name="getRecurrenceEndDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recurrenceEndDate />
	</cffunction>
	
	<cffunction name="setSeriesId" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfset variables.instance.seriesId = arguments.seriesId />
	</cffunction>
	<cffunction name="getSeriesId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.seriesId />
	</cffunction>
	
	<cffunction name="setContactFirstName" access="public" returntype="void" output="false">
		<cfargument name="contactFirstName" type="string" required="true" />
		<cfset variables.instance.contactFirstName = arguments.contactFirstName />
	</cffunction>
	<cffunction name="getContactFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.contactFirstName />
	</cffunction>
	
	<cffunction name="setContactLastName" access="public" returntype="void" output="false">
		<cfargument name="contactLastName" type="string" required="true" />
		<cfset variables.instance.contactLastName = arguments.contactLastName />
	</cffunction>
	<cffunction name="getContactLastName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.contactLastName />
	</cffunction>
	
	<cffunction name="setContactPhone" access="public" returntype="void" output="false">
		<cfargument name="contactPhone" type="string" required="true" />
		<cfset variables.instance.contactPhone = arguments.contactPhone />
	</cffunction>
	<cffunction name="getContactPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.contactPhone />
	</cffunction>
	
	<cffunction name="setContactEmail" access="public" returntype="void" output="false">
		<cfargument name="contactEmail" type="string" required="true" />
		<cfset variables.instance.contactEmail = arguments.contactEmail />
	</cffunction>
	<cffunction name="getContactEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.contactEmail />
	</cffunction>
	
	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="comments" type="string" required="true" />
		<cfset variables.instance.comments = arguments.comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.comments />
	</cffunction>
	
	<cffunction name="setApprovedDate" access="public" returntype="void" output="false">
		<cfargument name="approvedDate" type="date" required="true" />
		<cfset variables.instance.approvedDate = arguments.approvedDate />
	</cffunction>
	<cffunction name="getApprovedDate" access="public" returntype="date" output="false">
		<cfreturn variables.instance.approvedDate />
	</cffunction>
	
	<cffunction name="setApprovedBy" access="public" returntype="void" output="false">
		<cfargument name="approvedBy" type="string" required="true" />
		<cfset variables.instance.approvedBy = arguments.approvedBy />
	</cffunction>
	<cffunction name="getApprovedBy" access="public" returntype="string" output="false">
		<cfreturn variables.instance.approvedBy />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getEventTO" access="public" returntype="eventTO" output="false">
		<cfreturn createEventTO() />
	</cffunction>
			
	<cffunction name="setEventFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="eventTO" type="eventTO" required="true" />		
		<cfscript>
			setEventId(arguments.eventTO.eventId);
			setTitle(arguments.eventTO.title);
			setDescription(arguments.eventTO.description);
			setCategory(arguments.eventTO.category);
			setEventUrl(arguments.eventTO.eventUrl);
			setStartDateTime(arguments.eventTO.startDateTime);
			setDuration(arguments.eventTO.duration);
			setLocation(arguments.eventTO.location);
			setAllDay(arguments.eventTO.allDay);
			setRecurrence(arguments.eventTO.recurrence);
			setRecurrenceRule(arguments.eventTO.recurrenceRule);
			setRecurrenceEndDate(arguments.eventTO.recurrenceEndDate);
			setSeriesId(arguments.eventTO.seriesId);
			setContactFirstName(arguments.eventTO.contactFirstName);
			setContactLastName(arguments.eventTO.contactLastName);
			setContactPhone(arguments.eventTO.contactPhone);
			setContactEmail(arguments.eventTO.contactEmail);
			setComments(arguments.eventTO.comments);
			setApprovedDate(arguments.eventTO.approvedDate);
			setApprovedBy(arguments.eventTO.approvedBy);
		</cfscript>
	</cffunction>
	
	<cffunction name="createEventTO" access="package" returntype="eventTO" output="false">
		<cfscript>
			var eventTO = createObject("component", "eventTO").init(argumentcollection=variables.instance);
			return eventTO;
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->

	<cffunction name="convert" access="public" returntype="string" output="false">
		<cfargument name="format" type="string" required="true" />
		<cfscript>
			switch(lCase(arguments.format)) {
				case "icalendar":
					export = generateICalendar();
					break;
				case "vcalendar":
					export = generateVCalendar();
					break;
			}
			return export;
		</cfscript>
	</cffunction>
	
	<cffunction name="dateFormatUTC" access="private" returntype="string" output="false">
		<cfargument name="datetime" required="false" default="#now()#">
		<cfset format = dateFormat(arguments.datetime,'yyyymmdd') & "T" & timeFormat(arguments.datetime,'HHmmss') & "Z">
		<cfreturn format />
	</cffunction>

	<cffunction name="generateICalendar" access="private" returntype="string" output="false">
		<cfargument name="singleOccurrence" type="boolean" required="false" default="false" />
		<cfscript>
			var eventTO = getEventTO();
			crlf = chr(13) & chr(10);
			iCal = "BEGIN:VCALENDAR" & crlf;
			iCal = iCal & "PRODID:-//calendarInfusion-3.0" & crlf;
			iCal = iCal & "VERSION:2.0" & crlf;
			iCal = iCal & "METHOD:PUBLISH" & crlf;
			iCal = iCal & "BEGIN:VEVENT" & crlf;
			iCal = iCal & "UID:#replace(createUuid(),'-','','ALL')#@calendarInfusion.infusiontechnology.com" & crlf;
			iCal = iCal & "SUMMARY:" & eventTO.title & crlf;
			description = replaceList(eventTO.description,"#Chr(10)#,#Chr(13)#", "=0A,=0D");
			iCal = iCal & "DESCRIPTION:" & description & crlf;
			iCal = iCal & "LOCATION:" & eventTO.location & crlf;
			iCal = iCal & "PRIORITY:3" & crlf;
			iCal = iCal & "DTSTAMP:" & dateFormatUTC(now()) & crlf;
			if(eventTO.recurrence eq true and arguments.singleOccurrence neq true) {
				// CODE: I need to determine the appropriate startDateTime for the recurring event.  It isn't the startDateTime
				// for this particular occurrence, but needs to be the startDateTime for the "parent" occurrence
				iCal = iCal & "DTSTART:" & dateFormatUTC(eventTO.startDateTime) & crlf;
				if(eventTO.allDay eq true) {
					endTime = dateAdd("d",+1,eventTO.startDateTime);
				} else {
					endTime = dateAdd("s",eventTO.duration,eventTO.startDateTime);
				}
				iCal = iCal & "DTEND:" & dateFormatUTC(endTime) & crlf;

				rule = eventTO.recurrenceRule;
				switch (lCase(getToken(eventTO.recurrenceRule,1,'_'))) {
					case 'n':
						break;
					case 'c':
						interval = getToken(rule, 2, "_");
						frequency = listGetAt("DAILY,WEEKLY,MONTHLY,YEARLY",listFind("d,w,m,y",lCase(getToken(rule, 3, "_"))));
						if(compareNoCase("y",trim(lCase(getToken(rule, 3, "_")))) eq 0) {
							iCal = iCal & "RRULE:FREQ=#frequency#";
						} else {
							iCal = iCal & "RRULE:FREQ=#frequency#;INTERVAL=#interval#";
						}
						if(compareNoCase(frequency,"MONTHLY") eq 0) { iCal = iCal & ";BYMONTHDAY=#day(eventTO.startDateTime)#"; }
						if(isDate(eventTO.recurrenceEndDate)) {
							iCal = iCal & ";UNTIL=" & dateFormatUTC(eventTO.recurrenceEndDate) & crlf;
						} else {
							iCal = iCal & crlf;
						}
						break;
					case 'w':
						interval = getToken(rule, 2, "_");
						daysByNum = getToken(rule, 3, "_");
						days = "";
						for(i=1; i lte listLen(daysByNum); i=i+1) {
							days = listAppend(days,listGetAt("SU,MO,TU,WE,TH,FR,SA",listGetAt(daysByNum,i)));
						}
						iCal = iCal & "RRULE:FREQ=WEEKLY;INTERVAL=#interval#;BYDAY=#days#";
						if(isDate(eventTO.recurrenceEndDate)) {
							iCal = iCal & ";UNTIL=" & dateFormatUTC(eventTO.recurrenceEndDate) & crlf;
						} else {
							iCal = iCal & crlf;
						}
						break;
					case 'm':
						interval = getToken(rule, 2, "_");
						offset = getToken(rule, 3, "_");
						if(offset eq 5) { offset = -1; }
						wday = listGetAt("SU,MO,TU,WE,TH,FR,SA",getToken(rule, 4, "_"));
						iCal = iCal & "RRULE:FREQ=MONTHLY;INTERVAL=#interval#;BYDAY=#offset##wday#";
						if(isDate(eventTO.recurrenceEndDate)) {
							iCal = iCal & ";UNTIL=" & dateFormatUTC(eventTO.recurrenceEndDate) & crlf;
						} else {
							iCal = iCal & crlf;
						}
						break;
				} 
			} else {
				iCal = iCal & "DTSTART:" & dateFormatUTC(eventTO.startDateTime) & crlf;
				if(eventTO.allDay eq true) {
					endTime = dateAdd("d",+1,eventTO.startDateTime);
				} else {
					endTime = dateAdd("s",eventTO.duration,eventTO.startDateTime);
				}
				iCal = iCal & "DTEND:" & dateFormatUTC(endTime) & crlf;
			}
			iCal = iCal & "END:VEVENT" & crlf;
			iCal = iCal & "END:VCALENDAR"& crlf;	
		</cfscript>
		<cfreturn iCal>
	</cffunction>

	<cffunction name="generateVCalendar" access="private" returntype="string" output="false">
		<cfargument name="eventDate" required="false" default="">

		<cfset vCal = "">
		<cfset crlf = chr(13) & chr(10)>

		<cftrace text="V START TIME: #eventTO.startDateTime#">
		<!---
		// If a recurring event instance date has been specified, then generate
		// the vCalendar output for that particular date.
		--->
		<cfif isDate(arguments.eventDate)>
			<cftry>
				<cfinvoke method="getInstanceDate" returnvariable="instanceDate" date="#arguments.eventDate#">
				<cfcatch type="any">
					<cfset instanceDate = getStartDateTime()>
				</cfcatch>
			</cftry>
		<cfelse>
			<cfset instanceDate = getStartDateTime()>
		</cfif>

		<cfscript>
			vCal = "BEGIN:VCALENDAR" & crlf;
			vCal = vCal & "VERSION:1.0" & crlf;
			vCal = vCal & "BEGIN:VEVENT" & crlf;
			vCal = vCal & "DTSTART:" & dateFormat(instanceDate,"yyyymmdd") & "T" & timeFormat(instanceDate, "HHmmss") & "Z" & crlf;
			endTime = dateAdd("s",getDuration(),instanceDate);
			vCal = vCal & "DTEND:" & dateFormat(endTime, "yyyymmdd") & "T" & timeFormat(endTime, "HHmmss") & "Z" & crlf;
			vCal = vCal & "SUMMARY:" & getTitle() & crlf;
			vCal = vCal & "DESCRIPTION:";
			description = replaceList(getDescription(),"#Chr(10)#,#Chr(13)#", "=0A,=0D");
			vCal = vCal & description & crlf;
			vCal = vCal & "LOCATION:" & getLocation() & crlf;
			vCal = vCal & "PRIORITY:3" & crlf;
			vCal = vCal & "END:VEVENT" & crlf;
			vCal = vCal & "END:VCALENDAR"& crlf;	
		</cfscript>

		<cfreturn vCal>
	</cffunction>
	
	<cffunction name="getStatus" access="public" returntype="string" output="false">
		<!---// CODE: Implement this method! --->
		<cfreturn "approved" />
	</cffunction>

</cfcomponent>