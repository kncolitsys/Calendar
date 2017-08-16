<cfcomponent displayname="message">

	<cfset variables.instance.messageId = createUuid() />
	<cfset variables.instance.messageType = "email" />
	<cfset variables.instance.sender = "" />
	<cfset variables.instance.recipient = "" />
	<cfset variables.instance.recipient_cc = "" />
	<cfset variables.instance.recipient_bcc = "" />
	<cfset variables.instance.subject = "" />
	<cfset variables.instance.body = "" />
	<cfset variables.instance.sent = false />
	<cfset variables.instance.sentDate = now() />
	
	<cffunction name="init" access="public" returntype="message" output="false">
		<cfargument name="messageId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="messageType" type="string" required="false" default="email" />
		<cfargument name="sender" type="string" required="false" default="" />
		<cfargument name="recipient" type="string" required="false" default="" />
		<cfargument name="recipient_cc" type="string" required="false" default="" />
		<cfargument name="recipient_bcc" type="string" required="false" default="" />
		<cfargument name="subject" type="string" required="false" default="" />
		<cfargument name="body" type="string" required="false" default="" />
		<cfargument name="sent" type="boolean" required="false" default="false" />
		<cfargument name="sentDate" type="date" required="false" default="#now()#" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setMessageId(arguments.info.messageId);
			setMessageType(arguments.info.messageType);
			setSender(arguments.info.sender);
			setRecipient(arguments.info.recipient);
			setRecipient_cc(arguments.info.recipient_cc);
			setRecipient_bcc(arguments.info.recipient_bcc);
			setSubject(arguments.info.subject);
			setBody(arguments.info.body);
			setSent(arguments.info.sent);
			setSentDate(arguments.info.sentDate);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setMessageId" access="public" returntype="void" output="false">
		<cfargument name="messageId" type="string" required="true" />
		<cfset variables.instance.messageId = arguments.messageId />
	</cffunction>
	<cffunction name="getMessageId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.messageId />
	</cffunction>
	
	<cffunction name="setMessageType" access="public" returntype="void" output="false">
		<cfargument name="messageType" type="string" required="true" />
		<cfset variables.instance.messageType = arguments.messageType />
	</cffunction>
	<cffunction name="getMessageType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.messageType />
	</cffunction>
	
	<cffunction name="setSender" access="public" returntype="void" output="false">
		<cfargument name="sender" type="string" required="true" />
		<cfset variables.instance.sender = arguments.sender />
	</cffunction>
	<cffunction name="getSender" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sender />
	</cffunction>
	
	<cffunction name="setRecipient" access="public" returntype="void" output="false">
		<cfargument name="recipient" type="string" required="true" />
		<cfset variables.instance.recipient = arguments.recipient />
	</cffunction>
	<cffunction name="getRecipient" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recipient />
	</cffunction>
	
	<cffunction name="setRecipient_cc" access="public" returntype="void" output="false">
		<cfargument name="recipient_cc" type="string" required="true" />
		<cfset variables.instance.recipient_cc = arguments.recipient_cc />
	</cffunction>
	<cffunction name="getRecipient_cc" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recipient_cc />
	</cffunction>
	
	<cffunction name="setRecipient_bcc" access="public" returntype="void" output="false">
		<cfargument name="recipient_bcc" type="string" required="true" />
		<cfset variables.instance.recipient_bcc = arguments.recipient_bcc />
	</cffunction>
	<cffunction name="getRecipient_bcc" access="public" returntype="string" output="false">
		<cfreturn variables.instance.recipient_bcc />
	</cffunction>
	
	<cffunction name="setSubject" access="public" returntype="void" output="false">
		<cfargument name="subject" type="string" required="true" />
		<cfset variables.instance.subject = arguments.subject />
	</cffunction>
	<cffunction name="getSubject" access="public" returntype="string" output="false">
		<cfreturn variables.instance.subject />
	</cffunction>
	
	<cffunction name="setBody" access="public" returntype="void" output="false">
		<cfargument name="body" type="string" required="true" />
		<cfset variables.instance.body = arguments.body />
	</cffunction>
	<cffunction name="getBody" access="public" returntype="string" output="false">
		<cfreturn variables.instance.body />
	</cffunction>
	
	<cffunction name="setSent" access="public" returntype="void" output="false">
		<cfargument name="sent" type="boolean" required="true" />
		<cfset variables.instance.sent = arguments.sent />
	</cffunction>
	<cffunction name="getSent" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.sent />
	</cffunction>
	
	<cffunction name="setSentDate" access="public" returntype="void" output="false">
		<cfargument name="sentDate" type="date" required="true" />
		<cfset variables.instance.sentDate = arguments.sentDate />
	</cffunction>
	<cffunction name="getSentDate" access="public" returntype="date" output="false">
		<cfreturn variables.instance.sentDate />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getMessageTO" access="public" returntype="messageTO" output="false">
		<cfreturn createMessageTO() />
	</cffunction>
			
	<cffunction name="setMessageFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="messageTO" type="messageTO" required="true" />		
		<cfscript>
			setMessageId(arguments.messageTO.messageId);
			setMessageType(arguments.messageTO.messageType);
			setSender(arguments.messageTO.sender);
			setRecipient(arguments.messageTO.recipient);
			setRecipient_cc(arguments.messageTO.recipient_cc);
			setRecipient_bcc(arguments.messageTO.recipient_bcc);
			setSubject(arguments.messageTO.subject);
			setBody(arguments.messageTO.body);
			setSent(arguments.messageTO.sent);
			setSentDate(arguments.messageTO.sentDate);
		</cfscript>
	</cffunction>
	
	<cffunction name="createMessageTO" access="package" returntype="messageTO" output="false">
		<cfscript>
			var messageTO = createObject("component", "messageTO").init(argumentcollection=variables.instance);
			return messageTO;
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// General Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="send" access="public" returntype="void" output="false">
		<cfargument name="mailServer" required="true" type="calendar.models.mailServer.mailServer" />
		
		<!---// Send the mail message. --->
		<cftry>
			<cfmail from="#getSender()#" to="#getRecipient()#" port="#val(arguments.mailServer.getPort())#" server="#arguments.mailServer.getServer()#" subject="#getSubject()#">#getBody()#</cfmail>
			<cfcatch type="any"></cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>

