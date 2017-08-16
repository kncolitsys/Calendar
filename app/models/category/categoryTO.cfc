<cfcomponent displayname="CategoryTO" access="public" hint="Category Tranfer Object">

	<cffunction name="init" access="public" returntype="categoryTO" output="false" displayname="CategoryTO Constructor" hint="Initializes the Category Transfer Object">
		<cfargument name="categoryId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="description" type="string" required="false" default="" />
		<cfargument name="bgColor" type="string" required="false" default="" />

		<cfscript>
			this.categoryId = arguments.categoryId;
			this.title = arguments.title;
			this.description = arguments.description;
			this.bgColor = arguments.bgColor;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>