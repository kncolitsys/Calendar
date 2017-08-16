<!--- 
VALIDATIONLIB 20021110
(c) Electric Sheep Web 2002
---------------------------

INDEX

isIPAddress( str )
	Check str is a correctly formatted IP address
		
isRGBTriplet( str[, websafe] )
	Check str is a valid HTML colour triplet. If websafe is true, check that
	it is a web-safe colour.
			
isSocialSecurityNumber( str )
	Check str is a correctly formatted US social security number

isUKPostcode( str )
	Check str is a correctly formatted UK postcode

isUSZipCode( str )
	Check str is a correctly formatted US ZIP code

isUUID( str )
	Check str is a correctly formatted UUID (universally unique identifier)
				
--->		

<cfcomponent>

	<cffunction name="init" access="public" returntype="validationLib" output="false">
		<cfreturn this />
	</cffunction>

	<cffunction name="isIPAddress" access="public" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true" />
		<cfscript>
			// isIPAddress( str )
			// Check str is a correctly formatted IP address
			return yesNoFormat(reFindNoCase("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$", trim(arguments.str)));
		</cfscript>
	</cffunction>

	<cffunction name="isRGBTriplet" access="public" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true" />
		<cfargument name="websafe" type="boolean" required="false" default="false" />
		<cfscript>
			// isRGBTriplet( str[, websafe] )
			// Check str is a valid HTML colour triplet. If websafe is true, check that
			// it is a web-safe colour.
			if ( ( arrayLen(arguments) gt 1 ) and ( arguments[2] ) )
				return yesNoFormat(reFindNoCase("^##?(00|33|66|99|cc|ff){3}$", trim(arguments.str)));
			else
				return yesNoFormat(reFindNoCase("^##?[[:digit:]a-f]{6}$", trim(arguments.str)));
		</cfscript>
	</cffunction>

	<cffunction name="isSocialSecurityNumber" access="public" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true" />
		<cfscript>
			// isSocialSecurityNumber( str )
			// Check str is a correctly formatted US social security number
			return yesNoFormat(reFindNoCase("^[0-9]{3}[ -][0-9]{2}[ -][0-9]{4}$", trim(arguments.str)));
		</cfscript>
	</cffunction>

	<cffunction name="isUKPostcode" access="public" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true" />
		<cfscript>
			// isUKPostcode( str )
			// Check str is a correctly formatted UK postcode
			return yesNoFormat(reFindNoCase("^[A-Z]{1,2}[0-9]{1,2}[A-Z]{0,1} [0-9][A-Z]{2}$", trim(arguments.str)));
		</cfscript>
	</cffunction>

	<cffunction name="isUSPostcode" access="public" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true" />
		<cfscript>
			// isUSZipCode( str )
			// Check str is a correctly formatted ZIP code
			return yesNoFormat(reFindNoCase("^[0-9]{5}([ -][0-9]{4})?$", trim(arguments.str)));
		</cfscript>
	</cffunction>
	
	<cffunction name="isUUID" access="public" returntype="boolean" output="false">
		<cfargument name="str" type="string" required="true" />
		<cfscript>
			// isUUID( str )
			// Check str is a correctly formatted UUID (universally unique identifier)
			return yesNoFormat(reFindNoCase("^[[:digit:]a-f]{8}-[[:digit:]a-f]{4}-[[:digit:]a-f]{4}-[[:digit:]a-f]{16}$", trim(arguments.str)));
		</cfscript>
	</cffunction>
</cfcomponent>
