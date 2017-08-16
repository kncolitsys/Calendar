<cfcomponent displayname="messageTO" access="public" hint="Message Tranfer Object">

	<cffunction name="init" access="public" returntype="messageTO" output="false" displayname="MessageTO Constructor" hint="Initializes the Message Transfer Object">
		<cfargument name="messageId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="messageType" type="string" required="false" default="" />
		<cfargument name="sender" type="string" required="false" default="" />
		<cfargument name="recipient" type="string" required="false" default="" />
		<cfargument name="recipient_cc" type="string" required="false" default="" />
		<cfargument name="recipient_bcc" type="string" required="false" default="" />
		<cfargument name="subject" type="string" required="false" default="" />
		<cfargument name="body" type="string" required="false" default="" />
		<cfargument name="sent" type="boolean" required="false" default="" />
		<cfargument name="sentDate" type="date" required="false" default="" />

		<cfscript>
			this.messageId = arguments.messageId;
			this.messageType = arguments.messageType;
			this.sender = arguments.sender;
			this.recipient = arguments.recipient;
			this.recipient_cc = arguments.recipient_cc;
			this.recipient_bcc = arguments.recipient_bcc;
			this.subject = arguments.subject;
			this.body = arguments.body;
			this.sent = arguments.sent;
			this.sentDate = arguments.sentDate;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>

