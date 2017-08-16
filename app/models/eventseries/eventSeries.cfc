<cfcomponent displayname="eventSeries">

	<cfset variables.instance.seriesId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.description = "" />
	<cfset variables.instance.category = createObject('component','calendar.models.category.category') />
	<cfset variables.instance.eventUrl = "" />
	<cfset variables.instance.duration = 3600 />
	<cfset variables.instance.location = "" />
	<cfset variables.instance.allDay = false />
	<cfset variables.instance.recurrence = false />
	<cfset variables.instance.recurrenceRule = "" />
	<cfset variables.instance.recurrenceStartDate = now() />
	<cfset variables.instance.recurrenceEndDate = now() />
	<cfset variables.instance.contactFirstName = "" />
	<cfset variables.instance.contactLastName = "" />
	<cfset variables.instance.contactPhone = "" />
	<cfset variables.instance.contactEmail = "" />
	<cfset variables.instance.comments = "" />
	<cfset variables.instance.approvedDate = now() />
	<cfset variables.instance.approvedBy = "" />
	
	<cffunction name="init" access="public" returntype="eventSeries" output="false">
		<cfargument name="seriesId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="category" type="calendar.models.category.category" required="false" default="#createObject('component','calendar.models.category.category')#" />
		<cfargument name="eventUrl" type="string" required="false" default="" />
		<cfargument name="duration" type="numeric" required="false" default="0" />
		<cfargument name="location" type="string" required="false" default="" />
		<cfargument name="allDay" type="boolean" required="false" default="false" />
		<cfargument name="recurrence" type="boolean" required="false" default="false" />
		<cfargument name="recurrenceRule" type="string" required="false" default="" />
		<cfargument name="recurrenceStartDate" type="date" required="false" default="#now()#" />
		<cfargument name="recurrenceEndDate" type="date" required="false" default="#now()#" />
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
			setSeriesId(arguments.info.seriesId);
			setTitle(arguments.info.title);
			setDescription(arguments.info.description);
			setCategory(arguments.info.category);
			setEventUrl(arguments.info.eventUrl);
			setDuration(arguments.info.duration);
			setLocation(arguments.info.location);
			setAllDay(arguments.info.allDay);
			setRecurrence(arguments.info.recurrence);
			setRecurrenceRule(arguments.info.recurrenceRule);
			setRecurrenceStartDate(arguments.info.recurrenceStartDate);
			setRecurrenceEndDate(arguments.info.recurrenceEndDate);
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

	<cffunction name="setSeriesId" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfset variables.instance.seriesId = arguments.seriesId />
	</cffunction>
	<cffunction name="getSeriesId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.seriesId />
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

	<cffunction name="setRecurrenceStartDate" access="public" returntype="void" output="false">
		<cfargument name="recurrenceStartDate" type="string" required="true" />
		<cfset variables.instance.recurrenceStartDate = arguments.recurrenceStartDate />
	</cffunction>
	<cffunction name="getRecurrenceStartDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recurrenceStartDate />
	</cffunction>
	
	<cffunction name="setRecurrenceEndDate" access="public" returntype="void" output="false">
		<cfargument name="recurrenceEndDate" type="string" required="true" />
		<cfset variables.instance.recurrenceEndDate = arguments.recurrenceEndDate />
	</cffunction>
	<cffunction name="getRecurrenceEndDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recurrenceEndDate />
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
	
	<cffunction name="getEventSeriesTO" access="public" returntype="eventSeriesTO" output="false">
		<cfreturn createEventSeriesTO() />
	</cffunction>
			
	<cffunction name="setEventSeriesFromTO" access="public" returntype="void" output="false" hint="set the eventInstance data from TO">
		<cfargument name="eventSeriesTO" type="eventSeriesTO" required="true" />		
		<cfscript>
			setSeriesId(arguments.eventSeriesTO.seriesId);
			setTitle(arguments.eventSeriesTO.title);
			setDescription(arguments.eventSeriesTO.description);
			setCategory(arguments.eventSeriesTO.category);
			setEventUrl(arguments.eventSeriesTO.eventUrl);
			setDuration(arguments.eventSeriesTO.duration);
			setLocation(arguments.eventSeriesTO.location);
			setAllDay(arguments.eventSeriesTO.allDay);
			setRecurrence(arguments.eventSeriesTO.recurrence);
			setRecurrenceRule(arguments.eventSeriesTO.recurrenceRule);
			setRecurrenceStartDate(arguments.eventSeriesTO.recurrenceStartDate);
			setRecurrenceEndDate(arguments.eventSeriesTO.recurrenceEndDate);
			setContactFirstName(arguments.eventSeriesTO.contactFirstName);
			setContactLastName(arguments.eventSeriesTO.contactLastName);
			setContactPhone(arguments.eventSeriesTO.contactPhone);
			setContactEmail(arguments.eventSeriesTO.contactEmail);
			setComments(arguments.eventSeriesTO.comments);
			setApprovedDate(arguments.eventSeriesTO.approvedDate);
			setApprovedBy(arguments.eventSeriesTO.approvedBy);
		</cfscript>
	</cffunction>
	
	<cffunction name="createEventSeriesTO" access="package" returntype="eventSeriesTO" output="false">
		<cfscript>
			var eventSeriesTO = createObject("component", "eventSeriesTO").init(argumentcollection=variables.instance);
			return eventSeriesTO;
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Miscellaneous methods
	------------------------------------------------------------------------------------->

	<cffunction name="convert" access="public" returntype="string" output="false">
		<cfargument name="format" type="string" required="true" />
		
		<cfscript>
			switch(lCase(arguments.format)) {
				case "icalendar":
					export = generateICalendar();
					break;
//				case "vcalendar":
//					export = generateVCalendar();
//					break;
			}
			return export;
		</cfscript>
	</cffunction>
	
	<cffunction name="dateFormatUTC" access="private" returntype="string" output="false">
		<cfargument name="datetime" required="false" default="#now()#">
		<cfset format = dateFormat(arguments.datetime,'yyyymmdd') & "T" & timeFormat(arguments.datetime,'HHmmss') & "Z">
		<cfreturn format />
	</cffunction>

	<cffunction name="generateRecurrenceString" access="public" returntype="string" output="false">
		<cfargument name="tzoffset" type="numeric" required="false" default="0" hint="Time offset (in minutes) with which to adjust the recurrence dates." />
		<cfscript>
			var rule = getRecurrenceRule();
			var startDateTime = getRecurrenceStartDate();
			var recurrenceEndDate = getRecurrenceEndDate();
			var duration = getDuration();
			var allDay = getAllDay();
		</cfscript>
		
		<!---
		// CFMX doesn't always seem to like the yyyy-mm-dd date format, so parse
		// the dates to be sure an error isn't generated
		--->
		<cfif isDate(startDateTime)><cfset startDateTime = parseDateTime(startDateTime)></cfif>
		<cfif isDate(recurrenceEndDate)><cfset recurrenceEndDate = parseDateTime(recurrenceEndDate)></cfif>

		<!---// Adjust for the timezone --->
		<cfset startDateTime = dateAdd("h",arguments.tzoffset,startDateTime) />
		<cfset recurrenceEndDate = dateAdd("h",arguments.tzoffset,recurrenceEndDate) />
		
		<cfswitch expression="#lCase(getToken(rule,1,'_'))#">
			<!---// Cyclical recurrence... e.g. "occurs every 2 weeks". --->
			<cfcase value="c">
				<cfset freq = getToken(rule, 2, "_")>
				<cfset period = getToken(rule, 3, "_")>
				
				<cfscript>
					// initialize the string
					str = "Occurs every ";
					
					// add recurrence information
					switch(period) {
						case "d": {
							periodStr = "day";
							if(freq gt 1) { str = str & freq & " " & periodStr & "s"; } else { str = str & periodStr; }
							break;
						}
						case "w": {
							periodStr = "week";
							if(freq gt 1) { str = str & freq & " " & periodStr & "s"; } else { str = str & periodStr; }					
							break;					
						}
						case "m": {
							periodStr = "month";
							dateStr = dateFormat(startDateTime, 'd');
							switch(right(dateStr,1)) {
								case "1": { dateStr = dateStr & "st"; break; }
								case "2": { dateStr = dateStr & "nd"; break; }
								case "3": { dateStr = dateStr & "rd"; break; }						
								default: { dateStr = dateStr & "th"; break; }
							}
							
							if(freq gt 1) { str = str & freq & " " & periodStr & "s"; } else { str = str & periodStr; }					
							str = str & " on the " & dateStr & " day of the month";
							break;
						}
						case "y": { 
							periodStr = "year";
							if(freq gt 1) { str = str & freq & " " & periodStr & "s"; } else { str = str & periodStr; }					
							str = str & " on " & lsDateFormat(startDateTime,'medium');
							break;
						}
					}
			
					// add time information
					if(isDefined("startDateTime") and isDefined("duration") and allDay neq true) {
						str = str & " from " & lsTimeFormat(startDateTime,'medium');
						str = str & " to " & lsTimeFormat(dateAdd("s",duration,startDateTime),'medium');
					}
					
					// add start/end date information
					if(isDefined("startDateTime") and isDefined("recurrenceEndDate") and isDate(recurrenceEndDate)) {
						str = str & " beginning on " & lsDateFormat(startDateTime,'long');
						str = str & " and ending on " & lsDateFormat(recurrenceEndDate,'long');
					}	
				</cfscript>
			</cfcase>
			
			<!---// Weekly recurrence... e.g. "occurs every 3 weeks on MWF". --->
			<cfcase value="w">
				<cfset freq = getToken(rule, 2, "_")>
				<cfset days = getToken(rule, 3, "_")>
				
				<cfscript>
					// initialize the string
					str = "Occurs every ";
					
					// add recurrence information
					if(freq gt 1) { str = str & freq & " weeks"; } else { str = str & "week"; }
					if(listLen(days) gt 2) {
						str = str & " on ";
						do {
							str = str & dayOfWeekAsString(listFirst(days)) & ", ";
							days = listRest(days);
						} while (listLen(days) gt 1);
						str = str & "and " & dayOfWeekAsString(listFirst(days));
					} else if (listLen(days) eq 2) {
						str = str & " on " & dayOfWeekAsString(listFirst(days)) & " and " & dayOfWeekAsString(listLast(days));
					} else if (listLen(days) eq 1) {
						str = str & " on " & dayOfWeekAsString(listFirst(days));			
					} else {
						str = str;
					}
				
					// add time information
					if(isDefined("startDateTime") and isDefined("duration") and allDay neq true) {
						str = str & " from " & lsTimeFormat(startDateTime,'medium');
						str = str & " to " & lsTimeFormat(dateAdd("s",duration,startDateTime),'medium');
					}
					
					// add start/end date information
					if(isDefined("startDateTime") and isDefined("recurrenceEndDate") and isDate(recurrenceEndDate)) {
						str = str & " beginning " & lsDateFormat(startDateTime,'long');
						str = str & " and ending " & lsDateFormat(recurrenceEndDate,'long');
					}			
				</cfscript>
			</cfcase>
		
			<!---
			// Monthly recurrence... e.g. "occurs every 3 months on 2nd Monday of month"
			--->
			<cfcase value="m">
				<cfset freq = getToken(rule, 2, "_")>
				<cfset offset = getToken(rule, 3, "_")>
				<cfset day = getToken(rule, 4, "_")>
			
				<cfscript>
					// initialize the string
					str = "Occurs every ";
					
					// add recurrence information
					if(freq gt 1) { str = str & freq & " months"; } else { str = str & "month"; }
					offsetStr = offset;
					switch(right(offsetStr,1)) {
						case "1": { offsetStr = offsetStr & "st"; break; }
						case "2": { offsetStr = offsetStr & "nd"; break; }
						case "3": { offsetStr = offsetStr & "rd"; break; }				
						default: { offsetStr = offsetStr & "th"; break; }
					}
					str = str & " on the " & offsetStr & " " & dayOfWeekAsString(day) & " of the month";
					
					// add time information
					if(isDefined("startDateTime") and isDefined("duration") and allDay neq true) {
						str = str & " from " & lsTimeFormat(startDateTime,'medium');
						str = str & " to " & lsTimeFormat(dateAdd("s",duration,startDateTime),'medium');
					}
					
					// add start/end date information
					if(isDefined("startDateTime") and isDefined("recurrenceEndDate") and isDate(recurrenceEndDate)) {
						str = str & " beginning on " & lsDateFormat(startDateTime,'long');
						str = str & " and ending on " & lsDateFormat(recurrenceEndDate,'long');
					}			
				</cfscript>
			</cfcase>
		</cfswitch>
		
		<cfreturn str>
	</cffunction>

	<cffunction name="generateICalendar" returntype="string" output="false">
		<cfargument name="singleOccurrence" type="boolean" required="false" default="false" />
		<cfscript>
			var eventTO = getEventTO();
			crlf = chr(13) & chr(10);
			iCal = "BEGIN:VCALENDAR" & crlf;
			iCal = iCal & "PRODID:-//calendarInfusion-2.6" & crlf;
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
				iCal = iCal & "DTSTART:" & dateFormatUTC(dateConvert("local2utc", eventTO.startDateTime)) & crlf;
				if(eventTO.allDay eq true) {
					endTime = dateAdd("d",+1,eventTO.startDateTime);
				} else {
					endTime = dateAdd("s",eventTO.duration,eventTO.startDateTime);
				}
				iCal = iCal & "DTEND:" & dateFormatUTC(dateConvert("local2utc", endTime)) & crlf;

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
							iCal = iCal & ";UNTIL=" & dateFormatUTC(dateConvert("local2utc", eventTO.recurrenceEndDate)) & crlf;
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
							iCal = iCal & ";UNTIL=" & dateFormatUTC(dateConvert("local2utc", eventTO.recurrenceEndDate)) & crlf;
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
							iCal = iCal & ";UNTIL=" & dateFormatUTC(dateConvert("local2utc", eventTO.recurrenceEndDate)) & crlf;
						} else {
							iCal = iCal & crlf;
						}
						break;
				} 
			} else {
				iCal = iCal & "DTSTART:" & dateFormatUTC(dateConvert("local2utc", eventTO.startDateTime)) & crlf;
				if(eventTO.allDay eq true) {
					endTime = dateAdd("d",+1,eventTO.startDateTime);
				} else {
					endTime = dateAdd("s",eventTO.duration,eventTO.startDateTime);
				}
				iCal = iCal & "DTEND:" & dateFormatUTC(dateConvert("local2utc", endTime)) & crlf;
			}
			iCal = iCal & "END:VEVENT" & crlf;
			iCal = iCal & "END:VCALENDAR"& crlf;	
		</cfscript>

		<cfreturn iCal>
	</cffunction>

	<cffunction name="generateVCalendar" returntype="string" output="false">
		<cfargument name="eventDate" required="false" default="">

		<cfset vCal = "">
		<cfset crlf = chr(13) & chr(10)>

		<!---
		// If a recurring event eventInstance date has been specified, then generate
		// the vCalendar output for that particular date.
		--->
		<cfif isDate(arguments.eventDate)>
			<cftry>
				<cfinvoke method="getInstanceDate" returnvariable="eventInstanceDate" date="#arguments.eventDate#">
				<cfcatch type="any">
					<cfset eventInstanceDate = getRecurrenceStartDate()>
				</cfcatch>
			</cftry>
		<cfelse>
			<cfset eventInstanceDate = getRecurrenceStartDate()>
		</cfif>

		<cfscript>
			vCal = "BEGIN:VCALENDAR" & crlf;
			vCal = vCal & "VERSION:1.0" & crlf;
			vCal = vCal & "BEGIN:VEVENT" & crlf;
			vCal = vCal & "DTSTART:" & dateFormat(dateConvert("local2utc", eventInstanceDate),"yyyymmdd") & "T" & timeFormat(dateConvert("local2utc", eventInstanceDate), "HHmmss") & "Z" & crlf;
			endTime = dateAdd("s",this.duration,eventInstanceDate);
			vCal = vCal & "DTEND:" & dateFormat(dateConvert("local2utc", endTime), "yyyymmdd") & "T" & timeFormat(dateConvert("local2utc", endTime), "HHmmss") & "Z" & crlf;
			vCal = vCal & "LOCATION:" & this.location & crlf;
			vCal = vCal & "SUMMARY;ENCODING=QUOTED-PRINTABLE:" & this.title & crlf;
			vCal = vCal & "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:";
			description = replaceList(this.description,"#Chr(10)#,#Chr(13)#", "=0A,=0D");
			vCal = vCal & description & crlf;
			vCal = vCal & "PRIORITY:3" & crlf;
			vCal = vCal & "END:VEVENT" & crlf;
			vCal = vCal & "END:VCALENDAR"& crlf;	
		</cfscript>

		<cfreturn vCal>
	</cffunction>

	<cffunction name="getInstanceDate" returntype="date" output="false">
		<cfargument name="date" required="false" type="date" default="#getRecurrenceStartDate()#">
		<cfargument name="recurrenceRule" required="false" type="string" default="#getrecurrenceRule()#">
		
		<!---// Pre-process the recurrence information. --->
		<cfset rule = arguments.recurrenceRule>
		<cfparam name="eventInstance" default="">
		<cfswitch expression="#lCase(getToken(rule,1,'_'))#">
			<!---// Cyclical recurrence... e.g. "occurs every 2 weeks". --->
			<cfcase value="c">
				<cfscript>
					freq = getToken(rule, 2, "_");
					period = getToken(rule, 3, "_");
				
					switch(period) {
						case "d": { period = "d"; break; }
						case "w": { period = "ww"; break; }
						case "m": { period = "m"; break; }
						case "y": { period = "yyyy"; break; }
					}
				</cfscript>
			
				<cfset loopDate = getRecurrenceStartDate()>
				<cfset index = 0>
				<cfloop condition="dateCompare(loopDate, arguments.date) lte 0">
					<cfset eventInstanceDate = dateAdd(period, index * freq, getRecurrenceStartDate())>
			
					<cfif dateCompare(eventInstanceDate, date, "d") eq 0>
						<cfset eventInstance = createDateTime(year(eventInstanceDate), month(eventInstanceDate), day(eventInstanceDate), hour(getRecurrenceStartDate()), minute(getRecurrenceStartDate()), second(getRecurrenceStartDate()))>
						<cfbreak>
					</cfif>
					<cfset index = index + 1>
					<cfset loopDate = dateAdd(period, freq, loopDate)>
				</cfloop>
			</cfcase>
			
			<!---// Weekly recurrence... e.g. "occurs every 3 weeks on MWF". --->
			<cfcase value="w">
				<cfset freq = getToken(rule, 2, "_")>
				<cfset days = getToken(rule, 3, "_")>
				
				<cfset loopDate = dateAdd("d", evaluate(1-dayOfWeek(getRecurrenceStartDate())), getRecurrenceStartDate())>
				<cfloop condition="dateCompare(loopDate, dateAdd('d', 1, arguments.date)) lte 0">
					<cfset dow = dayOfWeek(loopDate)>
					<cfloop index="d" list="#days#">
						<cfset eventInstanceDate = dateAdd("d", evaluate(d-dow), loopDate)>
						<cfif dateCompare(eventInstanceDate, getRecurrenceStartDate(), "d") lt 0>
							<!---// Do nothing... simply skip to the next date. --->
						<cfelseif isDate(this.recurrenceEndDate) AND dateCompare(eventInstanceDate, this.recurrenceEndDate, "d") gt 0>
							<cfset loopDate = dateAdd('d', 2, arguments.date)>
							<cfbreak>
							<cfelseif dateCompare(eventInstanceDate, arguments.date, "d") eq 0>
							<cfset eventInstance = createDateTime(year(eventInstanceDate), month(eventInstanceDate), day(eventInstanceDate), hour(getRecurrenceStartDate()), minute(getRecurrenceStartDate()), second(getRecurrenceStartDate()))>
							<cfbreak>
						</cfif>
					</cfloop>
					<cfset loopDate = dateAdd("ww", freq, loopDate)>
				</cfloop>
			</cfcase>
		
			<!---
			// Monthly recurrence... e.g. "occurs every 3 months on 2nd Monday of month"
			--->
			<cfcase value="m">
				<cfset freq = getToken(rule, 2, "_")>
				<cfset offset = getToken(rule, 3, "_")>
				<cfset day = getToken(rule, 4, "_")>
			
				<cfset loopDate = getRecurrenceStartDate()>
				<cfloop condition="dateCompare(loopDate, dateAdd('m', 2, arguments.date)) lte 0">
					<cfif offset eq 5>
						<!---// Last week of month. --->
						<cfset ldow = dayOfWeek(createDate(year(loopDate), month(loopDate), daysInMonth(loopDate)))>
						<cfset eventInstanceDate = dateAdd("d", (day-ldow) - 7*iif(day gt ldow, 1, 0), createDate(year(loopDate), month(loopDate), daysInMonth(loopDate)))>
					<cfelse>
						<!---// First, second, third, or fourth week of month. --->
						<cfset fdow = dayOfWeek(createDate(year(loopDate), month(loopDate), 1))>
						<cfset loopDateTmp = dateAdd("d", 7*iif(day lt fdow, 1, 0) + (day-fdow), createDate(year(loopDate), month(loopDate), 1))>
						<cfset eventInstanceDate = dateAdd("ww", evaluate(offset)-1, loopDateTmp)>
					</cfif>
					
					<cfif dateCompare(eventInstanceDate, date, "d") eq 0>
						<cfset eventInstance = createDateTime(year(eventInstanceDate), month(eventInstanceDate), day(eventInstanceDate), hour(getRecurrenceStartDate()), minute(getRecurrenceStartDate()), second(getRecurrenceStartDate()))>
						<cfbreak>
					</cfif>
					<cfset loopDate = dateAdd("m", freq, loopDate)>
				</cfloop>
			</cfcase>
		</cfswitch>
		
		<cfif not isDate(eventInstance)>
			<cfthrow type="InstanceNotFoundException">
		</cfif>
		<cfreturn eventInstance>
	</cffunction>

	<cffunction name="generateInstanceDates" access="public" returntype="array" output="false">
		<cfargument name="start"  type="date" required="false" default="#getRecurrenceStartDate()#" />
		<cfargument name="end"  type="date" required="false" default="#getRecurrenceEndDate()#" />

		<cfif getRecurrence() eq false>
			<cfset eventInstanceDates = arrayNew(1) />
			<cfset eventInstanceDates[1] = getRecurrenceStartDate() />
			<cfreturn eventInstanceDates />
			<cfexit>
		</cfif>

		<cfset rule = getRecurrenceRule() />

		<!---// If the start date is later than the end date, swap them. --->
		<cfif isDate(arguments.start) and isDate(arguments.end) and dateCompare(arguments.start,arguments.end) gt 0>
			<cfset tmpDate = arguments.start>
			<cfset arguments.start = arguments.end>
			<cfset arguments.end = tmpDate>
		</cfif>
		<cftrace text="#rule#">
		
		<!---// Pre-process the recurrence information. --->
		<cfset eventInstanceDates = arrayNew(1)>
		<cfswitch expression="#lCase(getToken(rule,1,'_'))#">
			<!---// Cyclical recurrence... e.g. "occurs every 2 weeks". --->
			<cfcase value="c">
				<cfscript>
					freq = getToken(rule, 2, "_");
					period = getToken(rule, 3, "_");
				
					switch(period) {
						case "d": { period = "d"; break; }
						case "w": { period = "ww"; break; }
						case "m": { period = "m"; break; }
						case "y": { period = "yyyy"; break; }
					}
					
					loopStart = arguments.start;
					loopLimit = arguments.end;
					loopDate = loopStart;
					index = 0;
					while(dateCompare(loopDate,loopLimit,'d') lte 0) {
						eventInstanceStart = dateAdd(period, index*freq, loopStart);
						arrayAppend(eventInstanceDates, eventInstanceStart);
						index = index + 1;
						loopDate = dateAdd(period, freq, loopDate);
					}
				</cfscript>
			</cfcase>
			
			<!---// Weekly recurrence... e.g. "occurs every 3 weeks on MWF". --->
			<cfcase value="w">
				<cfscript>
					freq = getToken(rule, 2, "_");
					days = getToken(rule, 3, "_");
				
					loopStart = arguments.start;
					loopLimit = arguments.end;
					loopDate = loopStart;
					while(dateCompare(dateAdd('ww',-1,loopDate),loopLimit,'d') lte 0) {
						dow = dayOfWeek(loopDate);
						for(i=1; i lte listLen(days); i=i+1) {
							d = listGetAt(days,i);
							eventInstanceStart = dateAdd("d", evaluate(d-dow), loopDate);
							if(dateCompare(eventInstanceStart,arguments.start) gte 0 and dateCompare(eventInstanceStart,arguments.end) lte 0) {
								arrayAppend(eventInstanceDates, eventInstanceStart);
							}
						}					
						loopDate = dateAdd('ww', freq, loopDate);
					}
				</cfscript>
			</cfcase>
		
			<!---
			// Monthly recurrence... e.g. "occurs every 3 months on 2nd Monday of month"
			--->
			<cfcase value="m">
				<cfscript>
					freq = getToken(rule, 2, "_");
					offset = getToken(rule, 3, "_");
					day = getToken(rule, 4, "_");
			
					loopStart = arguments.start;
					loopLimit = arguments.end;
					loopDate = loopStart;
					index = 1;
					while(dateCompare(loopDate,loopLimit,'d') lte 0) {
						if(offset eq 5) {
							// Last week of month.
							ldow = dayOfWeek(createDate(year(loopDate), month(loopDate), daysInMonth(loopDate)));
							eventInstanceStart = dateAdd("d", (day-ldow) - 7*iif(day gt ldow, 1, 0), createDate(year(loopDate), month(loopDate), daysInMonth(loopDate)));
						} else {
							// First, second, third, or fourth week of month.
							fdow = dayOfWeek(createDate(year(loopDate), month(loopDate), 1));
							loopDateTmp = dateAdd("d", 7*iif(day lt fdow, 1, 0) + (day-fdow), createDate(year(loopDate), month(loopDate), 1));
							eventInstanceStart = dateAdd("ww", evaluate(offset)-1, loopDateTmp);
						}
						
						// Verify the 
						eventInstanceStart = dateAdd("n",minute(arguments.start),dateAdd("h",hour(arguments.start),eventInstanceStart));
						if(dateCompare(eventInstanceStart,arguments.start) gte 0 and dateCompare(eventInstanceStart,arguments.end) lte 0) {
							arrayAppend(eventInstanceDates, eventInstanceStart);
						}
						index = index+1;
						loopDate = dateAdd("m", freq, loopDate);
					}
				</cfscript>
			</cfcase>
		</cfswitch>
		<cfreturn eventInstanceDates />
	</cffunction>

	<cffunction name="getStatus" access="public" returntype="string" output="false">
		<!---// CODE: Implement this method! --->
		<cfreturn "approved" />
	</cffunction>

</cfcomponent>