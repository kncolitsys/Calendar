<cfcomponent displayname="reminderGateway_msaccess" extends="reminderGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="reminder" type="reminder" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cftransaction>
			<cfquery name="q_create_reminder" datasource="#variables.dsn#">
				INSERT INTO reminders (
					reminderId, schedule, userId,
					createDate, createBy,
					updateDate, updateBy
				) VALUES (
					'#trim(reminder.getReminderId())#', '#trim(reminder.getSchedule())#', '#trim(reminder.getUser().getUserId())#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
					<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
				)
			</cfquery>
			
			<cfinvoke method="createReminderMethods" reminderId="#reminder.getReminderId()#" methods="#reminder.getMethods()#" />
		</cftransaction>
	</cffunction>

	<cffunction name="read" access="public" returntype="reminder" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the reminder info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_reminder" datasource="#variables.dsn#">
			SELECT *
			FROM reminders
			WHERE reminderId = '#trim(arguments.id)#'
		</cfquery>

		<cfquery name="q_read_remindermethods" datasource="#variables.dsn#">
			SELECT *
			FROM remindermethods
			WHERE reminderDsid = #val(q_read_reminder.reminderDsid)#
		</cfquery>
		<cfset methods = structNew() />
		<cfloop query="q_read_remindermethods">
			<cfset methods[q_read_remindermethods.method] = q_read_remindermethods.toAddress />
		</cfloop>

		<cfif val(q_read_reminder.recordCount) gt 0>
			<cfscript>
				reminderStruct = queryRowToStruct(q_read_reminder);
				try {
					user = variables.factory.getUserGateway().read(id=q_read_reminder.userId);
				} catch (any e) {
					user = createObject("component","calendar.models.user.user");
				}
				reminder = createObject("component","reminder").init(argumentcollection=reminderStruct,user=user,methods=methods);
				addCacheItem(reminder.getReminderId(), reminder);
				return reminder;
			</cfscript>
		<cfelse>
			<cfthrow type="REMINDER.MISSING" message="The requested reminder does not exist" detail="Reminder ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="reminder" type="reminder" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cftransaction>
			<cfquery name="q_update_reminder" datasource="#variables.dsn#">
				UPDATE reminders
				SET
					schedule = #val(reminder.getSchedule())#,
					userId = '#trim(reminder.getUser().getUserId())#',
					updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
					updateBy = '#trim(arguments.modifier)#'
				WHERE
					reminderId = '#trim(reminder.getReminderId())#'
			</cfquery>
		
			<cfinvoke method="createReminderMethods" reminderId="#reminder.getReminderId()#" methods="#reminder.getMethods()#" />
		</cftransaction>
		<cfset removeCacheItem(arguments.reminder.getReminderId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_reminderDsid" datasource="#variables.dsn#">
			SELECT reminderDsid
			FROM reminders
			WHERE reminderId = '#trim(arguments.id)#'
		</cfquery>

		<cftransaction>
			<cfquery name="q_delete_remindermethods" datasource="#variables.dsn#">
				DELETE FROM remindermethods
				WHERE reminderDsid = #val(q_reminderDsid.reminderDsid)#
			</cfquery>
			<cfquery name="q_delete_reminder" datasource="#variables.dsn#">
				DELETE FROM reminders
				WHERE reminderDsid = #val(q_reminderDsid.reminderDsid)#
			</cfquery>
		</cftransaction>
		<cfset removeCacheItem(id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="createReminderMethods" access="private" returntype="void" output="false">
		<cfargument name="reminderId" type="string" required="true" />
		<cfargument name="methods" type="struct" required="false" default="#structNew()#" />
		
		<cfquery name="q_reminderDsid" datasource="#variables.dsn#">
			SELECT reminderDsid
			FROM reminders
			WHERE reminderId = '#trim(arguments.reminderId)#'
		</cfquery>
		
		<cfquery name="q_delete_remindermethods" datasource="#variables.dsn#">
			DELETE FROM remindermethods
			WHERE reminderDsid = #val(q_reminderDsid.reminderDsid)#
		</cfquery>
			
		<cfloop  index="i" list="#structKeyList(arguments.methods)#">
			<cfquery name="q_update_remindermethods" datasource="#variables.dsn#">
				INSERT INTO remindermethods (reminderDsid, method, toAddress)
				VALUES (#val(q_reminderDsid.reminderDsid)#, '#trim(i)#', '#trim(structFind(arguments.methods,i))#')
			</cfquery>
		</cfloop>
	</cffunction>

	<cffunction name="getEventReminder" access="public" returntype="calendar.models.reminder.reminder" output="false">
		<cfargument name="eventId" type="string" required="true" />
		<cfargument name="userId" type="string" required="true" />
		
		<cfquery name="q_reminderId" datasource="#variables.dsn#">
			SELECT reminderId
			FROM reminders r INNER JOIN (
			  events_reminders er INNER JOIN events e ON e.eventDsid = er.eventDsid
			) ON r.reminderDsid = er.reminderDsid
			WHERE e.eventId = '#trim(arguments.eventId)#'
			  AND r.userId = '#trim(arguments.userId)#'
		</cfquery>
		<cfreturn read(q_reminderId.reminderId) />
	</cffunction>
	
	<cffunction name="getEventSeriesReminder" access="public" returntype="calendar.models.reminder.reminder" output="false">
		<cfargument name="seriesId" type="string" required="true" />
		<cfargument name="userId" type="string" required="true" />
		
		<cfquery name="q_reminderId" datasource="#variables.dsn#">
			SELECT reminderId
			FROM reminders r INNER JOIN (
				eventseries_reminders er INNER JOIN eventseries e ON e.seriesDsid = er.seriesDsid
			) ON r.reminderDsid = er.reminderDsid
			WHERE e.seriesId = '#trim(arguments.seriesId)#'
			  AND r.userId = '#trim(arguments.userId)#'
		</cfquery>
		<cfreturn read(q_reminderId.reminderId) />
	</cffunction>
	
	<cffunction name="getReminders" access="public" returntype="query">
		<cfquery name="q_reminders" datasource="#variables.dsn#">
			SELECT *
			FROM reminders
		</cfquery>
		<cfreturn q_reminders />
	</cffunction>
	
</cfcomponent>