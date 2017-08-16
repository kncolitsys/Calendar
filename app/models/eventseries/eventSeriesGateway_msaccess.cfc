<cfcomponent displayname="eventSeriesGateway_msaccess" extends="eventSeriesGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="eventSeries" type="eventSeries" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_categoryDsid" datasource="#variables.dsn#">	
				SELECT categoryDsid
				FROM categories
				WHERE categoryId = '#trim(eventSeries.getCategory().getCategoryId())#'
			</cfquery>
	
			<cfquery name="q_create_event" datasource="#variables.dsn#">
				INSERT INTO eventseries (
					seriesId, title, description,
					categoryDsid, eventUrl, location, 
					duration, allDay, recurrence, 
					recurrenceRule, recurrenceStartDate, recurrenceEndDate,
					contactFirstName, contactLastName,
					contactPhone, contactEmail, comments,
					approvedDate, approvedBy, 
					createDate, createBy,
					updateDate, updateBy
				) VALUES (
					'#trim(eventSeries.getSeriesId())#', '#trim(eventSeries.getTitle())#', '#trim(eventSeries.getDescription())#',
					#val(q_categoryDsid.categoryDsid)#, '#trim(eventSeries.getEventUrl())#', '#trim(eventSeries.getLocation())#',
					#val(eventSeries.getDuration())#, #int(eventSeries.getAllDay())#, #int(eventSeries.getRecurrence())#,
					'#trim(eventSeries.getRecurrenceRule())#', <cfif isDate(arguments.date)>#createOdbcDateTime(eventSeries.getRecurrenceStartDate())#<cfelse>NULL</cfif>, <cfif isDate(arguments.date)>#createOdbcDateTime(eventSeries.getRecurrenceEndDate())#<cfelse>NULL</cfif>,
					'#trim(eventSeries.getContactFirstName())#', '#trim(eventSeries.getContactLastName())#',
					'#trim(eventSeries.getContactPhone())#', '#trim(eventSeries.getContactEmail())#', '#trim(eventSeries.getComments())#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(eventSeries.getApprovedDate())#<cfelse>NULL</cfif>, '#trim(eventSeries.getApprovedBy())#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
				)
			</cfquery>
		</cftransaction>
	</cffunction>

	<cffunction name="read" access="public" returntype="eventSeries" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the event info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_series" datasource="#variables.dsn#">
			SELECT *
			FROM eventseries
			WHERE seriesId = '#trim(arguments.id)#'
		</cfquery>

		<cfif val(q_read_series.recordCount) gt 0>
			<cfquery name="q_categoryId" datasource="#variables.dsn#">
				SELECT categoryId
				FROM categories
				WHERE categoryDsid = (SELECT categoryDsid FROM eventSeries WHERE seriesId = '#trim(arguments.id)#')
			</cfquery>
			
			<cfscript>
				eventSeriesStruct = queryRowToStruct(q_read_series);
				if(q_categoryId.recordCount gt 0) {
					category = variables.factory.getCategoryGateway().read(id=q_categoryId.categoryId);
				} else {
					category = createObject("component","calendar.models.category.category");
				}
				eventSeries = createObject("component","eventSeries").init(argumentcollection=eventSeriesStruct,category=category);
				addCacheItem(eventSeries.getSeriesId(), eventSeries);
				return eventSeries;
			</cfscript>
		<cfelse>
			<cfthrow type="EVENTSERIES.MISSING" message="The requested event series does not exist" detail="Event Series ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="eventSeries" type="eventSeries" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_categoryDsid" datasource="#variables.dsn#">	
				SELECT categoryDsid
				FROM categories
				WHERE categoryId = '#trim(eventSeries.getCategory().getCategoryId())#'
			</cfquery>
	
			<cfquery name="q_update_event" datasource="#variables.dsn#">
				UPDATE eventseries
				SET
					title = '#trim(eventSeries.getTitle())#',
					description = '#trim(eventSeries.getDescription())#',
					categoryDsid = #val(q_categoryDsid.categoryDsid)#,
					eventUrl = '#trim(eventSeries.getEventUrl())#',
					duration = #val(eventSeries.getDuration())#,
					location = '#trim(eventSeries.getLocation())#',
					allDay = #int(eventSeries.getAllDay())#,
					recurrence = #int(eventSeries.getRecurrence())#,
					recurrenceRule = '#trim(eventSeries.getRecurrenceRule())#',
					recurrenceStartDate = <cfif isDate(eventSeries.getRecurrenceStartDate())>#createOdbcDateTime(eventSeries.getRecurrenceStartDate())#<cfelse>NULL</cfif>,
					recurrenceEndDate = <cfif isDate(eventSeries.getRecurrenceEndDate())>#createOdbcDateTime(eventSeries.getRecurrenceEndDate())#<cfelse>NULL</cfif>,
					contactFirstName = '#trim(eventSeries.getContactFirstName())#',
					contactLastName = '#trim(eventSeries.getContactLastName())#',
					contactPhone = '#trim(eventSeries.getContactPhone())#',
					contactEmail = '#trim(eventSeries.getContactEmail())#',
					comments = '#trim(eventSeries.getComments())#',
					approvedDate = <cfif isDate(eventSeries.getApprovedDate())>#createOdbcDateTime(eventSeries.getApprovedDate())#<cfelse>NULL</cfif>,
					approvedBy = '#trim(eventSeries.getApprovedBy())#',
					updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
					updateBy = '#trim(arguments.modifier)#'
				WHERE
					seriesId = '#trim(eventSeries.getSeriesId())#'
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(arguments.eventSeries.getSeriesId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_seriesDsid" datasource="#variables.dsn#">
			SELECT seriesDsid
			FROM eventseries
			WHERE seriesId = '#trim(arguments.id)#'
		</cfquery>

		<cftransaction>
			<cfquery name="q_delete_calendar_eventSeries" datasource="#variables.dsn#">
				DELETE FROM calendars_eventseries
				WHERE seriesDsid = #val(q_seriesDsid.seriesDsid)#
			</cfquery>

			<cfquery name="q_delete_eventSeries" datasource="#variables.dsn#">
				DELETE FROM eventseries
				WHERE seriesDsid = #val(q_seriesDsid.seriesDsid)#
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="addReminder" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfargument name="reminderId" type="string" required="true" />

		<cfquery name="q_seriesDsid" datasource="#variables.dsn#">
			SELECT seriesDsid
			FROM eventseries
			WHERE seriesId = '#trim(arguments.seriesId)#'
		</cfquery>

		<cfquery name="q_reminderDsid" datasource="#variables.dsn#">
			SELECT reminderDsid
			FROM reminders
			WHERE reminderId = '#trim(arguments.reminderId)#'
		</cfquery>

		<cfquery name="q_event_reminder" datasource="#variables.dsn#">
			SELECT seriesDsid, reminderDsid
			FROM eventseries_reminders
			WHERE seriesDsid = #val(q_seriesDsid.seriesDsid)#
			  AND reminderDsid = #val(q_reminderDsid.reminderDsid)#
		</cfquery>

		<cfif val(q_seriesDsid.recordCount) gt 0 and val(q_reminderDsid.recordCount) gt 0 and val(q_event_reminder.recordCount) eq 0>
			<cfquery name="q_insert_event_reminder" datasource="#variables.dsn#">
				INSERT INTO eventseries_reminders (seriesDsid, reminderDsid)
				VALUES (#val(q_seriesDsid.seriesDsid)#, #val(q_reminderDsid.reminderDsid)#)
			</cfquery>
		</cfif>
		<cfset removeCacheItem(arguments.reminderId) />
		<cfset removeCacheItem(arguments.seriesId) />
	</cffunction>

	<cffunction name="getStatus" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfargument name="calendarId" type="string" required="true" />

		<cfquery name="q_event_status" datasource="#variables.dsn#" maxrows="1">
			SELECT code
			FROM status
			WHERE statusDsid = (
				SELECT ce.status
				FROM events e INNER JOIN (
					events_calendars ce INNER JOIN calendars c ON ce.calendarDsid = c.calendarDsid
				) ON e.eventDsid = ce.eventDsid
				WHERE e.eventId = '#trim(arguments.eventId)#'
				  AND c.calendarId = '#trim(arguments.calendarId)#'
			)
		</cfquery>
		<cfreturn q_event_status.code />
	</cffunction>

	<cffunction name="setStatus" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfargument name="status" type="string" required="true" />

		<cftransaction>
			<cfquery name="q_statusDsid" datasource="#variables.dsn#" maxrows="1">			
				SELECT statusDsid
				FROM status
				WHERE code = '#trim(arguments.status)#'
			</cfquery>
			
			<cfquery name="q_update_status" datasource="#variables.dsn#">
				UPDATE eventseries
				SET status = #val(q_statusDsid.statusDsid)#
				WHERE seriesId = '#trim(arguments.seriesId)#'
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(arguments.seriesId) />
	</cffunction>

	<cffunction name="deleteSeriesEvents" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cftransaction>
			<cfquery name="q_seriesDsid" datasource="#variables.dsn#">
				SELECT seriesDsid
				FROM eventseries
				WHERE seriesId = '#trim(arguments.seriesId)#'
			</cfquery>
			
			<cfquery name="q_seriesEvents" datasource="#variables.dsn#">
				DELETE FROM events e
				WHERE seriesDsid = #val(q_seriesDsid.seriesDsid)#
			</cfquery>
		</cftransaction>
	</cffunction>

	<cffunction name="getEventSeries" access="public" returntype="query" output="false">
		<cfquery name="q_series" datasource="#variables.dsn#">
			SELECT *
			FROM eventseries
		</cfquery>
		<cfreturn q_series />
	</cffunction>

	<cffunction name="getEventSeriesByCalendar" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfquery name="q_eventsByCalendar" datasource="#variables.dsn#">
			SELECT *
			FROM eventseries s INNER JOIN (
				events e INNER JOIN (
					calendars_events ce INNER JOIN calendars c ON c.dsid = ce.calendarDsid
				) ON e.eventDsid = ce.eventDsid
			) ON s.seriesDsid = e.seriesDsid
			WHERE c.id = '#trim(arguments.calendarId)#'
		</cfquery>
		<cfreturn q_eventsByCalendar />
	</cffunction>

	<cffunction name="getSeriesEvents" access="public" returntype="query" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfquery name="q_seriesEvents" datasource="#variables.dsn#">
			SELECT e.*
			FROM events e INNER JOIN eventseries s ON e.seriesDsid = s.seriesDsid
			WHERE s.seriesId = '#trim(arguments.seriesId)#'
		</cfquery>
		<cfreturn q_seriesEvents />
	</cffunction>

	<cffunction name="removeReminder" access="public" returntype="void" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfargument name="reminderId" type="string" required="true" />

		<cfquery name="q_seriesDsid" datasource="#variables.dsn#">
			SELECT seriesDsid
			FROM eventseries
			WHERE seriesId = '#trim(arguments.seriesId)#'
		</cfquery>

		<cfquery name="q_reminderDsid" datasource="#variables.dsn#">
			SELECT reminderDsid
			FROM reminders
			WHERE reminderId = '#trim(arguments.reminderId)#'
		</cfquery>

		<cfquery name="q_delete_eventseries_reminder" datasource="#variables.dsn#">
			DELETE FROM eventseries_reminders
			WHERE seriesDsid = #val(q_seriesDsid.seriesDsid)#
			  AND reminderDsid = #val(q_reminderDsid.reminderDsid)#
		</cfquery>
		<cfset removeCacheItem(arguments.reminderId) />
		<cfset removeCacheItem(arguments.seriesId) />
	</cffunction>

</cfcomponent>