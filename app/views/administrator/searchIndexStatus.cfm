<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 SearchIndexStatusPanel::display
*
* Description:
*	 Display a panel showing the results of an action against a search index.
*	 (e.g. refresh, optimize, purge, repair)
*
****************************************************************************
--->

<cfparam name="request.executionTime" default="0">
<cfif len(arguments.event.getArg("action")) eq 0>
	<cfset indexAction = "(unknown)" />
<cfelse>
	<cfset indexAction = arguments.event.getArg("action") />
</cfif>
<cfparam name="attributes.contextId" default="">
<cfset searchIndexTO = request.searchIndex.getSearchIndexTO() />

<div class="bp-title"><cfoutput>#application.resource.bundle.text.search_index_management# - #application.resource.bundle.text.results#</cfoutput></div><br>

<table border="0" align="center" class="bpd-style">
	<tr class="bpd-title">
		<td colspan="2"><cfoutput>#application.resource.bundle.text.verity_manager#</cfoutput></td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%">
				<tr>
					<td>
						<cfoutput>
							<p>
								#application.resource.bundle.text.verity_results_1# &quot;<b>#indexAction#</b>&quot; #application.resource.bundle.text.verity_results_2#
								<cfif lCase(indexAction) eq "purge">#application.resource.bundle.text.verity_results_3#</cfif>
							</p>
							
							<p>
								<span style="font-weight:bold;">#application.resource.bundle.text.verity_collection#</span>: #searchIndexTO.collection#<br>
								<span style="font-weight:bold;">#application.resource.bundle.text.maintenance_action#</span>: #indexAction#<br>
								<span style="font-weight:bold;">#application.resource.bundle.text.processing_time#</span>: #evaluate(request.executionTime)# #application.resource.bundle.text.milliseconds_abbr#<br>
							</p>
						</cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>