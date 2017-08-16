<!---// MODIFY THESE SETTINGS --->
<cfset PRODUCTION_MODE = false />
<cfset MACHII_CONFIG_MODE = -1 />
<cfset MACHII_CONFIG_PATH = "C:\projects\calendar\trunk\config\mach-ii.xml" />
<cfset MACHII_APP_KEY = "calendar" />

<cfif not PRODUCTION_MODE and structKeyExists(URL,"reloadApp")>
	<cfset MACHII_CONFIG_MODE = 1 />
</cfif>

<cfif not PRODUCTION_MODE and structKeyExists(URL,"clearcache")>
	<cfif isDefined("application.cache") and isStruct(application.cache)>
		<cfset structClear(application.cache) />
	</cfif>
</cfif>

<cfinclude template="/MachII/mach-ii.cfm" />