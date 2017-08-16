<cfcomponent displayname="application">

	<cfset variables.instance.applicationId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.product = "" />
	<cfset variables.instance.edition = "" />
	<cfset variables.instance.version = "" />
	<cfset variables.instance.serial = "" />
	<cfset variables.instance.privileges = structNew() />
	
	<cffunction name="init" access="public" returntype="application" output="false">
		<cfargument name="applicationId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="product" type="string" required="false" default="" />
		<cfargument name="edition" type="string" required="false" default="" />
		<cfargument name="version" type="string" required="false" default="" />
		<cfargument name="serial" type="string" required="false" default="" />
		<cfargument name="privileges" type="struct" required="false" default="#structNew()#" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setApplicationId(arguments.info.applicationId);
			setTitle(arguments.info.title);
			setProduct(arguments.info.product);
			setEdition(arguments.info.edition);
			setVersion(arguments.info.version);
			setSerial(arguments.info.serial);
			setPrivileges(arguments.info.privileges);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setApplicationId" access="public" returntype="void" output="false">
		<cfargument name="applicationId" type="string" required="true" />
		<cfset variables.instance.applicationId = arguments.applicationId />
	</cffunction>
	<cffunction name="getApplicationId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.applicationId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setProduct" access="public" returntype="void" output="false">
		<cfargument name="product" type="string" required="true" />
		<cfset variables.instance.product = arguments.product />
	</cffunction>
	<cffunction name="getProduct" access="public" returntype="string" output="false">
		<cfreturn variables.instance.product />
	</cffunction>
	
	<cffunction name="setEdition" access="public" returntype="void" output="false">
		<cfargument name="edition" type="string" required="true" />
		<cfset variables.instance.edition = arguments.edition />
	</cffunction>
	<cffunction name="getEdition" access="public" returntype="string" output="false">
		<cfreturn variables.instance.edition />
	</cffunction>
	
	<cffunction name="setVersion" access="public" returntype="void" output="false">
		<cfargument name="version" type="string" required="true" />
		<cfset variables.instance.version = arguments.version />
	</cffunction>
	<cffunction name="getVersion" access="public" returntype="string" output="false">
		<cfreturn variables.instance.version />
	</cffunction>
	
	<cffunction name="setSerial" access="public" returntype="void" output="false">
		<cfargument name="serial" type="string" required="true" />
		<cfset variables.instance.serial = arguments.serial />
	</cffunction>
	<cffunction name="getSerial" access="public" returntype="string" output="false">
		<cfreturn variables.instance.serial />
	</cffunction>

	<cffunction name="setPrivileges" access="public" returntype="void" output="false">
		<cfargument name="privileges" type="struct" required="true" />
		<cfset variables.instance.privileges = arguments.privileges />
	</cffunction>
	<cffunction name="getPrivileges" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.privileges />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getApplicationTO" access="public" returntype="applicationTO" output="false">
		<cfreturn createApplicationTO() />
	</cffunction>
			
	<cffunction name="setApplicationFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="applicationTO" type="applicationTO" required="true" />		
		<cfscript>
			setApplicationId(arguments.applicationTO.applicationId);
			setTitle(arguments.applicationTO.title);
			setProduct(arguments.applicationTO.product);
			setEdition(arguments.applicationTO.edition);
			setVersion(arguments.applicationTO.version);
			setSerial(arguments.applicationTO.serial);
			setPrivileges(arguments.applicationTO.privileges);
		</cfscript>
	</cffunction>
	
	<cffunction name="createApplicationTO" access="package" returntype="applicationTO" output="false">
		<cfscript>
			var applicationTO = createObject("component", "applicationTO").init(argumentcollection=variables.instance);
			return applicationTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>