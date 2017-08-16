<cfcomponent displayname="groupGateway_msaccess" extends="groupGateway">

	<!------------------------------------------------------------------------------------
	// CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="create" access="public" returntype="void" output="false">
		<cfargument name="group" type="group" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />
		
		<cfquery name="q_create_group" datasource="#variables.dsn#">
			INSERT INTO groups (
				groupId, groupName, comments,
				createDate, createBy,
				updateDate, updateBy
			) VALUES (
				'#trim(group.getGroupId())#', '#trim(group.getGroupName())#', '#trim(group.getComments())#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#',
				<cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>, '#trim(arguments.modifier)#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="group" output="false">
		<cfargument name="id" type="string" required="true" />
		
		<cfscript>
			object = findCacheItem(arguments.id);
			if (isObject(object)) { return object; }
		</cfscript>

		<!---// Query the group info and load it into a struct, then return it to the caller --->
		<cfquery name="q_read_group" datasource="#variables.dsn#">
			SELECT *
			FROM groups
			WHERE groupId = '#trim(arguments.id)#'
		</cfquery>

		<cfquery name="q_read_group_members" datasource="#variables.dsn#">
			SELECT u.*
			FROM users u INNER JOIN users_groups ug ON u.userDsid = ug.userDsid
			WHERE ug.groupDsid = #val(q_read_group.groupDsid)#
		</cfquery>
		
		<cfquery name="q_read_group_permissions" datasource="#variables.dsn#">
			SELECT r.privilege AS permission
			FROM rights r INNER JOIN groups_rights gr ON r.rightDsid = gr.rightDsid
			WHERE (r.calendarDsid IS NULL OR r.calendarDsid = 0)
			  AND gr.groupDsid = #val(q_read_group.groupDsid)#
			UNION
			SELECT (c.calendarId + '_' + r.privilege) AS permission
			FROM calendars c RIGHT JOIN (
				rights r INNER JOIN	groups_rights gr ON r.rightDsid = gr.rightDsid
			) ON r.calendarDsid = c.calendarDsid
			WHERE (r.calendarDsid IS NOT NULL AND r.calendarDsid <> 0)
			  AND gr.groupDsid = #val(q_read_group.groupDsid)#
		</cfquery>

		<cfif val(q_read_group.recordCount) gt 0>
			<cfscript>
				groupStruct = queryRowToStruct(q_read_group);
				memberStruct = queryToStruct(q_read_group_members,"userId");
				permissionStruct = queryToStruct(q_read_group_permissions,"permission");
				group = createObject("component","group").init(argumentcollection=groupStruct,members=memberStruct,permissions=permissionStruct);
				addCacheItem(group.getGroupId(), group);
				return group;
			</cfscript>
		<cfelse>
			<cfthrow type="GROUP.MISSING" message="The requested group does not exist" detail="Group ID: #arguments.id#">
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="group" type="group" required="true" />
		<cfargument name="date" type="date" required="false" default="#now()#" />
		<cfargument name="modifier" type="string" required="false" default="00000000-0000-0000-0000000000000000" />

		<cfquery name="q_update_group" datasource="#variables.dsn#">
			UPDATE groups
			SET
				groupName = '#trim(group.getGroupName())#',
				comments = '#trim(group.getComments())#',
				updateDate = <cfif isDate(arguments.date)>#createOdbcDateTime(arguments.date)#<cfelse>NULL</cfif>,
				updateBy = '#trim(arguments.modifier)#'
			WHERE
				groupId = '#trim(group.getGroupId())#'
		</cfquery>
		<cfset removeCacheItem(arguments.group.getGroupId()) />
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="string" required="true" />

		<cfquery name="q_delete_group" datasource="#variables.dsn#">
			DELETE FROM groups
			WHERE groupId = '#trim(arguments.id)#'
		</cfquery>
		<cfset removeCacheItem(arguments.id) />
	</cffunction>
	
	<!------------------------------------------------------------------------------------
	// Non-CRUD methods
	------------------------------------------------------------------------------------->

	<cffunction name="getGroups" access="public" returntype="query">
		<cfquery name="q_groups" datasource="#variables.dsn#">
			SELECT *
			FROM groups
		</cfquery>
		<cfreturn q_groups />
	</cffunction>

	<cffunction name="updateMembers" access="public" returntype="void" output="false">
		<cfargument name="groupId" type="string" required="true" />
		<cfargument name="members" type="string" required="true" />

		<cfif listLen(arguments.members) gt 0>
			<cfquery name="q_groupDsid" datasource="#variables.dsn#">
				SELECT groupDsid
				FROM groups
				WHERE groupId = '#trim(arguments.groupId)#'
			</cfquery>
			<cfquery name="q_delete_members" datasource="#variables.dsn#">
				DELETE FROM users_groups
				WHERE groupDsid = #val(q_groupDsid.groupDsid)#
			</cfquery>
			<cfloop index="userId" list="#arguments.members#">
				<cfquery name="q_userDsid" datasource="#variables.dsn#">
					SELECT userDsid
					FROM users
					WHERE userId = '#trim(userId)#'
				</cfquery>
				<cfquery name="q_update_group_members" datasource="#variables.dsn#">
					INSERT INTO users_groups (groupDsid, userDsid)
					VALUES (#val(q_groupDsid.groupDsid)#, #val(q_userDsid.userDsid)#)
				</cfquery>		
			</cfloop>
		</cfif>
		<cfset removeCacheItem(arguments.groupId) />
	</cffunction>
	
	<cffunction name="updatePermissions" access="public" returntype="void" output="false">
		<cfargument name="groupId" type="string" required="true" />
		<cfargument name="context" type="string" required="true" />
		<cfargument name="contextId" type="string" required="true" />
		<cfargument name="permissions" type="string" required="false" default="" />

		<cfif listLen(arguments.permissions) gt 0>
			<!---// Find the groupDsid to simplify the rest of the queries --->
			<cfquery name="q_groupDsid" datasource="#variables.dsn#">
				SELECT groupDsid
				FROM groups
				WHERE groupId = '#trim(arguments.groupId)#'
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

			<!---// Delete the existing permissions for this group and context --->
			<cfquery name="q_delete_members" datasource="#variables.dsn#">
				DELETE FROM groups_rights
				WHERE groupDsid = #val(q_groupDsid.groupDsid)#
				  AND rightDsid IN (SELECT rightDsid FROM rights WHERE calendarDsid = #val(contextDsid)#)
			</cfquery>

			<!---// Finally, loop through the permissions and grant them to the group --->			
			<cfloop index="permission" list="#arguments.permissions#">
				<cfquery name="q_rightDsid" datasource="#variables.dsn#">
					SELECT rightDsid
					FROM rights
					WHERE privilege = '#trim(permission)#'
					  AND calendarDsid = #val(contextDsid)#
				</cfquery>
				<cfquery name="q_update_group_members" datasource="#variables.dsn#">
					INSERT INTO groups_rights (groupDsid, rightDsid)
					VALUES (#val(q_groupDsid.groupDsid)#, #val(q_rightDsid.rightDsid)#)
				</cfquery>		
			</cfloop>
		</cfif>
		<cfset removeCacheItem(arguments.groupId) />
	</cffunction>

</cfcomponent>