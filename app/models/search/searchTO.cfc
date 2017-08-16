<cfcomponent displayname="searchTO" access="public" hint="Search Tranfer Object">

	<cffunction name="init" access="public" returntype="searchTO" output="false" displayname="SearchTO Constructor" hint="Initializes the Search Transfer Object">
		<cfargument name="searchId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="criteria" type="string" required="false" default="" />
		<cfargument name="startDate" type="string" required="false" default="" />
		<cfargument name="endDate" type="string" required="false" default="" />
		<cfargument name="categories" type="string" required="false" default="" />

		<cfscript>
			this.searchId = arguments.searchId;
			this.criteria = arguments.criteria;
			this.startDate = arguments.startDate;
			this.endDate = arguments.endDate;
			this.categories = arguments.categories;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>