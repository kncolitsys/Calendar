<cfcomponent displayname="calendar_test" extends="net.sourceforge.cfunit.framework.TestCase">
	<cfproperty name="oCalendar" type="calendar.models.calendar.calendar">
	
	<cffunction name="setup" returntype="void" access="public">
		<cfset variables.oCalendar = createObject("component", "calendar.models.calendar.calendar").init()>
	</cffunction>
	
	<cffunction name="testSetCalendarId" returntype="void" access="public">
		<cfset uuid = createUuid() />
		<cfset result = variables.oCalendar.setCalendarId(uuid) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#uuid#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getCalendarId()#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="testSetTitle" returntype="void" access="public">
		<cfset title = "My Test Calendar" />
		<cfset result = variables.oCalendar.setTitle(title) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#title#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getTitle()#">
		</cfinvoke>
	</cffunction>

	<cffunction name="testSetStatus" returntype="void" access="public">
		<cfset title = "My Test Calendar" />
		<cfset result = variables.oCalendar.setTitle(title) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#title#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getTitle()#">
		</cfinvoke>
	</cffunction>

	<cffunction name="testSetDescription" returntype="void" access="public">
		<cfset desc = "Calendar for the masses" />
		<cfset result = variables.oCalendar.setDescription(desc) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#desc#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getDescription()#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="testSetHeader" returntype="void" access="public">
		<cfset header = "<div>My Header</div>" />
		<cfset result = variables.oCalendar.setHeader(header) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#header#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getHeader()#">
		</cfinvoke>
	</cffunction>
	
	<cffunction name="testSetFooter" returntype="void" access="public">
		<cfset footer = "<div>My Footer</div>" />
		<cfset result = variables.oCalendar.setFooter(footer) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#footer#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getFooter()#">
		</cfinvoke>
	</cffunction>
		
	<cffunction name="testSetExitUrl" returntype="void" access="public">
		<cfset exiturl = "http://localhost/" />
		<cfset result = variables.oCalendar.setExitUrl(exiturl) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#exiturl#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getExitUrl()#">
		</cfinvoke>
	</cffunction>
		
	<cffunction name="testSetScheme" returntype="void" access="public">
		<cfset scheme = createobject('component','calendar.models.scheme.scheme').init() />
		<cfset result = variables.oCalendar.setScheme(scheme) />
		<cfinvoke method="assertEquals">
			<cfinvokeargument name="expected" value="#scheme#">
			<cfinvokeargument name="actual" value="#variables.oCalendar.getScheme()#">
		</cfinvoke>
	</cffunction>
		
</cfcomponent>