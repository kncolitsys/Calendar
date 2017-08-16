<cfcomponent displayname="messageGateway_mssql" extends="messageGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="message" type="message" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_message" datasource="#variables.dsn#">
			INSERT INTO messages (
				messageId, messageType, sender,
				recipient, recipient_cc, recipient_bcc,
				subject, body, 
				sent, sentDate,
				createDate,	createBy,
				updateDate,	updateBy
			) VALUES (
				'#trim(message.getMessageId())#', '#trim(message.getMessageType())#', '#trim(message.getSender())#',
				'#trim(message.getRecipient())#', '#trim(message.getRecipient_cc())#', '#trim(message.getRecipient_bcc())#',
				'#trim(message.getSubject())#', '#trim(message.getBody())#',
				#int(message.getSent())#, <cfif isDate(message.getSentDate())>#createOdbcDateTime(message.getSentDate())#<cfelse>NULL</cfif>,
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="message" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the message info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_message" datasource="#variables.dsn#">
			SELECT *
			FROM messages
			WHERE messageId = '#trim(arguments.id)#'
		</cfquery>
		
		<cfif val(q_read_message.recordCount) gt 0>
			<cfscript>
				messageStruct = queryRowToStruct(q_read_message);
				message = createObject("component","message").init(argumentcollection=messageStruct);
				addCacheItem(message.getMessageId(), message);
				return message;
			</cfscript>
		<cfelse>
			<cfthrow type="MESSAGE.MISSING" message="The requested message does not exist" detail="Message ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="message" type="message" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_message" datasource="#variables.dsn#">
			UPDATE messages
			SET
				messageType = '#trim(message.getMessageType())#',
				sender = '#trim(message.getSender())#',
				recipient = '#trim(message.getRecipient())#',
				recipient_cc = '#trim(message.getRecipient_cc())#',
				recipient_bcc = '#trim(message.getRecipient_bcc())#',
				subject = '#trim(message.getSubject())#',
				body = '#trim(message.getBody())#',
				sent = #int(message.getSent())#,
				sentDate = <cfif isDate(message.getSentDate())>#createOdbcDateTime(message.getSentDate())#<cfelse>NULL</cfif>,
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				messageId = '#trim(message.getMessageId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.message.getMessageId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_message" datasource="#variables.dsn#">
			DELETE FROM messages
			WHERE messageId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="getMessages" access="public" returntype="query">
		<cfquery name="q_messages" datasource="#variables.dsn#">
			SELECT *
			FROM messages
		</cfquery>
		<cfreturn q_messages />
	</cffunction>
	
</cfcomponent>