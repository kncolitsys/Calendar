<cfcomponent displayname="searchIndex">

	<cfset variables.instance.searchIndexId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.collection = "" />
	<cfset variables.instance.path = "" />
	<cfset variables.instance.language = "" />
	
	<cffunction name="init" access="public" returntype="searchIndex" output="false">
		<cfargument name="searchIndexId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="collection" type="string" required="false" default="" />
		<cfargument name="path" type="string" required="false" default="" />
		<cfargument name="language" type="string" required="false" default="english" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setSearchIndexId(arguments.info.searchIndexId);
			setTitle(arguments.info.title);
			setCollection(arguments.info.collection);
			setPath(arguments.info.path);
			setLanguage(arguments.info.language);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setSearchIndexId" access="public" returntype="void" output="false">
		<cfargument name="searchIndexId" type="string" required="true" />
		<cfset variables.instance.searchIndexId = arguments.searchIndexId />
	</cffunction>
	<cffunction name="getSearchIndexId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.searchIndexId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setCollection" access="public" returntype="void" output="false">
		<cfargument name="collection" type="string" required="true" />
		<cfset variables.instance.collection = arguments.collection />
	</cffunction>
	<cffunction name="getCollection" access="public" returntype="string" output="false">
		<cfreturn variables.instance.collection />
	</cffunction>
	
	<cffunction name="setPath" access="public" returntype="void" output="false">
		<cfargument name="path" type="string" required="true" />
		<cfset variables.instance.path = arguments.path />
	</cffunction>
	<cffunction name="getPath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.path />
	</cffunction>
	
	<cffunction name="setLanguage" access="public" returntype="void" output="false">
		<cfargument name="language" type="string" required="true" />
		<cfset variables.instance.language = arguments.language />
	</cffunction>
	<cffunction name="getLanguage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.language />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getSearchIndexTO" access="public" returntype="searchIndexTO" output="false">
		<cfreturn createSearchIndexTO() />
	</cffunction>
			
	<cffunction name="setSearchIndexFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="searchIndexTO" type="searchIndexTO" required="true" />		
		<cfscript>
			setSearchIndexId(arguments.searchIndexTO.searchIndexId);
			setTitle(arguments.searchIndexTO.title);
			setCollection(arguments.searchIndexTO.collection);
			setPath(arguments.searchIndexTO.path);
			setLanguage(arguments.searchIndexTO.language);
		</cfscript>
	</cffunction>
	
	<cffunction name="createSearchIndexTO" access="package" returntype="searchIndexTO" output="false">
		<cfscript>
			var searchIndexTO = createObject("component", "searchIndexTO").init(argumentcollection=variables.instance);
			return searchIndexTO;
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// General Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="optimize" access="public" returntype="void" output="false">
		<cfcollection action="optimize" collection="#getCollection()#" />
	</cffunction>
	
	<cffunction name="refresh" access="public" returntype="void" output="false">
		<cfargument name="searchData" type="query" required="true" />
		<cfindex action="refresh" collection="#getCollection()#" type="custom" query="arguments.searchData" key="eventId" body="title, description" title="title" />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="searchData" type="query" required="true" />
		<cfindex action="update" collection="#getCollection()#" type="custom" query="arguments.searchData" key="eventId" body="title, description" title="title">
	</cffunction>	
	
</cfcomponent>