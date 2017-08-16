<h3 class="bp-subtitle">Infusion Technology Caching Mechanism</h3>

<div class="bp-text">

<p>ColdFusion MX took a huge step forward with the introduction of CF components, which created an object-oriented development mechanism for ColdFusion. By encapsulating functionality, it makes code reuse much easier and improves the ability to create more robust application frameworks.  Of course, it also has a down-side in that it creates more overhead during the instantiation of objects.  In order to counter this additional overhead, Infusion Technology has implemented an in-memory caching mechanism to improve the performance of ColdFusion applications.</p>

<p>The caching mechanism works on a fairly basic principle.	When an object is created, the  object data (along with some cache management information) is stored in memory.	When that object is modified, the in-memory object data is updated and must then be written to the database.	However, if object data is only being read, the data can be pulled directly from memory; there is no need to recreate the object and/or query the data from the database.	As long as the in-memory data and the database are synchronized, there is no reason the integrity of the data cannot be maintained.	Since the majority of interactions in calendarInfusion are <span style="font-weight:bold;">reading</span> data, this caching mechanism provides a significant increase in performance.</p>

<p>The actual mechanism used for cache storage is a ColdFusion struct.  Every object instantiated in an Infusion Technology application has a unique identifier (UUID) and this identifier is used as the key of the struct.  For each object there are two values stored:</p>

<ul>
	<li><span style="font-weight:bold;">lastAccessed</span> - the last date at which the object cache was accessed (read from or written to)</li>
	<li><span style="font-weight:bold;">object</span> - the actual object data</li>
</ul>

<p>When an object is created, the value of lastAccessed is set to the current time.	Whenever an object is accessed, the value of lastAccessed is again updated to the current time.	To manage the cache, calendarInfusion uses the special ColdFusion Application Framework OnRequestEnd.cfm file, which is called at the end of every request to a ColdFusion application.	Periodically (by default, every tenth request) the application will scan the cache and remove any objects that have not been access in a pre-defined period of time (by default, 180 seconds).	These parameters can be fine-tuned to improve the performance for a particular instance of calendarInfusion.</p>

<p>In order to take advantage of this cache, one coding standard was required: the instantiation of an object is always attempted using the &quot;load&quot; method.  When an object is instantiated using the &quot;load&quot; action, the object code uses the object <span class="bn-input">id</span> to search the cache.	 If the object is found in the cache, a pointer to the object is returned and all remaining &quot;load&quot; processing is bypassed, thus significantly reducing the overhead. If the object is not found in the cache, the code loads the object from the application database.</p>

<p>To tune the caching mechanism, the following values can be modified in the application.ini configuration file:</p>

<ul>
	<li>
		<span class="bn-input">global.calendar.cache.purgeCycle</span> (default, 10)<br>
		A number representing the period of application requests in which the cache should be scanned to purge the cache.	By default, the cache is purged on every tenth request. For a high-traffic website, this number may be increased to reduce the overhead associated with scanning the cache.<br><br>
	</li>
	<li>
		<span class="bn-input">global.calendar.cache.purgeAge</span> (default, 180)<br>
		The age (in seconds) at which an object in cache will be purged. Low-traffic websites may want to increase this value so that an object will remaining in the cache for a longer period of time. This will reduce the number of times object data must be queried directly from the application database.<br><br>
	</li>
</ul>

</div>