<cfcomponent displayname="category_test" extends="net.sourceforge.cfunit.framework.TestCase">
	<cfproperty name="oCategory" type="calendar.models.category.category">
	
	<cffunction name="setup" returntype="void" access="public">
		<cfset variables.oCategory = createObject("component", "calendar.models.category.category").init()>
	</cffunction>
	
	<cffunction name="testSetCategoryId" returntype="void" access="public">
		<cfset uuid = createUuid() />
		<cfset result = variables.oCategory.setCategoryId(uuid) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#uuid#">
			<cfinvokeargument name="actual" value="#variables.oCategory.getCategoryId()#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="testSetTitle" returntype="void" access="public">
		<cfset title = "My Test Category" />
		<cfset result = variables.oCategory.setTitle(title) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#title#">
			<cfinvokeargument name="actual" value="#variables.oCategory.getTitle()#">
		</cfinvoke>
	</cffunction>

	<cffunction name="testSetBgColor" returntype="void" access="public">
		<cfset bgcolor = "ffffff" />
		<cfset result = variables.oCategory.setBgColor(bgcolor) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#bgcolor#">
			<cfinvokeargument name="actual" value="#variables.oCategory.getBgColor()#">
		</cfinvoke>
	</cffunction>

	<cffunction name="testSetDescription" returntype="void" access="public">
		<cfset desc = "Category for the masses" />
		<cfset result = variables.oCategory.setDescription(desc) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#desc#">
			<cfinvokeargument name="actual" value="#variables.oCategory.getDescription()#">
		</cfinvoke>
	</cffunction>

</cfcomponent>