<cfcomponent displayname="eventGateway_msaccess" extends="eventGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="event" type="event" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_seriesDsid" datasource="#variables.dsn#">	
				SELECT seriesDsid
				FROM eventseries
				WHERE seriesId = '#trim(event.getSeriesId())#'
			</cfquery>
			
			<cfquery name="q_categoryDsid" datasource="#variables.dsn#">	
				SELECT categoryDsid
				FROM categories
				WHERE categoryId = '#trim(event.getCategory().getCategoryId())#'
			</cfquery>
	
			<cfquery name="q_create_event" datasource="#variables.dsn#">
				INSERT INTO events (
					eventId, title, description,
					categoryDsid, eventUrl, startDateTime,
					duration, location, allDay,
					seriesDsid, contactFirstName, contactLastName,
					contactPhone, contactEmail, comments,
					approvedDate, approvedBy, 
					createDate, createBy,
					updateDate, updateBy
				) VALUES (
					'#trim(event.getEventId())#', '#trim(event.getTitle())#', '#trim(event.getDescription())#',
					#val(q_categoryDsid.categoryDsid)#, '#trim(event.getEventUrl())#', <cfif isDate(arguments.date)>#createOdbcDateTime(event.getStartDateTime())#<cfelse>NULL</cfif>,
					#val(event.getDuration())#, '#trim(event.getLocation())#', #int(event.getAllDay())#,
					#val(q_seriesDsid.seriesDsid)#, '#trim(event.getContactFirstName())#', '#trim(event.getContactLastName())#',
					'#trim(event.getContactPhone())#', '#trim(event.getContactEmail())#', '#trim(event.getComments())#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(event.getApprovedDate())#<cfelse>NULL</cfif>, '#trim(event.getApprovedBy())#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
				)
			</cfquery>
		</cftransaction>
	</cffunction>

	<cffunction name="read" access="public" returntype="event" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the event info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_event" datasource="#variables.dsn#">
			SELECT *
			FROM events e
			WHERE eventId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_event.recordCount) gt 0>
			<cfquery name="q_categoryId" datasource="#variables.dsn#">
				SELECT categoryId
				FROM categories
				WHERE categoryDsid = (SELECT categoryDsid FROM events WHERE eventId = '#trim(arguments.id)#')
			</cfquery>

			<cfquery name="q_seriesId" datasource="#variables.dsn#">
				SELECT seriesId
				FROM eventseries
				WHERE seriesDsid = #val(q_read_event.seriesDsid)#
			</cfquery>

			<cfscript>
				eventStruct = queryRowToStruct(q_read_event);
				if(q_categoryId.recordCount gt 0) {
					category = variables.factory.getCategoryGateway().read(id=q_categoryId.categoryId);
				} else {
					category = createObject("component","calendar.models.category.category");
				}
				event = createObject("component","event").init(argumentcollection=eventStruct,seriesId=q_seriesId.seriesId,category=category);
				addCacheItem(event.getEventId(), event);
				return event;
			</cfscript>
		<cfelse>
			<cfthrow type="EVENT.MISSING" message="The requested event does not exist" detail="Event ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="event" type="event" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_seriesDsid" datasource="#variables.dsn#">	
				SELECT seriesDsid
				FROM eventseries
				WHERE seriesId = '#trim(event.getSeriesId())#'
			</cfquery>
			
			<cfquery name="q_categoryDsid" datasource="#variables.dsn#">	
				SELECT categoryDsid
				FROM categories
				WHERE categoryId = '#trim(event.getCategory().getCategoryId())#'
			</cfquery>
	
			<cfquery name="q_update_event" datasource="#variables.dsn#">
				UPDATE events
				SET
					title = '#trim(event.getTitle())#',
					description = '#trim(event.getDescription())#',
					categoryDsid = #val(q_categoryDsid.categoryDsid)#,
					eventUrl = '#trim(event.getEventUrl())#',
					startDateTime = <cfif isDate(event.getStartDateTime())>#createOdbcDateTime(event.getStartDateTime())#<cfelse>NULL</cfif>,
					duration = #val(event.getDuration())#,
					location = '#trim(event.getLocation())#',
					allDay = #int(event.getAllDay())#,
					seriesDsid = #val(q_seriesDsid.seriesDsid)#,
					contactFirstName = '#trim(event.getContactFirstName())#',
					contactLastName = '#trim(event.getContactLastName())#',
					contactPhone = '#trim(event.getContactPhone())#',
					contactEmail = '#trim(event.getContactEmail())#',
					comments = '#trim(event.getComments())#',
					approvedDate = <cfif isDate(event.getApprovedDate())>#createOdbcDateTime(event.getApprovedDate())#<cfelse>NULL</cfif>,
					approvedBy = '#trim(event.getApprovedBy())#',
					updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
					updateBy = '#trim(arguments.modifier)#'
				WHERE
					eventId = '#trim(event.getEventId())#'
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(arguments.event.getEventId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cftransaction>
			<cfquery name="q_eventDsid" datasource="#variables.dsn#">
				SELECT eventDsid 
				FROM events
				WHERE eventId = '#trim(arguments.id)#'
			</cfquery>
			
			<cfquery name="q_delete_calendar_events" datasource="#variables.dsn#">
				DELETE FROM calendars_events
				WHERE eventDsid = #val(q_eventDsid.eventDsid)#
			</cfquery>
	
			<cfquery name="q_delete_event" datasource="#variables.dsn#">
				DELETE FROM events
				WHERE eventDsid = #val(q_eventDsid.eventDsid)#
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="addReminder" access="public" returntype="void" output="false">
		<cfargument name="eventId" type="string" required="true" />
		<cfargument name="reminderId" type="string" required="true" />

		<cfquery name="q_eventDsid" datasource="#variables.dsn#">
			SELECT eventDsid
			FROM events
			WHERE eventId = '#trim(arguments.eventId)#'
		</cfquery>

		<cfquery name="q_reminderDsid" datasource="#variables.dsn#">
			SELECT reminderDsid
			FROM reminders
			WHERE reminderId = '#trim(arguments.reminderId)#'
		</cfquery>

		<cfquery name="q_event_reminder" datasource="#variables.dsn#">
			SELECT eventDsid, reminderDsid
			FROM events_reminders
			WHERE eventDsid = #val(q_eventDsid.eventDsid)#
			  AND reminderDsid = #val(q_reminderDsid.reminderDsid)#
		</cfquery>

		<cfif val(q_eventDsid.recordCount) gt 0 and val(q_reminderDsid.recordCount) gt 0 and val(q_event_reminder.recordCount) eq 0>
			<cfquery name="q_insert_event_reminder" datasource="#variables.dsn#">
				INSERT INTO events_reminders (eventDsid, reminderDsid)
				VALUES (#val(q_eventDsid.eventDsid)#, #val(q_reminderDsid.reminderDsid)#)
			</cfquery>
		</cfif>
		<cfset removeCacheItem(arguments.reminderId) />
		<cfset removeCacheItem(arguments.eventId) />
	</cffunction>

	<cffunction name="getStatus" access="public" returntype="void" output="false">
		<cfargument name="eventId" type="string" required="true" />
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
		<cfargument name="eventId" type="string" required="true" />
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="status" type="string" required="true" />

		<cftransaction>
			<cfquery name="q_statusDsid" datasource="#variables.dsn#" maxrows="1">			
				SELECT statusDsid
				FROM status
				WHERE code = '#trim(arguments.status)#'
			</cfquery>
			
			<cfquery name="q_event_status" datasource="#variables.dsn#">
				SELECT ce.eventDsid, ce.calendarDsid
				FROM events e INNER JOIN (
					calendars_events ce INNER JOIN calendars c ON ce.calendarDsid = c.calendarDsid
				) ON e.eventDsid = ce.eventDsid
				WHERE e.eventId = '#trim(arguments.eventId)#'
					AND c.calendarId = '#trim(arguments.calendarId)#'
			</cfquery>
			
			<cfif val(q_event_status.recordCount) gt 0>
				<cfquery name="q_update_status" datasource="#variables.dsn#">
					UPDATE calendars_events
					SET status = #val(q_statusDsid.statusDsid)#
					WHERE eventDsid = #val(q_event_status.eventDsid)#
					  AND calendarDsid = #val(q_event_status.calendarDsid)#
				</cfquery>
			<cfelse>
				<cfquery name="q_eventDsid" datasource="#variables.dsn#">
					SELECT eventDsid
					FROM events
					WHERE eventId = '#trim(arguments.eventId)#'
				</cfquery>
			
				<cfquery name="q_calendarDsid" datasource="#variables.dsn#">
					SELECT calendarDsid
					FROM calendars
					WHERE calendarId = '#trim(arguments.calendarId)#'
				</cfquery>
				
				<cfquery name="q_insert_status" datasource="#variables.dsn#">
					INSERT INTO calendars_events (eventDsid, calendarDsid, status)
					VALUES (#val(q_eventDsid.eventDsid)#, #val(q_calendarDsid.calendarDsid)#, #val(q_statusDsid.statusDsid)#)
				</cfquery>
			</cfif>
		</cftransaction>
		<cfset removeCacheItem(arguments.eventId) />
	</cffunction>

	<cffunction name="getEvents" access="public" returntype="query" output="false">
		<cfquery name="q_events" datasource="#variables.dsn#">
			SELECT *
			FROM events e INNER JOIN eventseries s ON e.seriesDsid = s.seriesDsid
		</cfquery>
		<cfreturn q_events />
	</cffunction>

	<cffunction name="getEventsByCalendar" access="public" returntype="query" output="false">
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

	<cffunction name="removeReminder" access="public" returntype="void" output="false">
		<cfargument name="eventId" type="string" required="true" />
		<cfargument name="reminderId" type="string" required="true" />

		<cfquery name="q_eventDsid" datasource="#variables.dsn#">
			SELECT eventDsid
			FROM events
			WHERE eventId = '#trim(arguments.eventId)#'
		</cfquery>

		<cfquery name="q_reminderDsid" datasource="#variables.dsn#">
			SELECT reminderDsid
			FROM reminders
			WHERE reminderId = '#trim(arguments.reminderId)#'
		</cfquery>

		<cfquery name="q_delete_event_reminder" datasource="#variables.dsn#">
			DELETE FROM events_reminders
			WHERE eventDsid = #val(q_eventDsid.eventDsid)#
			  AND reminderDsid = #val(q_reminderDsid.reminderDsid)#
		</cfquery>
		<cfset removeCacheItem(arguments.reminderId) />
		<cfset removeCacheItem(arguments.eventId) />
	</cffunction>

</cfcomponent>