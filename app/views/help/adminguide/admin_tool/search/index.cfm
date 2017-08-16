<h3 class="bp-subtitle">Administer the Verity Search Engine</h3>

<div class="bp-text">
<p>calendarInfusion uses the Verity Search Engine (included with ColdFusion Server) to provide search capabilities for each calendar.	If the search functionality is enabled, a new search collection is created whenever a new calendar is created.	Each calendar has one (and only one) search collection associated with it.	Although calendarInfusion should manage all of the collections automatically, it may occasionally be necessary to manually re-index or repair these collections.	The Administrator Tool provides this capability.</p>

<p><span class="bn-input">To manage a Verity search collection</span><br>
	To manage a Verity search collection, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Search</span> link in the navigation menu.</li>
		<li>In the selection list, choose the <span class="bn-input">calendar</span> associated with the search collection you wish to manage.
		<li>Click the <span class="bn-input">Edit</span> button.</li>
		<li>Click the appropriate button to manage the collection:
			<ul>
				<li><span class="bn-input">Refresh</span> - Purges and rebuilds a search collection.</li>
				<li><span class="bn-input">Update</span> - Adds new records to the search index.	However, it does not change the data for existing records.</li>
				<li><span class="bn-input">Optimize</span> - Re-organizes a search collection to improve performance.	For large collections, this may take some time, so it should be done during off-peak hours if possible.</li>
				<li><span class="bn-input">Repair</span> - In those rare circumstances where the internal Verity search indexes become corrupt, repairing a search collection should be able to get the collection back up and running.</li>
			</ul>
		</li>
	</ol>
</p>
</div>