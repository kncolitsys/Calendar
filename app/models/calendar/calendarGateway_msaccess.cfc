<cfcomponent displayname="calendarGateway_msaccess" extends="calendarGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="calendar" type="calendar" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_scheme" datasource="#variables.dsn#">
				SELECT schemeDsid
				FROM schemes
				WHERE schemeId = '#trim(calendar.getScheme().getSchemeId())#'	
			</cfquery>

			<cfquery name="q_status" datasource="#variables.dsn#">
				SELECT statusDsid
				FROM status
				WHERE code = '#trim(calendar.getStatus())#'	
			</cfquery>

			<cfquery name="q_create_calendar" datasource="#variables.dsn#">
				INSERT INTO calendars (
					calendarId, title, status,
					description, header, footer,
					exitUrl, defaultSchemeDsid,
					createDate, createBy,
					updateDate, updateBy
				) VALUES (
					'#trim(calendar.getCalendarId())#', '#trim(calendar.getTitle())#', #val(q_status.statusDsid)#,
					'#trim(calendar.getDescription())#', '#trim(calendar.getHeader())#', '#trim(calendar.getFooter())#',
					'#trim(calendar.getExitUrl())#', #val(q_scheme.schemeDsid)#,
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
				)
			</cfquery>

			<cfscript>
				id = arguments.calendar.getCalendarId();
				mappings = getOptionsMappings("o2d");
				options = arguments.calendar.getOptions();
				for (key in options) {
					if (structKeyExists(mappings, key)) {
						setConfiguration(id, mappings[key], options[key]);
					}
				}			
			</cfscript>
		</cftransaction>
	</cffunction>

	<cffunction name="read" access="public" returntype="calendar" output="true">
		<cfargument name="id" type="string" required="true" />

		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the calendar info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_calendar" datasource="#variables.dsn#">
			SELECT *
			FROM calendars
			WHERE calendarId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_calendar.recordCount) gt 0>
			<cfquery name="q_status" datasource="#variables.dsn#">
				SELECT code
				FROM status
				WHERE statusDsid = #val(q_read_calendar.status)#
			</cfquery>

			<cfquery name="q_scheme" datasource="#variables.dsn#">
				SELECT schemeId
				FROM schemes
				WHERE schemeDsid = #val(q_read_calendar.defaultSchemeDsid)#
			</cfquery>

			<cfquery name="q_configurations" datasource="#variables.dsn#">
				SELECT c.title, l.configValue
				FROM configLookup l INNER JOIN configCatalog c ON l.configType = c.dsid
				WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'calendar')
				  AND objectValue = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.id)#')
			</cfquery>

			<cfquery name="q_privileges" datasource="#variables.dsn#">
				SELECT privilege, description
				FROM rights
				WHERE calendarDsid = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.id)#')
			</cfquery>

			<cfscript>
				// Load the calendar
				calendarStruct = queryRowToStruct(q_read_calendar);
				privileges = queryToStruct(q_privileges,"privilege");
				calendar = createObject("component","calendar").init(argumentcollection=calendarStruct,privileges=privileges);

				// Ideally, I shouldn't need to do this DB-Object mapping, but for legacy code
				// reasons, this is the easiest method... for now.
				mappings = getOptionsMappings("d2o");
				options = structNew();
			</cfscript>
			<cfloop query="q_configurations">
				<cfif structKeyExists(mappings, q_configurations.title)>
					<cfset options[mappings[q_configurations.title]] = q_configurations.configValue />
				</cfif>
			</cfloop>
			<cfscript>
				calendar.setOptions(options);
			
				// Load the scheme				
				scheme = variables.factory.getSchemeGateway().read(q_scheme.schemeId);
				calendar.setScheme(scheme);

				// Set the status to the appropriate text string
				calendar.setStatus(q_status.code);
				
				addCacheItem(calendar.getCalendarId(), calendar);
				
				// return the calendar object
				return calendar;
			</cfscript>
		<cfelse>
			<cfthrow type="EXITURL.MISSING" message="The requested calendar does not exist" detail="Calendar ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="calendar" type="calendar" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_scheme" datasource="#variables.dsn#">
				SELECT schemeDsid
				FROM schemes
				WHERE schemeId = '#trim(arguments.calendar.getScheme().getSchemeId())#'	
			</cfquery>

			<cfquery name="q_status" datasource="#variables.dsn#">
				SELECT statusDsid
				FROM status
				WHERE code = '#trim(arguments.calendar.getStatus())#'	
			</cfquery>

			<cfquery name="q_update_calendar" datasource="#variables.dsn#">
				UPDATE calendars
				SET
					title = '#trim(arguments.calendar.getTitle())#',
					status = #val(q_status.statusDsid)#,
					description = '#trim(arguments.calendar.getDescription())#',
					header = '#trim(arguments.calendar.getHeader())#',
					footer = '#trim(arguments.calendar.getFooter())#',
					exitUrl = '#trim(arguments.calendar.getExitUrl())#',
					defaultSchemeDsid = #val(q_scheme.schemeDsid)#,
					updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
					updateBy = '#trim(arguments.modifier)#'
				WHERE
					calendarId = '#trim(arguments.calendar.getCalendarId())#'
			</cfquery>
			
			<cfscript>
				id = arguments.calendar.getCalendarId();
				mappings = getOptionsMappings("o2d");
				options = arguments.calendar.getOptions();
				for (key in options) {
					if (structKeyExists(mappings, key)) {
						setConfiguration(id, mappings[key], options[key]);
					}
				}			
			</cfscript>
		</cftransaction>
		<cfset removeCacheItem(arguments.calendar.getCalendarId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cftransaction>
			<cfscript>
				// CODE: procedure
				// 1. remove all references to events
				// 2. delete all events associated with the calendar
				// 3. remove all references to global holidays
				// 4. delete all holidays associated with the calendar
				// 5. delete all categories associated with the calendar
				// 6. delete all mail records associated with the calendar
				// 7. delete all pending registrations associated with the calendar
				// 8. delete all schemes associated with the calendar
				// 9. delete all calendar configurations
				// 10. delete the calendar search index
				// 11. finally, delete the calendar
			</cfscript>

			<cfscript>
				calendar = read(arguments.id);
				id = calendar.getCalendarId();
				mappings = getOptionsMappings("o2d");
				options = calendar.getOptions();
				for (key in options) {
					if (structKeyExists(mappings, key)) {
						deleteConfiguration(id, mappings[key]);
					}
				}
			</cfscript>

			<cfquery name="q_delete_calendar" datasource="#variables.dsn#">
				DELETE FROM calendars
				WHERE calendarId = '#trim(id)#'
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="addCategory" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="false" />
		<cfargument name="categoryId" type="string" required="true" />

		<cfquery name="q_calendarDsid" datasource="#variables.dsn#">
			SELECT calendarDsid
			FROM calendars
			WHERE calendarId = '#trim(arguments.calendarId)#'
		</cfquery>
		
		<cfif val(q_calendarDsid.recordCount) gt 0>
			<cfquery name="q_calendar_category" datasource="#variables.dsn#">
				UPDATE categories
				SET calendarDsid = #val(q_calendarDsid.calendarDsid)#
				WHERE categoryId = '#trim(arguments.categoryId)#'
			</cfquery>
		</cfif>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="addEvent" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="false" />
		<cfargument name="eventId" type="string" required="true" />
		<cfargument name="status" type="string" required="false" default="pending" />

		<cfquery name="q_calendar_event" datasource="#variables.dsn#">
			SELECT c.calendarDsid, e.eventDsid, ce.status
			FROM calendars c INNER JOIN (
				calendars_events ce INNER JOIN events e ON ce.eventDsid = e.eventDsid
			) ON ce.calendarDsid = c.calendarDsid
			WHERE e.eventId = '#trim(arguments.eventId)#'
				AND c.calendarId = '#trim(arguments.calendarId)#'
		</cfquery>

		<cfif val(q_calendar_event.recordCount) gt 0 and compareNoCase(q_calendar_event.status,"pending") eq 0 >
			<cfthrow type="CALENDAR.EVENT.APPROVED" message="The event has already been added to the calendar" />
			<cfexit>
		<cfelseif val(q_calendar_event.recordCount) gt 0>
			<cfthrow type="CALENDAR.EVENT.SUBMITTED" message="The event has already been added to the calendar" />
			<cfexit>
		<cfelse>
			<cftransaction>
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

				<cfquery name="q_statusDsid" datasource="#variables.dsn#">
					SELECT statusDsid
					FROM status
					WHERE code = '#trim(arguments.status)#'
				</cfquery>
				
				<cfquery name="q_add_event_to_calendar" datasource="#variables.dsn#">
					INSERT INTO calendars_events (calendarDsid, eventDsid, status)
					VALUES (#val(q_calendarDsid.calendarDsid)#, #val(q_eventDsid.eventDsid)#, #val(q_statusDsid.statusDsid)#)
				</cfquery>
			</cftransaction>
		</cfif>

<!---		<cfif val(q_calendar_event.recordCount) gt 0 and val(q_calendar_event.status) eq global.calendar.status.approved>
			<cfthrow type="CALENDAR.EVENT.APPROVED" message="The event has already been added to the calendar" />
			<cfexit>
		<cfelseif val(q_calendar_event.recordCount) gt 0>
			<cfthrow type="CALENDAR.EVENT.SUBMITTED" message="The event has already been added to the calendar" />
			<cfexit>
		<cfelse>
			<cfquery name="q_add_event_to_calendar" datasource="#variables.dsn#">
				INSERT INTO #arguments.dbprefix#calendar_event (calendarDsid, eventDsid, status)
				VALUES (#val(q_event.calendarDsid)#, #val(q_event.eventDsid)#, #val(arguments.status)#)
			</cfquery>
		</cfif>--->
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="addEventSeries" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="false" />
		<cfargument name="seriesId" type="string" required="true" />
		<cfargument name="status" type="string" required="false" default="pending" />

		<cfquery name="q_calendar_eventSeries" datasource="#variables.dsn#">
			SELECT c.calendarDsid, s.seriesDsid, cs.status
			FROM calendars c INNER JOIN (
				calendars_eventseries cs INNER JOIN eventseries s ON cs.seriesDsid = s.seriesDsid
			) ON cs.calendarDsid = c.calendarDsid
			WHERE s.seriesId = '#trim(arguments.seriesId)#'
				AND c.calendarId = '#trim(arguments.calendarId)#'
		</cfquery>

		<cfif val(q_calendar_eventSeries.recordCount) gt 0 and compareNoCase(q_calendar_eventSeries.status,"pending") eq 0 >
			<cfthrow type="CALENDAR.EVENTSERIES.APPROVED" message="The event series has already been added to the calendar" />
			<cfexit>
		<cfelseif val(q_calendar_eventSeries.recordCount) gt 0>
			<cfthrow type="CALENDAR.EVENTSERIES.SUBMITTED" message="The event series has already been added to the calendar" />
			<cfexit>
		<cfelse>
			<cftransaction>
				<cfquery name="q_seriesDsid" datasource="#variables.dsn#">
					SELECT seriesDsid
					FROM eventseries
					WHERE seriesId = '#trim(arguments.seriesId)#'
				</cfquery>
				
				<cfquery name="q_calendarDsid" datasource="#variables.dsn#">
					SELECT calendarDsid
					FROM calendars
					WHERE calendarId = '#trim(arguments.calendarId)#'
				</cfquery>

				<cfquery name="q_statusDsid" datasource="#variables.dsn#">
					SELECT statusDsid
					FROM status
					WHERE code = '#trim(arguments.status)#'
				</cfquery>
				
				<cfquery name="q_add_event_to_calendar" datasource="#variables.dsn#">
					INSERT INTO calendars_eventseries (calendarDsid, seriesDsid, status)
					VALUES (#val(q_calendarDsid.calendarDsid)#, #val(q_seriesDsid.seriesDsid)#, #val(q_statusDsid.statusDsid)#)
				</cfquery>
			</cftransaction>
		</cfif>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="addHoliday" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="false" />
		<cfargument name="holidayId" type="string" required="true" />

		<cfquery name="q_calendarDsid" datasource="#variables.dsn#">
			SELECT calendarDsid
			FROM calendars
			WHERE calendarId = '#trim(arguments.calendarId)#'
		</cfquery>

		<cfquery name="q_holidayDsid" datasource="#variables.dsn#">
			SELECT holidayDsid
			FROM holidays
			WHERE holidayId = '#trim(arguments.holidayId)#'
		</cfquery>
		
		<cfif val(q_calendarDsid.recordCount) gt 0 and val(q_holidayDsid.recordCount) gt 0>
			<cfquery name="q_calendar_holiday" datasource="#variables.dsn#">
				SELECT *
				FROM calendars_holidays
				WHERE calendarDsid = #val(q_calendarDsid.calendarDsid)#
				  AND holidayDsid = #val(q_holidayDsid.holidayDsid)#
			</cfquery>
			<cfif (q_calendar_holiday.recordCount) eq 0>
				<cfquery name="q_calendar_category" datasource="#variables.dsn#">
					INSERT INTO calendars_holidays (calendarDsid, holidayDsid)
					VALUES (#val(q_calendarDsid.calendarDsid)#, #val(q_holidayDsid.holidayDsid)#)
				</cfquery>
			</cfif>
		</cfif>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="addScheme" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="false" />
		<cfargument name="schemeId" type="string" required="true" />

		<cfquery name="q_calendarDsid" datasource="#variables.dsn#">
			SELECT calendarDsid
			FROM calendars
			WHERE calendarId = '#trim(arguments.calendarId)#'
		</cfquery>
		
		<cfif val(q_calendarDsid.recordCount) gt 0>
			<cfquery name="q_calendar_scheme" datasource="#variables.dsn#">
				UPDATE schemes
				SET calendarDsid = #val(q_calendarDsid.calendarDsid)#
				WHERE schemeId = '#trim(arguments.schemeId)#'
			</cfquery>
		</cfif>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="addSearchIndex" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="false" />
		<cfargument name="searchIndexId" type="string" required="true" />

		<cfquery name="q_calendarDsid" datasource="#variables.dsn#">
			SELECT calendarDsid
			FROM calendars
			WHERE calendarId = '#trim(arguments.calendarId)#'
		</cfquery>
		
		<cfif val(q_calendarDsid.recordCount) gt 0>
			<cfquery name="q_calendar_searchindexes" datasource="#variables.dsn#">
				UPDATE searchindexes
				SET calendarDsid = #val(q_calendarDsid.calendarDsid)#
				WHERE searchIndexId = '#trim(arguments.searchIndexId)#'
			</cfquery>
		</cfif>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="deleteConfiguration" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="configuration" type="string" required="true" />
		
		<cfquery name="q_configuration" datasource="#variables.dsn#">
		 	DELETE FROM configLookup
			WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'calendar')
			  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
			  AND objectValue = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#')
		</cfquery>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="getCalendars" access="public" returntype="query" output="false">
		<cfargument name="status" required="false" type="string" default="all" />
		<cfquery name="q_calendars" datasource="#variables.dsn#">
			SELECT *
			FROM calendars
			<cfif compareNoCase(arguments.status,"approved") eq 0 or compareNoCase(arguments.status,"pending") eq 0>
				WHERE status = (SELECT statusDsid FROM status WHERE code = '#trim(arguments.status)#')
			</cfif>
		</cfquery>
		<cfreturn q_calendars />
	</cffunction>
	
	<cffunction name="getCategories" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />

		<cfquery name="q_categories" datasource="#variables.dsn#">
			SELECT t.*, t.title as categoryTitle
			FROM categories t INNER JOIN calendars c ON t.calendarDsid = c.calendarDsid
			WHERE c.calendarId = '#trim(arguments.calendarId)#'
		</cfquery>
		<cfreturn q_categories />
	</cffunction>

	<cffunction name="getConfiguration" access="public" returntype="string" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="configuration" type="string" required="true" />
		
		<cfquery name="q_configuration" datasource="#variables.dsn#">
			SELECT configValue
			FROM configLookup
			WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'calendar')
			  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
			  AND objectValue = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#')
		</cfquery>
		<cfreturn q_configuration.configValue />
	</cffunction>

	<cffunction name="getEvents" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="startDate" type="date" required="true" />
		<cfargument name="endDate" type="date" required="true" />
		<cfargument name="categories" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="approved" />
		<cfargument name="all" type="boolean" required="false" default="false" />

		<cfquery name="q_calendar_events" datasource="#variables.dsn#">
			SELECT e.*, (SELECT es.seriesId FROM eventSeries es WHERE es.seriesDsid = e.seriesDsid) AS seriesId, t.categoryId
			FROM #dbprefix#calendars c INNER JOIN (
				#dbprefix#calendars_events ce INNER JOIN (
					#dbprefix#events e LEFT JOIN #dbprefix#categories t ON e.categoryDsid = t.categoryDsid
				) ON e.eventDsid = ce.eventDsid
			) ON c.calendarDsid = ce.calendarDsid
			WHERE e.startDateTime BETWEEN #createOdbcDateTime(arguments.startDate)# AND #createOdbcDateTime(arguments.endDate)#
				<cfif len(arguments.categories) gt 0>AND e.categoryDsid IN (SELECT categoryDsid FROM categories WHERE categoryId IN (#listQualify(arguments.categories,"'")#))</cfif>
				<cfif compareNoCase(arguments.status,"approved") eq 0>AND ce.status = 1<cfelse>AND ce.status <> 1</cfif>
				<cfif arguments.all neq true>AND c.calendarId = '#trim(arguments.calendarId)#'</cfif>
			ORDER BY e.startDateTime ASC
		</cfquery>
		<cfreturn q_calendar_events />
	</cffunction>

	<cffunction name="getEventSeries" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="startDate" type="date" required="true" />
		<cfargument name="endDate" type="date" required="true" />
		<cfargument name="categories" type="string" required="false" default="" />
		<cfargument name="status" type="string" required="false" default="approved" />
		<cfargument name="all" type="boolean" required="false" default="true" />

		<cfquery name="q_calendar_eventSeries" datasource="#variables.dsn#">
			SELECT s.*, t.categoryId
			FROM #dbprefix#calendars c INNER JOIN (
				#dbprefix#calendars_eventseries cs INNER JOIN (
					#dbprefix#eventseries s INNER JOIN #dbprefix#categories t ON s.categoryDsid = t.categoryDsid
				) ON cs.seriesDsid = s.seriesDsid
			) ON c.calendarDsid = cs.calendarDsid
			WHERE s.recurrenceStartDate BETWEEN #createOdbcDateTime(arguments.startDate)# AND #createOdbcDateTime(arguments.endDate)#
				<cfif len(arguments.categories) gt 0>AND s.categoryDsid IN (SELECT categoryDsid FROM categories WHERE categoryId IN (#listQualify(arguments.categories,"'")#))</cfif>
				<cfif compareNoCase(arguments.status,"approved") eq 0>AND cs.status = 1<cfelse>AND cs.status <> 1</cfif>
				<cfif arguments.all neq true>AND c.calendarId = '#trim(arguments.calendarId)#'</cfif>
		</cfquery>
		<cfreturn q_calendar_eventSeries />
	</cffunction>

	<cffunction name="getHolidays" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="global" type="boolean" required="false" />

		<cfquery name="q_calendar_holidays" datasource="#variables.dsn#">
			SELECT h.holidayId, h.recurrenceRule, h.globalObject, h.title
			FROM #dbprefix#holidays h INNER JOIN (
				#dbprefix#calendars_holidays ch INNER JOIN #dbprefix#calendars c ON c.calendarDsid = ch.calendarDsid
			) ON h.holidayDsid = ch.holidayDsid
			WHERE c.calendarId = '#trim(arguments.calendarId)#'
				<cfif isDefined("arguments.global")>AND <cfif arguments.global eq true>h.globalObject = 1<cfelse>h.globalObject = 0</cfif></cfif>
		</cfquery>
		<cfreturn q_calendar_holidays />
	</cffunction>

	<cffunction name="getOptionsMappings" access="private" returntype="struct" output="false">
		<cfargument name="direction" type="string" required="false" default="o2d" hint="o2d = Object-to-Database, d2o = Database-to-Object" />
		
		<cfscript>
			mapDatabase =  "calendar_week_start,calendar_week_end,calendar_search_enabled,calendar_vcalendar_enabled,policy_userapprovalrequired,calendar_display_workhours,calendar_access_public_permissions,calendar_default_group,mail_registrationreceived_body,mail_registrationreceived_subject,mail_registrationapproved_body,mail_registrationapproved_subject,mail_registrationdenied_body,mail_registrationdenied_subject";
			mapObject = "weekStart,weekEnd,searchEnabled,calendarExportEnabled,userApprovalRequired,displayWorkHours,publicPermissions,defaultGroup,mail_registrationreceived_body,mail_registrationreceived_subject,mail_registrationapproved_body,mail_registrationapproved_subject,mail_registrationdenied_body,mail_registrationdenied_subject";
			mappings = structNew();
			for (i=1; i lte listLen(mapDatabase); i=i+1) {
				switch (lcase(arguments.direction)) {
					case "o2d":
						mappings[listGetAt(mapObject,i)] = listGetAt(mapDatabase,i);
						break;
					case "d2o": default:
						mappings[listGetAt(mapDatabase,i)] = listGetAt(mapObject,i);
				}
			}
			return mappings;
		</cfscript>
	</cffunction>

	<cffunction name="getPrivileges" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		
		<cfquery name="q_calendar_privileges" datasource="#variables.dsn#">
			SELECT r.*
			FROM #dbprefix#rights r LEFT JOIN #dbprefix#calendars c ON r.calendarDsid = c.calendarDsid
			WHERE c.calendarId = '#trim(arguments.calendarId)#'
		</cfquery>
		<cfreturn q_calendar_privileges />
	</cffunction>
	
	<cffunction name="getSchemes" access="public" returntype="query" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="global" type="boolean" required="false" default="false" />
		<cfargument name="all" type="boolean" required="false" default="true" />
		
		<cfquery name="q_calendar_schemes" datasource="#variables.dsn#">
			SELECT s.*
			FROM #dbprefix#schemes s LEFT JOIN #dbprefix#calendars c ON s.calendarDsid = c.calendarDsid
			WHERE c.calendarId = '#trim(arguments.calendarId)#'
				<cfif arguments.all neq true>AND <cfif arguments.global eq true>s.globalObject = 1<cfelse>s.globalObject <> 1</cfif></cfif>
		</cfquery>
		<cfreturn q_calendar_schemes />
	</cffunction>

	<cffunction name="removeHolidays" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		
		<cfquery name="q_delete_holidays" datasource="#variables.dsn#">
		 	DELETE FROM calendars_holidays
			WHERE calendarDsid = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#')
		</cfquery>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

	<cffunction name="setConfiguration" access="public" returntype="void" output="false">
		<cfargument name="calendarId" type="string" required="true" />
		<cfargument name="configuration" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		
		<cfquery name="q_configuration" datasource="#variables.dsn#">
			SELECT configValue
			FROM configLookup
			WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'calendar')
			  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
			  AND objectValue = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#')
		</cfquery>
		<cfif q_configuration.recordCount gt 0 >
			<cfquery name="q_update_configuration" datasource="#variables.dsn#">
				UPDATE configLookup
				SET configValue = '#trim(arguments.value)#'
				WHERE objectType = (SELECT dsid FROM configObject WHERE title = 'calendar')
				  AND configType = (SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#')
				  AND objectValue = (SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#')
			</cfquery>
		<cfelse>
			<cfquery name="q_config_calendar" datasource="#variables.dsn#">
				SELECT dsid FROM configObject WHERE title = 'calendar'
			</cfquery>
			<cfquery name="q_config_catalog" datasource="#variables.dsn#">
				SELECT dsid FROM configCatalog WHERE title = '#trim(arguments.configuration)#'
			</cfquery>
			<cfquery name="q_config_object" datasource="#variables.dsn#">
				SELECT calendarDsid FROM calendars WHERE calendarId = '#trim(arguments.calendarId)#'
			</cfquery>
			<cfquery name="q_insert_configuration" datasource="#variables.dsn#">
				INSERT INTO configLookup (
					objectType, configType,
					objectValue, configValue
				)
				VALUES (
					#val(q_config_calendar.dsid)#, #val(q_config_catalog.dsid)#,
					#val(q_config_object.calendarDsid)#, '#trim(arguments.value)#'
				)
			</cfquery>
		</cfif>
		<cfset removeCacheItem(arguments.calendarId) />
	</cffunction>

</cfcomponent>