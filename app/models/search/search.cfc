<cfcomponent displayname="search">

	<cfset variables.instance.searchId = createUuid() />
	<cfset variables.instance.criteria = "" />
	<cfset variables.instance.startDate = "" />
	<cfset variables.instance.endDate = "" />
	<cfset variables.instance.categories = "" />
	
	<cffunction name="init" access="public" returntype="search" output="false">
		<cfargument name="searchId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="criteria" type="string" required="false" default="" />
		<cfargument name="startDate" type="string" required="false" default="" />
		<cfargument name="endDate" type="string" required="false" default="" />
		<cfargument name="categories" type="string" required="false" default="" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" access="public" returntype="void" output="false">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setSearchId(arguments.info.searchId);
			setCriteria(arguments.info.criteria);
			setStartDate(arguments.info.startDate);
			setEndDate(arguments.info.endDate);
			setCategories(arguments.info.categories);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setSearchId" access="public" returntype="void" output="false">
		<cfargument name="searchId" type="string" required="true" />
		<cfset variables.instance.searchId = arguments.searchId />
	</cffunction>
	<cffunction name="getSearchId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.searchId />
	</cffunction>
	
	<cffunction name="setCriteria" access="public" returntype="void" output="false">
		<cfargument name="criteria" type="string" required="true" />
		<cfset variables.instance.criteria = arguments.criteria />
	</cffunction>
	<cffunction name="getCriteria" access="public" returntype="string" output="false">
		<cfreturn variables.instance.criteria />
	</cffunction>
	
	<cffunction name="setStartDate" access="public" returntype="void" output="false">
		<cfargument name="startDate" type="string" required="true" />
		<cfset variables.instance.startDate = arguments.startDate />
	</cffunction>
	<cffunction name="getStartDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.startDate />
	</cffunction>
	
	<cffunction name="setEndDate" access="public" returntype="void" output="false">
		<cfargument name="endDate" type="string" required="true" />
		<cfset variables.instance.endDate = arguments.endDate />
	</cffunction>
	<cffunction name="getEndDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.endDate />
	</cffunction>
	
	<cffunction name="setCategories" access="public" returntype="void" output="false">
		<cfargument name="categories" type="string" required="true" />
		<cfset variables.instance.categories = arguments.categories />
	</cffunction>
	<cffunction name="getCategories" access="public" returntype="string" output="false">
		<cfreturn variables.instance.categories />
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getSearchTO" access="public" returntype="searchTO" output="false">
		<cfreturn createSearchTO() />
	</cffunction>
			
	<cffunction name="setSearchFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="searchTO" type="searchTO" required="true" />		
		<cfscript>
			setSearchId(arguments.searchTO.searchId);
			setCriteria(arguments.searchTO.criteria);
			setStartDate(arguments.searchTO.startDate);
			setEndDate(arguments.searchTO.endDate);
			setCategories(arguments.searchTO.categories);
		</cfscript>
	</cffunction>
	
	<cffunction name="createSearchTO" access="package" returntype="searchTO" output="false">
		<cfscript>
			var searchTO = createObject("component", "searchTO").init(argumentcollection=variables.instance);
			return searchTO;
		</cfscript>
	</cffunction>
	
</cfcomponent>