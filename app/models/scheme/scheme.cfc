<cfcomponent displayname="scheme">

	<cfset variables.instance.schemeId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.global = false />
	<cfset variables.instance.stylesheet = "" />
	<cfset variables.instance.filepath = "" />
	
	<cffunction name="init" access="public" returntype="scheme" output="false">
		<cfargument name="schemeId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="global" type="boolean" required="false" default="false" />
		<cfargument name="stylesheet" type="string" required="false" default="" />
		<cfargument name="filepath" type="string" required="false" default="" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setSchemeId(arguments.info.schemeId);
			setTitle(arguments.info.title);
			setGlobal(arguments.info.global);
			setStylesheet(arguments.info.stylesheet);
			setFilepath(arguments.info.filepath);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setSchemeId" access="public" returntype="void" output="false">
		<cfargument name="schemeId" type="string" required="true" />
		<cfset variables.instance.schemeId = arguments.schemeId />
	</cffunction>
	<cffunction name="getSchemeId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.schemeId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setGlobal" access="public" returntype="void" output="false">
		<cfargument name="global" type="boolean" required="true" />
		<cfset variables.instance.global = arguments.global />
	</cffunction>
	<cffunction name="getGlobal" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.global />
	</cffunction>
	
	<cffunction name="setStylesheet" access="public" returntype="void" output="false">
		<cfargument name="stylesheet" type="string" required="true" />
		<cfset variables.instance.stylesheet = arguments.stylesheet />
	</cffunction>
	<cffunction name="getStylesheet" access="public" returntype="string" output="false">
		<cfreturn variables.instance.stylesheet />
	</cffunction>
	
	<cffunction name="setFilepath" access="public" returntype="void" output="false">
		<cfargument name="filepath" type="string" required="true" />
		<cfset variables.instance.filepath = arguments.filepath />
	</cffunction>
	<cffunction name="getFilepath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.filepath />
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getSchemeTO" access="public" returntype="schemeTO" output="false">
		<cfreturn createSchemeTO() />
	</cffunction>
			
	<cffunction name="setSchemeFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="schemeTO" type="schemeTO" required="true" />		
		<cfscript>
			setSchemeId(arguments.schemeTO.schemeId);
			setTitle(arguments.schemeTO.title);
			setGlobal(arguments.schemeTO.global);
			setStylesheet(arguments.schemeTO.stylesheet);
			setFilepath(arguments.schemeTO.filepath);
		</cfscript>
	</cffunction>
	
	<cffunction name="createSchemeTO" access="package" returntype="schemeTO" output="false">
		<cfscript>
			var schemeTO = createObject("component", "schemeTO").init(argumentcollection=variables.instance);
			return schemeTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>