<cfcomponent displayname="searchIndexTO" access="public" hint="SearchIndex Tranfer Object">

	<cffunction name="init" access="public" returntype="searchIndexTO" output="false" displayname="SearchIndexTO Constructor" hint="Initializes the SearchIndex Transfer Object">
		<cfargument name="searchIndexId" type="string" required="false" default="#createUuid()#" />		
		<cfargument name="title" type="string" required="false" default="" />
		<cfargument name="collection" type="string" required="false" default="" />
		<cfargument name="path" type="string" required="false" default="" />
		<cfargument name="language" type="string" required="false" default="" />

		<cfscript>
			this.searchIndexId = arguments.searchIndexId;
			this.title = arguments.title;
			this.collection = arguments.collection;
			this.path = arguments.path;
			this.language = arguments.language;
			return this;
		</cfscript>
	</cffunction>

</cfcomponent>