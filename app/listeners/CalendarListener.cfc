<cfcomponent displayname="CalendarListener" extends="MachII.framework.Listener">

	<!--- PROPERTIES --->
	<cfset this.REQUIRED_PERMISSIONS_PARAM = "requiredPermissions" />
	<cfset this.INVALID_EVENT_PARAM = "invalidEvent" />
	<cfset this.INVALID_MESSAGE_PARAM = "invalidMessage" />
	<cfset this.CLEAR_EVENT_QUEUE_PARAM = "clearEventQueue" />
	<cfset this.LOGIN_ENCRYPTION_KEY = "encryption_key" />

	<cffunction name="configure" access="public" returntype="void" output="true" displayname="Listener Constructor">
		<cfscript>
			var appConstants = getAppManager().getPropertyManager().getProperty("appConstants");
			var dsn = appConstants.getDbDsn();
			var dbType = appConstants.getDbType();
			variables.sessionFacade = getAppManager().getPropertyManager().getProperty("sessionFacade");
			variables.timezoneLibrary = getAppManager().getPropertyManager().getProperty("timezoneLibrary");
			variables.applicationGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getApplicationGateway();
			variables.calendarGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getCalendarGateway();
			variables.categoryGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getCategoryGateway();
			variables.eventGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getEventGateway();
			variables.eventSeriesGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getEventSeriesGateway();
			variables.groupGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getGroupGateway();
			variables.holidayGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getHolidayGateway();
			variables.mailServerGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getMailServerGateway();
			variables.reminderGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getReminderGateway();
			variables.schemeGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getSchemeGateway();
			variables.searchGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getSearchGateway();
			variables.searchIndexGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getSearchIndexGateway();
			variables.userGateway = createObject("component", "calendar.models.dao.GatewayFactory").init(dsn).getGatewayFactory(dbType).getUserGateway();
			initializeApplication();
		</cfscript>
	</cffunction>
	
	<cffunction name="initializeApplication" access="private" returntype="void" output="false">
		<cfargument name="language" type="string" required="false" default="en-us" />
		<cftry>
			<cfinclude template="../bundles/#arguments.language#.cfm" />
			<cfcatch type="missingInclude">
				<cftry>
					<cfinclude template="../bundles/en-us.cfm" />
					<cfcatch type="any">
						<cfthrow message="Application initialization error." detail="An error occurred attempting to access the default application language bundle (en-us), which indicates the application has not been installed correctly.  The application cannot be initialized." />
					</cfcatch>
				</cftry>
			</cfcatch>
		</cftry>
		<cfscript>
			if(isDefined("application.resource") and isStruct(application.resource)) {
				structClear(application.resource);
			} else {
				application.resource = structNew();
			}
			application.resource.bundle = resourceBundle;
		</cfscript>
		<cfset application.app.global.calendar.status.pending = "pending" />
		<cfset application.app.global.calendar.status.approved = "approved" />
		<cfset application.resource.bundle.image.directory = "images/#arguments.language#" />
		<cfset variables.sessionFacade.setStyle() />
	</cffunction>

	<cffunction name="approveEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var approvedDate = now();
			variables.eventGateway.setStatus(eventId=arguments.event.getArg("eventId"), calendarId=arguments.event.getArg("calendarId"), status="approved");
			
			// CODE: Implement code: Update the search index for the calendar
		</cfscript>
	</cffunction>

	<cffunction name="approveEvents" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var seriesIds = arguments.event.getArg("eventList");
			for(i=1; i lte listLen(seriesIds); i=i+1) {
				seriesId = listGetAt(seriesIds,i);
				if(arguments.event.isArgDefined("event_approval_#seriesId#")) {
					if(arguments.event.getArg("event_approval_#seriesId#") eq true) {
						// Event approved
						approveEventSeries(seriesId=seriesId, calendarId=arguments.event.getArg("calendarId"), approvedBy="null");
					} else {
						// Event rejected
						deleteEventSeries(seriesId=seriesId);
					}
				}
			}
		</cfscript>
	</cffunction>

	<cffunction name="approveEventSeries" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var approvedDate = now();
			variables.eventSeriesGateway.setStatus(seriesId=arguments.event.getArg("seriesId"), status="approved");
			q_events = variables.eventSeriesGateway.getSeriesEvents(seriesId=seriesId);
		</cfscript>
		<cfloop query="q_events">
			<cfscript>
				approveEvent(eventId=q_events.eventId, calendarId=arguments.event.getArg("calendarId"), approvedDate=approvedDate, approvedBy=arguments.event.getArg("approvedBy"));
			</cfscript>
		</cfloop>
	</cffunction>

	<cffunction name="createCalendar" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var cal = arguments.event.getArg("calendar");
			cal.setScheme(variables.schemeGateway.read(id="F933EE89-BF52-424E-B676E99ED287845B"));
			variables.calendarGateway.create(calendar=cal);
			si = createobject('component','calendar.models.searchIndex.searchIndex').init(title="Search Index for #cal.getCalendarId()#");
			si.setCollection("calendarInfusion_#si.getSearchIndexId()#");
			variables.searchIndexGateway.create(searchIndex=si);
			variables.calendarGateway.addSearchIndex(calendarId=cal.getCalendarId(),searchIndexId=si.getSearchIndexId());
			variables.calendarGateway.setConfiguration(calendarId=cal.getCalendarId(),configuration="calendar_default_group",value=trim(arguments.event.getArg("defaultGroup")));
		</cfscript>
	</cffunction>

	<cffunction name="createCategory" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.categoryGateway.create(category=arguments.event.getArg("category"));
			variables.calendarGateway.addCategory(calendarId=arguments.event.getArg("calendarId"), categoryId=arguments.event.getArg("category").getCategoryId());
		</cfscript>
	</cffunction>

	<cffunction name="createEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var eventItem = arguments.event.getArg("eventItem");
			var categoryId = arguments.event.getArg("categoryId");
			
			// Create an appropriate date/time value
			if(arguments.event.isArgDefined("allDay")) {
				if(not isDate(eventItem.getStartDateTime())) {
					startDate = arguments.event.getArg("startDate");
					startDateTime = createDateTime(year(startDate), month(startDate), day(startDate), 0, 0, 0);
					duration = evaluate(24*60*60-1);
				} else {
					startDateTime = eventItem.getStartDateTime();
				}
			} else {
				if(not isDate(eventItem.getStartDateTime())) {
					startDate = arguments.event.getArg("startDate");
					startDateTime = createDateTime(year(startDate), month(startDate), day(startDate), arguments.event.getArg("startDateTime_t") * 12 + arguments.event.getArg("startDateTime_h") mod 12, arguments.event.getArg("startDateTime_m"), 0);
					duration = arguments.event.getArg("duration_h") * 3600 + arguments.event.getArg("duration_m") * 60;
				} else {
					startDateTime = eventItem.getStartDateTime();
				}
			}
			
			// Account for the timezone
			startDateTime = variables.timezoneLibrary.toUtc(startDateTime, variables.sessionFacade.getUser().getTimezone());
			eventItem.setAllDay(arguments.event.isArgDefined("allDay"));
			eventItem.setStartDateTime(startDateTime);
			eventItem.setDuration(duration);
			if(len(categoryId) gt 0) {
				eventItem.setCategory(variables.categoryGateway.read(categoryId));
			}
			variables.eventGateway.create(event=eventItem);
			variables.calendarGateway.addEvent(calendarId=arguments.event.getArg("calendarId"), eventId=eventItem.getEventId(), status=eventItem.getStatus());
		</cfscript>
	</cffunction>

	<cffunction name="createEventSeries" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfscript>
			var series = arguments.event.getArg("eventSeries");
			var recurType = arguments.event.getArg("recurType");
			var categoryId = arguments.event.getArg("categoryId");
			var recurRule = lCase(recurType);
			switch(lCase(recurType)) {
				case("c"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurCFreq") & "_" & lCase(arguments.event.getArg("recurCPeriod"));
					break;
				case("w"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurWFreq") & "_" & lCase(arguments.event.getArg("recurWDays"));
					break;
				case("m"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurMFreq") & "_" & arguments.event.getArg("recurMOffset") & "_" & arguments.event.getArg("recurMDay");
					break;
			}
			if(arguments.event.isArgDefined("allDay")) {
				startDate = arguments.event.getArg("recurrenceStartDate");
				startDateTime = createDateTime(year(startDate), month(startDate), day(startDate), 0, 0, 0);
				duration = evaluate(24*60*60-1);
			} else {
				startDate = arguments.event.getArg("recurrenceStartDate");
				startDateTime = createDateTime(year(startDate), month(startDate), day(startDate), arguments.event.getArg("recurrenceStartTime_t") * 12 + arguments.event.getArg("recurrenceStartTime_h") mod 12, arguments.event.getArg("recurrenceStartTime_m"), 0);
				duration = arguments.event.getArg("duration_h") * 3600 + arguments.event.getArg("duration_m") * 60;
			}
			if(not compareNoCase(recurType,"n") eq 0) {
				recurrenceEndDate = arguments.event.getArg("recurrenceEndDate");
				series.setRecurrenceEndDate(createDate(year(recurrenceEndDate), month(recurrenceEndDate), day(recurrenceEndDate)));
			}
			if(not compareNoCase(recurType,"n") eq 0) {
				series.setRecurrence(true);
			}
			series.setRecurrenceRule(recurRule);
			series.setAllDay(arguments.event.isArgDefined("allDay"));
			series.setRecurrenceStartDate(startDateTime);
			series.setDuration(duration);
			if(len(categoryId) gt 0) {
				series.setCategory(variables.categoryGateway.read(categoryId));
			}
			
			// Determine the occurrences for the event series
			dates = series.generateInstanceDates(series.getRecurrenceStartDate(), series.getRecurrenceEndDate());
			eventItem = createObject("component","calendar.models.event.event");
			
			// Transfer all of the eventSeries attributes to the event
			eventTO = eventItem.getEventTO();
			eventSeriesTO = series.getEventSeriesTO();
			for(key in eventSeriesTO) {
				eventTO[key] = eventSeriesTO[key];
			}
			eventItem.setEventFromTO(eventTO);
			
			// Set the series ID and create the individual events for each occurrence
			variables.eventSeriesGateway.create(eventSeries=series);
			eventItem.setSeriesId(series.getSeriesId());
			for(i=1; i lte arrayLen(dates); i=i+1) {
				eventItem.setEventId(createUuid());
				eventItem.setStartDateTime(dates[i]);
				arguments.event.setArg("eventItem", eventItem);
				createEvent(arguments.event);
			}
			
			// Finally, adjust for the user's timezone.  We need to do this last to ensure
			// that the event instances are calculated properly.
			series.setRecurrenceStartDate(variables.timezoneLibrary.toUtc(series.getRecurrenceStartDate(), variables.sessionFacade.getUser().getTimezone()));
			if(isDate(series.getRecurrenceEndDate())) {
				series.setRecurrenceEndDate(variables.timezoneLibrary.toUtc(series.getRecurrenceEndDate(), variables.sessionFacade.getUser().getTimezone()));
			}
			variables.eventSeriesGateway.update(eventSeries=series);
			variables.calendarGateway.addEventSeries(calendarId=arguments.event.getArg("calendarId"), seriesId=series.getSeriesId(), status=series.getStatus());
		</cfscript>
	</cffunction>

	<cffunction name="createGroup" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.groupGateway.create(group=arguments.event.getArg("group"));
		</cfscript>
	</cffunction>

	<cffunction name="createHoliday" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var holiday = arguments.event.getArg("holiday");
			var recurRule = lCase(arguments.event.getArg("recurType"));
			switch(lCase(recurType)) {
				case("n"): 
					recurRule = recurRule & "_" & arguments.event.getArg("recurNYear") & "_" & arguments.event.getArg("recurNMonth") & "_" & arguments.event.getArg("recurNDay");
					break;
				case("d"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurDMonth") & "_" & arguments.event.getArg("recurDDay");
					break;
				case("o"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurOOffset") & "_" & arguments.event.getArg("recurODow") & "_" & arguments.event.getArg("recurOMonth");
					break;
				case("a"):
					recurRule = recurRule & "_" & Trim(arguments.event.getArg("recurAAlgorithm"));
					break;
			}
			holiday.setGlobal(yesNoFormat(arguments.event.getArg("global")));
			holiday.setRecurrenceRule(recurRule);
			variables.holidayGateway.create(holiday=holiday);
			variables.calendarGateway.addHoliday(calendarId=arguments.event.getArg("calendarId"), holidayId=holiday.getHolidayId());
		</cfscript>
	</cffunction>

	<cffunction name="createEventReminder" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			if (arguments.event.getArg("sendReminder") eq 0) {
				reminder = getEventReminder(arguments.event);
				variables.eventGateway.removeReminder(eventId=arguments.event.getArg("eventId"),reminderId=reminder.getReminderId());
				variables.reminderGateway.delete(reminder.getReminderId());
			} else {
				reminder = arguments.event.getArg("reminder");
				reminder.setUser(variables.sessionFacade.getUser());
				
				methods = structNew();
				if (arguments.event.isArgDefined("emailReminderCheck"))  { methods["email"] = arguments.event.getArg("emailReminderText"); }
				if (arguments.event.isArgDefined("mobileReminderCheck")) { methods["mobile"] = arguments.event.getArg("mobileReminderText"); }
				reminder.setMethods(methods);
	
				// If there is an existing reminder for this event/user, then just update
				// the reminder.  Otherwise, create a new reminder.
				existingReminder = getEventReminder(arguments.event);
				if(compareNoCase(existingReminder.getUser().getUserId(),reminder.getUser().getUserId()) eq 0) {
					reminder.setReminderId(existingReminder.getReminderId());
					variables.reminderGateway.update(reminder=reminder);
				} else {
					variables.reminderGateway.create(reminder=reminder);
					variables.eventGateway.addReminder(eventId=arguments.event.getArg("eventId"),reminderId=reminder.getReminderId());
				}
			}
		</cfscript>
	</cffunction>

	<cffunction name="createEventSeriesReminder" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			if (arguments.event.getArg("sendReminder") eq 0) {
				reminder = getEventSeriesReminder(arguments.event);
				variables.eventSeriesGateway.removeReminder(seriesId=arguments.event.getArg("seriesId"),reminderId=reminder.getReminderId());
				variables.reminderGateway.delete(reminder.getReminderId());
			} else {
				reminder = arguments.event.getArg("reminder");
				reminder.setUser(variables.sessionFacade.getUser());
				
				methods = structNew();
				if (arguments.event.isArgDefined("emailReminderCheck"))  { methods["email"] = arguments.event.getArg("emailReminderText"); }
				if (arguments.event.isArgDefined("mobileReminderCheck")) { methods["mobile"] = arguments.event.getArg("mobileReminderText"); }
				reminder.setMethods(methods);
	
				// If there is an existing reminder for this event/user, then just update
				// the reminder.  Otherwise, create a new reminder.
				existingReminder = getEventSeriesReminder(arguments.event);
				if(compareNoCase(existingReminder.getUser().getUserId(),reminder.getUser().getUserId()) eq 0) {
					reminder.setReminderId(existingReminder.getReminderId());
					variables.reminderGateway.update(reminder=reminder);
				} else {
					variables.reminderGateway.create(reminder=reminder);
					variables.eventSeriesGateway.addReminder(seriesId=arguments.event.getArg("seriesId"),reminderId=reminder.getReminderId());
				}
			}
		</cfscript>
	</cffunction>

	<cffunction name="createScheme" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			scheme = arguments.event.getArg("scheme");
			scheme.setFilePath("stylesheets/schemes/" & scheme.getSchemeId() & ".css");
			scheme.setGlobal(arguments.event.getArg("global"));
			variables.schemeGateway.create(scheme=scheme);
			variables.calendarGateway.addScheme(calendarId=arguments.event.getArg("calendarId"), schemeId=scheme.getSchemeId());
		</cfscript>
	</cffunction>

	<cffunction name="createUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.userGateway.create(user=arguments.event.getArg("user"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteCalendar" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: Update with the proper code
			si = variables.searchIndexGateway.getSearchIndexByCalendar(calendarId=arguments.event.getArg("calendarId"));
			variables.searchIndexGateway.delete(si.getSearchIndexId());
			variables.calendarGateway.delete(id=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteCategory" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: Update with the proper code
			variables.categoryGateway.delete(id=arguments.event.getArg("categoryId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteConfig" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfswitch expression="#lCase(argument.objectType)#">
			<cfcase value="calendar">
				<cfset variables.calendarGateway.deleteConfig(calendarId=arguments.event.getArg("objectValue"),config=arguments.event.getArg("configType")) />
			</cfcase>
		</cfswitch>
	</cffunction>

	<cffunction name="deleteEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.eventGateway.delete(id=arguments.event.getArg("eventId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteEventSeries" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			q_events = variables.eventSeriesGateway.getSeriesEvents(seriesId=arguments.event.getArg("seriesId"));
		</cfscript>
		<cfloop query="q_events">
			<cfscript>
				variables.eventGateway.delete(id=q_events.eventId);
			</cfscript>
		</cfloop>
		<cfscript>
			variables.eventSeriesGateway.delete(id=arguments.event.getArg("seriesId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteGroup" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.groupGateway.delete(arguments.event.getArg("groupId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteHoliday" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: Update with the proper code
			variables.holidayGateway.delete(id=arguments.event.getArg("holidayId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteReminder" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: Update with the proper code
			//variables.reminderGateway.delete(id=arguments.event.getArg("reminderId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteScheme" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: Update with the proper code
			variables.schemeGateway.delete(id=arguments.event.getArg("schemeId"));
		</cfscript>
	</cffunction>

	<cffunction name="deleteUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.userGateway.delete(arguments.event.getArg("userId"));
		</cfscript>
	</cffunction>

	<cffunction name="getApplication" access="public" returntype="calendar.models.application.application" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			applications = variables.applicationGateway.getApplications();
			return variables.applicationGateway.read(applications.applicationId);
		</cfscript>
	</cffunction>

	<cffunction name="getApprovedCalendars" access="public" returntype="query" output="false">
		<cfscript>
			// Query the calendars
			return variables.calendarGateway.getCalendars("approved");
		</cfscript>
	</cffunction>

	<cffunction name="getCalendar" access="public" returntype="calendar.models.calendar.calendar" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// Get the calendar
			return variables.calendarGateway.read(arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarCategories" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query the categories. --->
		<cfscript>
			return variables.calendarGateway.getCategories(calendarId=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarDefaultScheme" access="public" returntype="calendar.models.scheme.scheme" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// If no default scheme is specified, then attempt to load the default scheme.
			// If this fails, then use a blank stylesheet.
			try {
				scheme = variables.calendarGateway.read(arguments.event.getArg("calendarId")).getScheme();
			} catch (any e) {
				scheme = variables.schemeGateway.read("2AE73F9F-F0E8-47EA-81242461228343B2");
			}
			return scheme;
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarDisplayedHolidays" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query the holidays. --->
		<cfset startDate = arguments.event.getArg("startDate") />
		<cfif not isDate(startDate)>
			<cfset startDate = now() />
		</cfif>
		<cfset q_holidays = variables.calendarGateway.getHolidays(calendarId=arguments.event.getArg("calendarId")) />
		<cfset holidays = queryNew("holidayId,title,startDateTime") />
		<cfloop query="q_holidays">
			<cfset queryAddRow(holidays) />
			<cfset querySetCell(holidays, "holidayId", q_holidays.holidayId) />
			<cfset querySetCell(holidays, "title", q_holidays.title) />
			<cfset querySetCell(holidays, "startDateTime", variables.holidayGateway.read(q_holidays.holidayId).getInstanceByYear(year(startDate))) />
		</cfloop>
		<cfreturn holidays />
	</cffunction>

	<cffunction name="getCalendarEvents" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query all the events associated with a calendar. --->
		<cfscript>
			// CODE: We need to change how we're evaluating filter information.  We need better user input checking
			if(arguments.event.isArgDefined("filter") and len(arguments.event.getArg("filter")) gt 0) {
				categories = right(arguments.event.getArg("filter"),len(arguments.event.getArg("filter"))-len("categories:"));
			} else {
				categories = "";
			}
			if(variables.sessionFacade.hasUser()) {
				timezone = variables.sessionFacade.getUser().getTimezone();
			} else {
				timezone = getServerTimezone();
			}
			if(len(timezone) eq 0) {
				timezone = "085"; // GMT
			}
			return variables.calendarGateway.getEvents(calendarId=arguments.event.getArg("calendarId"),startDate=variables.timezoneLibrary.toUtc(arguments.event.getArg("startDate"),timezone),endDate=variables.timezoneLibrary.toUtc(arguments.event.getArg("endDate"),timezone),categories=categories);
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarEventSeries" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query all the events associated with a calendar. --->
		<cfscript>
			startDate = arguments.event.getArg("startDate");
			endDate = arguments.event.getArg("endDate");
			if (not isDate(startDate)) { startDate = createDate(1970,1,1); }
			if (not isDate(endDate)) { endDate = createDate(2039,1,1); }
			return variables.calendarGateway.getEventSeries(calendarId=arguments.event.getArg("calendarId"),startDate=variables.timezoneLibrary.toUtc(startDate,variables.sessionFacade.getUser().getTimezone()),endDate=variables.timezoneLibrary.toUtc(endDate,variables.sessionFacade.getUser().getTimezone()),categories=arguments.event.getArg("categories"));
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarFooter" access="public" returntype="string" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: I'm taking a big performance hit here, so I may want to change this implementation
//			var calendar = variables.calendarController.getCalendar(calendarId=arguments.event.getArg("calendarId"));
//			return calendar.getFooter();
			return "";
		</cfscript>
	</cffunction>
	
	<cffunction name="getCalendarHeader" access="public" returntype="string" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			// CODE: I'm taking a big performance hit here, so I may want to change this implementation
//			var calendar = variables.calendarController.getCalendar(calendarId=arguments.event.getArg("calendarId"));
//			return calendar.getHeader();
			return "";
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarHolidays" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query the holidays. --->
		<cfscript>
			return variables.calendarGateway.getHolidays(calendarId=arguments.event.getArg("calendarId"),global=false);
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarOptions" access="public" returntype="struct" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.calendarGateway.read(arguments.event.getArg("calendarId")).getOptions();
		</cfscript>
	</cffunction>
			
	<cffunction name="getCalendarReminders" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query the reminders. --->
		<cfscript>
			return variables.calendarGateway.getReminders(calendarId=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarView" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var display = arguments.event.getArg("displayType");
			var view = arguments.event.getArg("viewType");
			var format = arguments.event.getArg("format");

			// Determine the appropriate calendar view to use
			if(not listFindNoCase("standard,embed,http",display) gt 0) {	display = "standard";	}	
			if(not listFindNoCase("calendar,list,print",format) gt 0) { format = "calendar"; }
			if(not listFindNoCase("day,week,month,year",view) gt 0) { view = "month"; }
			newEvent = "calendar.view." & format & "." & view & "." & display;
			
			// Set the dates for the view
			if(arguments.event.isArgDefined("calendarDate")) {
				calendarDate = arguments.event.getArg("calendarDate");
			} else if(arguments.event.isArgDefined("calendarDate_y") and arguments.event.isArgDefined("calendarDate_m") and arguments.event.isArgDefined("calendarDate_d")) {
				calendarDate = createDate(val(arguments.event.getArg("calendarDate_y")),val(arguments.event.getArg("calendarDate_m")),val(arguments.event.getArg("calendarDate_d")));
			} else {
				calendarDate = now();
			}
			if(not isDate(calendarDate)) { calendarDate = now(); }
			
			switch(lcase(view)) {
				case("day"): 
					startDate = createDate(year(calendarDate), month(calendarDate), day(calendarDate));
					endDate = dateAdd("d", 1, createDate(year(calendarDate), month(calendarDate), day(calendarDate)));
					break;
				case("week"):
					startDate = dateAdd("d", -dayOfWeek(calendarDate)-1, createDate(year(calendarDate), month(calendarDate), day(calendarDate)));
					endDate = dateAdd("d", 8-dayOfWeek(calendarDate), createDate(year(calendarDate), month(calendarDate), day(calendarDate)));
					break;
				case("month"):
					startDate = createDate(year(calendarDate), month(calendarDate), 1);
					endDate = dateAdd("m", 1, startDate);
					break;
				case("year"):
					startDate = createDate(year(calendarDate), 1, 1);
					endDate = dateAdd("yyyy", 1, startDate);
					break;
			}			

			newEventArgs = arguments.event.getArgs();
			newEventArgs["calendarDate"] = calendarDate;
			newEventArgs["startDate"] = startDate;
			newEventArgs["endDate"] = endDate;
			announceEvent(newEvent,arguments.event.getArgs());
		</cfscript>
	</cffunction>

	<cffunction name="getCalendars" access="public" returntype="query" output="false">
		<cfscript>
			// Query the calendars
			return variables.calendarGateway.getCalendars();
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarSchemes" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query the schemes. --->
		<cfscript>
			return variables.calendarGateway.getSchemes(calendarId=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarSearchIndex" access="public" returntype="calendar.models.searchIndex.searchIndex" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.searchIndexGateway.getSearchIndexByCalendar(calendarId=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="getCalendarUnapprovedEventSeries" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---// Query the unapproved events. --->
		<cfscript>
			return variables.calendarGateway.getEventSeries(calendarId=arguments.event.getArg("calendarId"),status="pending",all=yesNoFormat(arguments.event.getArg("all")),startDate=createDate(1970,1,1),endDate=createDate(2069,12,31));
		</cfscript>
	</cffunction>

	<cffunction name="getCategory" access="public" returntype="calendar.models.category.category" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.categoryGateway.read(arguments.event.getArg("categoryId"));
		</cfscript>
	</cffunction>

	<cffunction name="getConfig" access="public" returntype="string" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfswitch expression="#lCase(argument.objectType)#">
			<cfcase value="calendar">
				<cfset configValue = variables.calendarGateway.getConfig(calendarId=arguments.event.getArg("objectValue"),config=arguments.event.getArg("configType")) />
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="CalendarController: config value not set">
			</cfdefaultcase>
		</cfswitch>
		<cfreturn trim(configValue) />
	</cffunction>

	<cffunction name="getDebugConfiguration" access="public" returntype="struct" output="false">
		<cfscript>
			var debugConfig = structNew();
			debugConfig.enabled = variables.applicationGateway.getConfiguration(configuration="application_debug_enabled");
			debugConfig.filepath = variables.applicationGateway.getConfiguration(configuration="application_debug_file");
			return debugConfig;
		</cfscript>
	</cffunction>

	<cffunction name="getEvent" access="public" returntype="calendar.models.event.event" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			eventItem = variables.eventGateway.read(arguments.event.getArg("eventId"));
			arguments.event.setArg("seriesId", eventItem.getSeriesId());
			return eventItem;
		</cfscript>
	</cffunction>

	<cffunction name="getEventReminder" access="public" returntype="calendar.models.reminder.reminder" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			try {
				return variables.reminderGateway.getEventReminder(eventId=arguments.event.getArg("eventId"),userId=variables.sessionFacade.getUser().getUserId());
			} catch ("REMINDER.MISSING" e) {
				return createobject('component','calendar.models.reminder.reminder');
			}
		</cfscript>
	</cffunction>

	<cffunction name="getEventSeriesReminder" access="public" returntype="calendar.models.reminder.reminder" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			try {
				return variables.reminderGateway.getEventSeriesReminder(seriesId=arguments.event.getArg("seriesId"),userId=variables.sessionFacade.getUser().getUserId());
			} catch ("REMINDER.MISSING" e) {
				return createobject('component','calendar.models.reminder.reminder');
			}
		</cfscript>
	</cffunction>

	<cffunction name="getEventSeries" access="public" returntype="calendar.models.eventSeries.eventSeries" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.eventSeriesGateway.read(arguments.event.getArg("seriesId"));
		</cfscript>
	</cffunction>

	<cffunction name="getEventStatus" access="public" returntype="numeric" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.eventGateway.getStatus(eventId=arguments.event.getArg("eventId"),calendarId=arguments.event.getArg("calendar"));
		</cfscript>
	</cffunction>

	<cffunction name="getEvents" access="public" returntype="query" output="false">
		<cfscript>
			return variables.eventGateway.getEvents();
		</cfscript>
	</cffunction>

	<cffunction name="getGlobalHolidays" access="public" returntype="query" output="false">
		<cfscript>
			return variables.holidayGateway.getHolidays(global=true);
		</cfscript>
	</cffunction>

	<cffunction name="getGroup" access="public" returntype="calendar.models.group.group" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.groupGateway.read(arguments.event.getArg("groupId"));
		</cfscript>
	</cffunction>

	<cffunction name="getGroups" access="public" returntype="query" output="false">
		<cfscript>
			return variables.groupGateway.getGroups();
		</cfscript>
	</cffunction>

	<cffunction name="getHoliday" access="public" returntype="calendar.models.holiday.holiday" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.holidayGateway.read(arguments.event.getArg("holidayId"));
		</cfscript>
	</cffunction>

	<cffunction name="getHolidays" access="public" returntype="query" output="false">
		<cfscript>
			return variables.holidayGateway.getHolidays();
		</cfscript>
	</cffunction>

	<cffunction name="getICalendarFile" access="public" returntype="string" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var eventItem = variables.eventGateway.read(arguments.event.getArg("eventId"));
			return eventItem.convert(format="icalendar");
		</cfscript>
	</cffunction>

	<cffunction name="getLanguage" access="public" returntype="string" output="false">
		<cfscript>
			return variables.applicationGateway.getConfiguration(configuration="application_language_locale");
		</cfscript>
	</cffunction>

	<cffunction name="getMailConfiguration" access="public" returntype="struct" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var mailConfig = structNew();
			mailConfig.body = variables.calendarGateway.getConfiguration(calendarId=arguments.event.getArg("calendarId"),configuration="#arguments.event.getArg('configuration')#_body");
			mailConfig.subject = variables.calendarGateway.getConfiguration(calendarId=arguments.event.getArg("calendarId"),configuration="#arguments.event.getArg('configuration')#_subject");
			return mailConfig;
		</cfscript>
	</cffunction>

	<cffunction name="getMailServer" access="public" returntype="calendar.models.mailServer.mailServer" output="false">
		<cfscript>
			return variables.mailServerGateway.getMailserver();
		</cfscript>
	</cffunction>

	<cffunction name="getPrivileges" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.calendarGateway.getPrivileges(calendarId=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="getReminder" access="public" returntype="calendar.models.reminder.reminder" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.reminderGateway.read(arguments.event.getArg("reminderId"));
		</cfscript>
	</cffunction>
	
	<cffunction name="getScheme" access="public" returntype="calendar.models.scheme.scheme" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.schemeGateway.read(arguments.event.getArg("schemeId"));
		</cfscript>
	</cffunction>

	<cffunction name="getSchemes" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			if (arguments.event.isArgDefined("calendarId")) {
				return variables.schemeGateway.getSchemes(all=true);
			} else {
				return variables.schemeGateway.getSchemes(global=true);
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getSearchResults" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			s = arguments.event.getArg("search");
			c = variables.calendarGateway.read(arguments.event.getArg("calendarId"));
			si = variables.searchIndexGateway.getSearchIndexByCalendar(calendarId=c.getCalendarId());
			return variables.searchGateway.search(criteria=s,calendar=c,searchIndex=si);
		</cfscript>
	</cffunction>

	<cffunction name="getSearchIndex" access="public" returntype="calendar.models.searchIndex.searchIndex" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.searchIndexGateway.read(arguments.event.getArg("searchIndexId"));
		</cfscript>
	</cffunction>

	<cffunction name="getSearchIndexes" access="public" returntype="query" output="false">
		<cfscript>
			return variables.searchIndexGateway.getSearchIndexes();
		</cfscript>
	</cffunction>

	<cffunction name="getServerTimeZone" access="public" returntype="string" output="false">
		<cfscript>
			return variables.applicationGateway.getConfiguration(configuration="application_timezone");
		</cfscript>
	</cffunction>

	<cffunction name="getSessionUser" access="public" returntype="calendar.models.user.user" output="false">
		<cfscript>
			return variables.userGateway.getUserByUsername(username=variables.sessionFacade.getUser().getUsername());
		</cfscript>
	</cffunction>

	<cffunction name="getSupportedLanguages" access="public" returntype="struct" output="false">
		<cfscript>
			return variables.applicationGateway.getLanguages();
		</cfscript>
	</cffunction>

	<cffunction name="getUser" access="public" returntype="calendar.models.user.user" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			if(arguments.event.isArgDefined("username")) {
				return variables.userGateway.getUserByUsername(variables.sessionFacade.getUser().getUsername());
			} else {
				return variables.userGateway.read(arguments.event.getArg("userId"));
			}
		</cfscript>
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfscript>
			return variables.userGateway.getUsers();
		</cfscript>
	</cffunction>

	<cffunction name="isLoginValid" access="private" returntype="boolean" output="false">
		<cfargument name="username" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />

		<cfscript>
			return variables.userGateway.authenticateUser(username=arguments.username,password=arguments.password);
		</cfscript>
	</cffunction>

	<cffunction name="loginUser" access="public" returntype="boolean" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var username = arguments.event.getArg("username");
			var password = arguments.event.getArg("password");
			var cfcookie = arguments.event.isArgDefined("user_cookie");
			var invalidMessage = "login failed. please try again";
			//AUTHENTICATE USER INFO 
			//ANNOUNCE SUCCESS/FAILURE EVENT 
			validLogin = isLoginValid(username, password);
			if(validLogin eq true) {
				user = variables.userGateway.getUserByUsername(username);
				variables.sessionFacade.openSession(user, structKeyList(user.getPermissions()));
			}
		</cfscript>
		<cfif validLogin eq true and cfcookie eq true>
			<cfcookie expires="#dateAdd('d',+30,now())#" name="userlogin" value="#user.getUsername()#" />
			<cfcookie expires="#dateAdd('d',+30,now())#" name="useruuid" value="#user.getUserId()#" />
		</cfif>
		<cfscript>
			if(validLogin eq true) {
				announceEvent("loginSucceeded");
			} else {
				newEventArgs = arguments.event.getArgs();
				newEventArgs[this.INVALID_MESSAGE_PARAM] = invalidMessage;
				announceEvent("loginFailed", newEventArgs);
			}
		</cfscript>
		<cfreturn true />
	</cffunction>

	<cffunction name="logoutUser" access="public" returntype="void" output="false">
		<cfscript>
			structDelete(cookie,"userlogin");
			structDelete(cookie,"useruuid");
			variables.sessionFacade.closeSession();
		</cfscript>
	</cffunction>

	<cffunction name="manageSearchIndex" access="public" returntype="numeric" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var searchIndex = variables.searchIndexGateway.read(arguments.event.getArg("searchIndexId"));
			start = getTickCount();
			switch(lCase(arguments.event.getArg("action"))) {
				case("refresh"):
					searchData = variables.searchIndexGateway.getSearchData();
					searchIndex.refresh(searchData=searchData);
					break;
				case("update"):
					searchData = variables.searchIndexGateway.getSearchData();
					searchIndex.update(searchData=searchData);
					break;
				case("optimize"):
					searchIndex.optimize();
					break;
			}
			end = getTickCount();
			return evaluate(end-start);
		</cfscript>
	</cffunction>

	<cffunction name="removeCalendarEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.calendarGateway.removeEvent(calendarId=arguments.event.getArg("calendarId"),eventId=arguments.event.getArg("eventId"));
		</cfscript>
	</cffunction>
	
	<cffunction name="removeCalendarHoliday" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			return variables.calendarGateway.removeHoliday(calendarId=arguments.event.getArg("calendarId"),holidayId=arguments.event.getArg("holidayId"));
		</cfscript>
	</cffunction>

	<cffunction name="updateCalendar" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript> 
			var calendar = variables.calendarGateway.read(arguments.event.getArg("calendarId"));
			calendar.setTitle(arguments.event.getArg("title"));
			calendar.setDescription(arguments.event.getArg("description"));
			calendar.setStatus(arguments.event.getArg("status"));
			variables.calendarGateway.update(calendar=calendar);
			variables.calendarGateway.setConfiguration(calendarId=arguments.event.getArg("calendarId"),configuration="calendar_default_group",value=trim(arguments.event.getArg("defaultGroup")));
		</cfscript>
	</cffunction>
	
	<cffunction name="updateCalendarOptions" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			scheme = variables.schemeGateway.read(arguments.event.getArg("schemeId"));
			calendar = arguments.event.getArg("calendar");
			calendar.setScheme(scheme);
			variables.calendarGateway.update(calendar=calendar);
			variables.calendarGateway.setConfiguration(calendarId=calendar.getCalendarId(),configuration="calendar_week_start",value=int(arguments.event.getArg("startWeek")));
			variables.calendarGateway.setConfiguration(calendarId=calendar.getCalendarId(),configuration="calendar_week_end",value=int(arguments.event.getArg("startWeek")+6));
			variables.calendarGateway.setConfiguration(calendarId=calendar.getCalendarId(),configuration="calendar_search_enabled",value=int(arguments.event.isArgDefined("searchEnabled")));
			variables.calendarGateway.setConfiguration(calendarId=calendar.getCalendarId(),configuration="calendar_vcalendar_enabled",value=int(arguments.event.isArgDefined("calendarExportEnabled")));
			variables.calendarGateway.setConfiguration(calendarId=calendar.getCalendarId(),configuration="policy_userapprovalrequired",value=int(arguments.event.isArgDefined("accessApprovalRequired")));
			//variables.calendarGateway.setConfiguration(calendarId=calendar.getCalendarId(),configuration="calendar_display_workhours",value=int(arguments.event.getArg("workHoursDisplayed")));
			variables.calendarGateway.setConfiguration(calendarId=calendarId,configuration="calendar_access_public_permissions",value=trim(arguments.event.getArg("publicPermissions")));
		</cfscript>
	</cffunction>

	<cffunction name="updateCategory" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.categoryGateway.update(category=arguments.event.getArg("category"));
		</cfscript>
	</cffunction>

	<cffunction name="updateDebugConfiguration" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.applicationGateway.setConfiguration(configuration="application_debug_enabled",value=arguments.event.getArg("enabled"));
			variables.applicationGateway.setConfiguration(configuration="application_debug_file",value=arguments.event.getArg("filepath"));
		</cfscript>
	</cffunction>

	<cffunction name="updateDisplayedCalendarHolidays" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cftransaction>
			<cfscript>
				// Delete the current holidays
				variables.calendarGateway.removeHolidays(calendarId=arguments.event.getArg("calendarId"));
				// Loop through accepted holidays list and add them to calendar.
				for(i=1; i lte listLen(arguments.event.getArg("acceptedHolidays")); i=i+1) {
					variables.calendarGateway.addHoliday(calendarId=arguments.event.getArg("calendarId"), holidayId=listGetAt(arguments.event.getArg("acceptedHolidays"),i));
				}
			</cfscript>
		</cftransaction>
	</cffunction>

	<cffunction name="updateEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var eventItem = arguments.event.getArg("eventItem");
			var categoryId = arguments.event.getArg("categoryId");
			var timezone = iif(variables.sessionFacade.hasUser(), variables.sessionFacade.getUser().getTimezone(), getServerTimezone());
			if(arguments.event.isArgDefined("allDay")) {
				startDate = arguments.event.getArg("startDate");
				startDateTime = createDateTime(year(startDate), month(startDate), day(startDate), 0, 0, 0);
				duration = evaluate(24*60*60-1);
			} else {
				startDate = arguments.event.getArg("startDate");
				startDateTime = createDateTime(year(startDate), month(startDate), day(startDate), arguments.event.getArg("startDateTime_t") * 12 + arguments.event.getArg("startDateTime_h") mod 12, arguments.event.getArg("startDateTime_m"), 0);
				duration = arguments.event.getArg("duration_h") * 3600 + arguments.event.getArg("duration_m") * 60;
			}
			eventItem.setAllDay(arguments.event.isArgDefined("allDay"));
			eventItem.setStartDateTime(variables.timezoneLibrary.toUtc(startDateTime, timezone));
			eventItem.setDuration(duration);
			if(len(categoryId) gt 0) {
				eventItem.setCategory(variables.categoryGateway.read(categoryId));
			}
			variables.eventGateway.update(event=eventItem);
		</cfscript>
	</cffunction>

	<cffunction name="updateEventSeries" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfscript>
			var series = arguments.event.getArg("eventSeries");
			var categoryId = arguments.event.getArg("categoryId");
			var timezone = iif(variables.sessionFacade.hasUser(), variables.sessionFacade.getUser().getTimezone(), getServerTimezone());
			var recurType = arguments.event.getArg("recurType");
			var recurRule = lCase(recurType);
			switch(lCase(recurType)) {
				case("c"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurCFreq") & "_" & lCase(arguments.event.getArg("recurCPeriod"));
					break;
				case("w"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurWFreq") & "_" & lCase(arguments.event.getArg("recurWDays"));
					break;
				case("m"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurMFreq") & "_" & arguments.event.getArg("recurMOffset") & "_" & arguments.event.getArg("recurMDay");
					break;
			}
			if(arguments.event.isArgDefined("allDay")) {
				recurrenceStartDate = arguments.event.getArg("recurrenceStartDate");
				recurrenceStartDateTime = createDateTime(year(recurrenceStartDate), month(recurrenceStartDate), day(recurrenceStartDate), 0, 0, 0);
				duration = evaluate(24*60*60-1);
			} else {
				recurrenceStartDate = arguments.event.getArg("recurrenceStartDate");
				recurrenceStartDateTime = createDateTime(year(recurrenceStartDate), month(recurrenceStartDate), day(recurrenceStartDate), arguments.event.getArg("recurrenceStartTime_t") * 12 + arguments.event.getArg("recurrenceStartTime_h") mod 12, arguments.event.getArg("recurrenceStartTime_m"), 0);
				duration = arguments.event.getArg("duration_h") * 3600 + arguments.event.getArg("duration_m") * 60;
			}
			if(not compareNoCase(recurType,"n") eq 0) {
				recurrenceEndDate = arguments.event.getArg("recurrenceEndDate");
				series.setRecurrenceEndDate(createDate(year(recurrenceEndDate), month(recurrenceEndDate), day(recurrenceEndDate)));
			}
			if(not compareNoCase(recurType,"n") eq 0) {
				series.setRecurrence(true);
			}
			series.setRecurrenceRule(recurRule);
			series.setAllDay(arguments.event.isArgDefined("allDay"));
			series.setRecurrenceStartDate(recurrenceStartDateTime);
			series.setDuration(duration);
			if(len(categoryId) gt 0) {
				series.setCategory(variables.categoryGateway.read(categoryId));
			}
			
			// Delete the existing event series occurrences
			variables.eventSeriesGateway.deleteSeriesEvents(seriesId=series.getSeriesId());

			// Determine the occurrences for the event series
			dates = series.generateInstanceDates(series.getRecurrenceStartDate(), series.getRecurrenceEndDate());
			eventItem = createObject("component","calendar.models.event.event");
			
			// Transfer all of the eventSeries attributes to the event
			eventTO = eventItem.getEventTO();
			eventSeriesTO = series.getEventSeriesTO();
			for(key in eventSeriesTO) {
				eventTO[key] = eventSeriesTO[key];
			}
			eventItem.setEventFromTO(eventTO);
			
			// Set the series ID and create the individual events for each occurrence
			eventItem.setSeriesId(series.getSeriesId());
			for(i=1; i lte arrayLen(dates); i=i+1) {
				eventItem.setEventId(createUuid());
				eventItem.setStartDateTime(dates[i]);
				arguments.event.setArg("eventItem", eventItem);
				createEvent(arguments.event);
			}
			
			// Finally, adjust for the user's timezone.  We need to do this last to ensure
			// that the event instances are calculated properly.
			series.setRecurrenceStartDate(variables.timezoneLibrary.toUtc(series.getRecurrenceStartDate(), timezone));
			if(isDate(series.getRecurrenceEndDate())) {
				series.setRecurrenceEndDate(variables.timezoneLibrary.toUtc(series.getRecurrenceEndDate(), timezone));
			}
			
			// Save the eventSeries
			variables.eventSeriesGateway.update(eventSeries=series);
		</cfscript>
	</cffunction>

	<cffunction name="updateEventStatus" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.eventGateway.setStatus(eventId=arguments.event.getArg("eventId"),calendarId=arguments.event.getArg("calendarId"),status=arguments.event.getArg("status"));
			// CODE: Need to implement the following method
			variables.searchIndexGateway.updateIndex(calendarId=arguments.event.getArg("calendarId"));
		</cfscript>
	</cffunction>

	<cffunction name="updateGroup" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.groupGateway.update(group=arguments.event.getArg("group"));
		</cfscript>
	</cffunction>
	
	<cffunction name="updateGroupPermissions" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.groupGateway.updatePermissions(groupId=arguments.event.getArg("groupId"),context=arguments.event.getArg("contextType"),contextId=arguments.event.getArg("contextId"),permissions=arguments.event.getArg("permissions"));
		</cfscript>
	</cffunction>

	<cffunction name="updateGroupMembers" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.groupGateway.updateMembers(groupId=arguments.event.getArg("groupId"),members=arguments.event.getArg("members"));
		</cfscript>
	</cffunction>

	<cffunction name="updateHoliday" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var holiday = arguments.event.getArg("holiday");
			var recurRule = lCase(arguments.event.getArg("recurType"));
			switch(lCase(recurType)) {
				case("n"): 
					recurRule = recurRule & "_" & arguments.event.getArg("recurNYear") & "_" & arguments.event.getArg("recurNMonth") & "_" & arguments.event.getArg("recurNDay");
					break;
				case("d"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurDMonth") & "_" & arguments.event.getArg("recurDDay");
					break;
				case("o"):
					recurRule = recurRule & "_" & arguments.event.getArg("recurOOffset") & "_" & arguments.event.getArg("recurODow") & "_" & arguments.event.getArg("recurOMonth");
					break;
				case("a"):
					recurRule = recurRule & "_" & Trim(arguments.event.getArg("recurAAlgorithm"));
					break;
			}
			holiday.setGlobal(yesNoFormat(arguments.event.getArg("global")));
			holiday.setRecurrenceRule(recurRule);
			variables.holidayGateway.update(holiday=holiday);
		</cfscript>
	</cffunction>

	<cffunction name="updateLanguage" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			initializeApplication(language=arguments.event.getArg("language"));
			variables.applicationGateway.setConfiguration(configuration="application_language_locale",value=arguments.event.getArg("language"));
		</cfscript>
	</cffunction>

	<cffunction name="updateMailConfiguration" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.calendarGateway.setConfiguration(calendarId=arguments.event.getArg("calendarId"),configuration="#arguments.event.getArg('configuration')#_body",value=arguments.event.getArg("body"));
			variables.calendarGateway.setConfiguration(calendarId=arguments.event.getArg("calendarId"),configuration="#arguments.event.getArg('configuration')#_subject",value=arguments.event.getArg("subject"));
		</cfscript>
	</cffunction>

	<cffunction name="updateMailServer" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.mailServerGateway.update(mailServer=arguments.event.getArg("mailServer"));
		</cfscript>
	</cffunction>
	
	<cffunction name="updateMessage" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.messageGateway.update(message=arguments.event.getArg("message"));
		</cfscript>
	</cffunction>
	
	<cffunction name="updateReminder" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.reminderGateway.update(reminder=arguments.event.getArg("reminder"));
		</cfscript>
	</cffunction>

	<cffunction name="updateScheme" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var scheme = arguments.event.getArg("scheme");
			scheme.setGlobal(arguments.event.getArg("global"));
			variables.schemeGateway.update(scheme=scheme);
		</cfscript>
	</cffunction>
	
	<cffunction name="updateSearchIndex" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.searchIndexGateway.update(searchIndex=arguments.event.getArg("searchIndex"));
		</cfscript>
	</cffunction>

	<cffunction name="updateServerTimeZone" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.applicationGateway.setConfiguration(configuration="application_timezone",value=arguments.event.getArg("timezone"));
		</cfscript>
	</cffunction>

	<cffunction name="updateSessionUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.sessionFacade.setUser(arguments.event.getArg("user"));
		</cfscript>
	</cffunction>

	<cffunction name="updateUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			if(arguments.event.isArgDefined("resetPassword") and yesNoFormat(arguments.event.getArg("resetPassword")) eq true) {
				variables.userGateway.update(user=arguments.event.getArg("user"),password=arguments.event.getArg("password"));				
			} else {
				variables.userGateway.update(user=arguments.event.getArg("user"),password='');
			}
		</cfscript>
	</cffunction>

	<cffunction name="updateUserPermissions" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			variables.userGateway.updatePermissions(userId=arguments.event.getArg("userId"),context=arguments.event.getArg("contextType"),contextId=arguments.event.getArg("contextId"),permissions=arguments.event.getArg("permissions"));
		</cfscript>
	</cffunction>

	<cffunction name="validateSession" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfscript>
			var invalidMessage = "Please login.";
			//AUTHENTICATE USER INFO 
			//ANNOUNCE SUCCESS/FAILURE EVENT 
		</cfscript>
		<cfif variables.sessionFacade.hasUser()>
			<cfscript>
				announceEvent("loginValid");			
			</cfscript>
		<cfelse>
			<!---// CODE: We need to change this exception to something that will be handled by
			the application and prompt the user for a login --->
			<cfthrow detail="#invalidMessage#" />
			<cfscript>
				newEventArgs = arguments.event.getArgs();
				newEventArgs[this.INVALID_MESSAGE_PARAM] = invalidMessage;
				announceEvent("loginInvalid", newEventArgs);			
			</cfscript>
		</cfif>
	</cffunction>

</cfcomponent>