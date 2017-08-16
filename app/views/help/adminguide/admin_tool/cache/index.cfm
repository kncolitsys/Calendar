<h3 class="bp-subtitle">Using the Application Cache Tool</h3>

<div class="bp-text">
<p>One of the improvements made to the cfObjects framework by Infusion Technology was the integration of an object instance caching mechanism.	This cache stores object instance data in memory, as opposed to constantly reading this data from a database.	Whenever updates are made to the object, the data is flushed to the database (and persistent storage), but most &quot;reads&quot; and instantiations of objects can be done by simply accessing the in-memory cache.	This provides a significant performance increase to the calendarInfusion application.</p>

<p>The application cache is both request-based and time-based.	Every time an object is instantiated or one its methods is called, a timestamp is updated to reflect the &quot;age&quot; of the cached instance.	Periodically, a clean-up method is called that removes all instances from the cache that are older than a specified age.	This provides a high level of certainty that the cache and the database are synchronized.	By default, the clean-up method is called on every fifth calendarInfusion HTTP request and instances that are older than 120 seconds are removed from the cache.</p>

<p>The Application Cache Tool provides a basic mechanism for managing the application cache.	It allows an Administrator to view all of the object instances that are currently stored in the cache.	It also allows the Administrator to manually remove an object from the cache, if necessary (e.g. an error condition has caused the cache to get out of sync with the database).</p>

<p><span class="bn-input">View the application cache</span><br>
	To view the list of objects (or a specific object) within the application cache, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Cache</span> link in the navigation menu.</li>
		<li>A selection list will be displayed with a list of objects contained in the cache.	Each item in the list will display the object type (in parentheses) and the unique object identifier (OID).</li>
		<li>To view an individual object (and its associated properties), select the object from the selection list and click the <span class="bn-input">Get Object</span> button.</li>
	</ol>
</p>

<p><span class="bn-input">Delete an object from the application cache</span><br>
	Some rare circumstances may require the Administrator to manually delete an object instance from the application cache.	This can be accomplished by following these steps:
	<ol>
		<li>Click on the <span class="bn-input">Cache</span> link in the navigation menu.</li>
		<li>In the selection list, select the object to be deleted.</li>
		<li>Click the <span class="bn-input">Get Object</span> button.</li>
		<li>Once the object is displayed, click the <span class="bn-input">Delete from Cache</span> button.</li>
	</ol>
	This procedure does <span style="font-weight:bold;">not</span> delete the actual object instance.	It only removes the instance from the application cache.	The next time the object is instantiated, the object will be reloaded from information stored in the calendarInfusion database and, once again, stored in the cache.
</p>
</div>