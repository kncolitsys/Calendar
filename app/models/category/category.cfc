<cfcomponent displayname="Category">

	<cfset variables.instance.categoryId = createUuid() />
	<cfset variables.instance.title = "" />
	<cfset variables.instance.description = "" />
	<cfset variables.instance.bgColor = "" />
	
	<cffunction name="init">
		<cfargument name="categoryId" type="string" required="false" default="#createUuid()#" />
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="bgColor" type="string" required="false" default="" />
		
		<cfinvoke component="#this#" method="setInfo" info="#arguments#" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setInfo" returntype="void" access="public">
		<cfargument name="info" type="struct" required="true" />
		
		<cfscript>
			setCategoryId(arguments.info.categoryId);
			setTitle(arguments.info.title);
			setDescription(arguments.info.description);
			setBgColor(arguments.info.bgColor);
		</cfscript>
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Object Getter/Setter methods
	------------------------------------------------------------------------------------->

	<cffunction name="setCategoryId" access="public" returntype="void" output="false">
		<cfargument name="categoryId" type="string" required="true" />
		<cfset variables.instance.categoryId = arguments.categoryId />
	</cffunction>
	<cffunction name="getCategoryId" access="public" returntype="string" output="false">
		<cfreturn variables.instance.categoryId />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.title />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="description" type="string" required="true" />
		<cfset variables.instance.description = arguments.description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.description />
	</cffunction>
	
	<cffunction name="setBgColor" access="public" returntype="void" output="false">
		<cfargument name="bgColor" type="string" required="true" />
		<cfset variables.instance.bgColor = arguments.bgColor />
	</cffunction>
	<cffunction name="getBgColor" access="public" returntype="string" output="false">
		<cfreturn variables.instance.bgColor />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Transfer Object methods
	------------------------------------------------------------------------------------->
	
	<cffunction name="getCategoryTO" access="public" returntype="categoryTO" output="false">
		<cfreturn createCategoryTO() />
	</cffunction>
			
	<cffunction name="setCategoryFromTO" access="public" returntype="void" output="false" hint="set the instance data from TO">
		<cfargument name="categoryTO" type="categoryTO" required="true" />		
		<cfscript>
			setCategoryId(arguments.categoryTO.categoryId);
			setTitle(arguments.categoryTO.title);
			setDescription(arguments.categoryTO.description);
			setBgColor(arguments.categoryTO.bgColor);
		</cfscript>
	</cffunction>
	
	<cffunction name="createCategoryTO" access="package" returntype="categoryTO" output="false">
		<cfscript>
			var categoryTO = createObject("component", "categoryTO").init(argumentcollection=variables.instance);
			return categoryTO;
		</cfscript>
	</cffunction>
</cfcomponent>