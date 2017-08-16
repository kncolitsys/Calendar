<cfcomponent displayname="applicationTO" access="public" hint="Application Tranfer Object">

	<cffunction name="init" access="public" returntype="applicationTO" output="false" displayname="ApplicationTO Constructor" hint="Initializes the Application Transfer Object">
		<cfargument name="applicationId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="product" type="string" required="false" default="" />
		<cfargument name="edition" type="string" required="false" default="" />
		<cfargument name="version" type="string" required="false" default="" />
		<cfargument name="serial" type="string" required="false" default="" />
		<cfargument name="privileges" type="struct" required="false" default="#structNew()#" />
		
		<cfscript>
			this.applicationId = arguments.applicationId;
			this.title = arguments.title;
			this.product = arguments.product;
			this.edition = arguments.edition;
			this.version = arguments.version;
			this.serial = arguments.serial;
			this.privileges = arguments.privileges;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>

