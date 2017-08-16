<cfcomponent displayname="userGateway_msaccess" extends="userGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="user" type="user" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_user" datasource="#variables.dsn#">
			INSERT INTO users (
				userId, firstName, lastName,
				phoneHome, email, comments,
				userlogin, userpassword, timezone,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(user.getUserId())#', '#trim(user.getFirstName())#', '#trim(user.getLastName())#',
				'#trim(user.getPhone())#', '#trim(user.getEmail())#', '#trim(user.getComments())#',
				'#trim(user.getUsername())#', '#trim(user.getPassword())#', '#trim(user.getTimezone())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="user" output="false">
		<cfargument name="id" type="string" required="true" />

		<!---// Query the user info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_user" datasource="#variables.dsn#">
			SELECT *
			FROM users
			WHERE userId = '#trim(arguments.id)#'
		</cfquery>

		<cfquery name="q_read_user_permissions" datasource="#variables.dsn#">
			SELECT r.privilege AS permission
			FROM rights r INNER JOIN users_rights ur ON r.rightDsid = ur.rightDsid
			WHERE (r.calendarDsid IS NULL OR r.calendarDsid = 0)
			  AND ur.userDsid = #val(q_read_user.userDsid)#
			UNION
			SELECT (c.calendarId + '_' + r.privilege) AS permission
			FROM calendars c RIGHT JOIN (
				rights r INNER JOIN users_rights ur ON r.rightDsid = ur.rightDsid
			) ON r.calendarDsid = c.calendarDsid
			WHERE (r.calendarDsid IS NOT NULL AND r.calendarDsid <> 0)
			  AND ur.userDsid = #val(q_read_user.userDsid)#
		</cfquery>

		<cfif val(q_read_user.recordCount) gt 0>
			<cfscript>
				userStruct = queryRowToStruct(q_read_user);
				permissionStruct = queryToStruct(q_read_user_permissions,"permission");
				user = createObject("component","user").init(argumentcollection=userStruct,username=userStruct.userlogin,password=userStruct.userpassword,permissions=permissionStruct);
				addCacheItem(user.getUserId(), user);
				return user;
			</cfscript>
		<cfelse>
			<cfthrow type="USER.MISSING" message="The requested user does not exist" detail="User ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="user" type="user" required="true" />
		<cfargument name="password" type="string" required="false" default="" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_user" datasource="#variables.dsn#">
			UPDATE users
			SET
				firstName = '#trim(user.getFirstName())#',
				lastName = '#trim(user.getLastName())#',
				phoneHome = '#trim(user.getPhone())#',
				email = '#trim(user.getEmail())#',
				comments = '#trim(user.getComments())#',
				userlogin = '#trim(user.getUsername())#',
				<cfif len(arguments.password) gt 0>userpassword = '#trim(arguments.password)#',</cfif>
				timezone = '#trim(user.getTimezone())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				userId = '#trim(user.getUserId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.user.getUserId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_user" datasource="#variables.dsn#">
			DELETE FROM users
			WHERE userId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>

	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="authenticateUser" access="public" returntype="boolean" output="false">
		<cfargument name="username" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		
		<cfquery name="q_user" datasource="#variables.dsn#">
			SELECT *
			FROM users
			WHERE userlogin = '#trim(arguments.username)#'
			  AND userpassword = '#trim(arguments.password)#'
		</cfquery>
		<cfreturn val(q_user.recordCount) eq 1 />
	</cffunction>

	<cffunction name="getUserByUsername" access="public" returntype="calendar.models.user.user" output="false">
		<cfargument name="username" type="string" required="true" />
		
		<cfquery name="q_user" datasource="#variables.dsn#">
			SELECT userId
			FROM users
			WHERE userlogin = '#trim(arguments.username)#'
		</cfquery>
		<cfreturn read(id=q_user.userId) />
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfquery name="q_users" datasource="#variables.dsn#">
			SELECT *
			FROM users
		</cfquery>
		<cfreturn q_users />
	</cffunction>

	<cffunction name="updatePermissions" access="public" returntype="void" output="false">
		<cfargument name="userId" type="string" required="true" />
		<cfargument name="context" type="string" required="true" />
		<cfargument name="contextId" type="string" required="true" />
		<cfargument name="permissions" type="string" required="false" default="" />

		<cfif listLen(arguments.permissions) gt 0>
			<!---// Find the userDsid to simplify the rest of the queries --->
			<cfquery name="q_userDsid" datasource="#variables.dsn#">
				SELECT userDsid
				FROM users
				WHERE userId = '#trim(arguments.userId)#'
			</cfquery>

			<!---// Determine the appropriate contextId --->
			<cfswitch expression="#lCase(contextType)#">
				<cfcase value="application">
					<cfset contextDsid = 0 />				
				</cfcase>
				<cfcase value="calendar">
					<cfquery name="q_contextDsid" datasource="#variables.dsn#">
						SELECT calendarDsid AS contextDsid
						FROM calendars
						WHERE calendarId = '#trim(arguments.contextId)#'
					</cfquery>
					<cfset contextDsid = q_contextDsid.contextDsid />
				</cfcase>
			</cfswitch>

			<!---// Delete the existing permissions for this user and context --->
			<cfquery name="q_delete_members" datasource="#variables.dsn#">
				DELETE FROM users_rights
				WHERE userDsid = #val(q_userDsid.userDsid)#
				  AND rightDsid IN (SELECT rightDsid FROM rights WHERE calendarDsid = #val(contextDsid)#)
			</cfquery>

			<!---// Finally, loop through the permissions and grant them to the user --->			
			<cfloop index="permission" list="#arguments.permissions#">
				<cfquery name="q_rightDsid" datasource="#variables.dsn#">
					SELECT rightDsid
					FROM rights
					WHERE privilege = '#trim(permission)#'
					  AND calendarDsid = #val(contextDsid)#
				</cfquery>
				<cfquery name="q_update_user_members" datasource="#variables.dsn#">
					INSERT INTO users_rights (userDsid, rightDsid)
					VALUES (#val(q_userDsid.userDsid)#, #val(q_rightDsid.rightDsid)#)
				</cfquery>		
			</cfloop>
		</cfif>
		<cfset removeCacheItem(arguments.userId) />
	</cffunction>

</cfcomponent>