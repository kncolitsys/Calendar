<cfcomponent displayname="schemeTO" access="public" hint="Scheme Tranfer Object">

	<cffunction name="init" access="public" returntype="schemeTO" output="false" displayname="SchemeTO Constructor" hint="Initializes the Scheme Transfer Object">
		<cfargument name="schemeId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="global" type="boolean" required="false" default="false" />
		<cfargument name="stylesheet" type="string" required="false" default="" />
		<cfargument name="filepath" type="string" required="false" default="" />

		<cfscript>
			this.schemeId = arguments.schemeId;
			this.title = arguments.title;
			this.global = arguments.global;
			this.stylesheet = arguments.stylesheet;
			this.filepath = arguments.filepath;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>

