<h3 class="bp-subtitle">Administer Schemes</h3>

<div class="bp-text">
<p>Schemes are simply cascading stylesheets that allow Calendar Editors to manage the various fonts, colors, et cetera used in the calendarInfusion interface.	Virtually every element within the calendarInfusion interface has a class associated with it and these classes can be modified using the scheme stylesheets.	There are two types of schemes: global schemes and local schemes.	Global schemes are created using the Administrator Tool and are available to every calendar.	Local schemes are created using the Editor Tool and are available only to the calendar in which the scheme was created.	calendarInfusion ships with a number of pre-defined global schemes.</p>

<p>If the CFFILE ColdFusion tag is enabled, the scheme is stored both within the database and on the filesystem.	The preferred location is to pull the scheme from the filesystem, as this allows a web browser to cache the stylesheet file itself.	If the CFFILE is not enabled or an error occurs creating (or reading) the stylesheet on the filesystem, the stylesheet can still be queried from the database.</p>

<p><span class="bn-input">Create a new scheme</span><br>
	To create a new scheme, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Schemes</span> link in the navigation menu.</li>
		<li>Verify that <span class="bn-input">Create a new scheme</span> is selected in the selection list and click the Edit button.</li>
		<li>Enter the appropriate scheme name and stylesheet information.</li>
		<li>Click the <span class="bn-input">OK</span> button.</li>
	</ol>
</p>

<p><span class="bn-input">Modify an existing scheme</span><br>
	To modify an existing scheme, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Schemes</span> link in the navigation menu.</li>
		<li>In the selection list, choose the scheme to be modified.
		<li>Click the <span class="bn-input">Edit</span> button.</li>
		<li>Make the necessary changes.</li>
		<li>Click the <span class="bn-input">OK</span> button.</li>
	</ol>
</p>

<p><span class="bn-input">Delete an existing scheme</span><br>
	To delete an existing scheme, follow these steps:
	<ol>
		<li>Click on the <span class="bn-input">Schemes</span> link in the navigation menu.</li>
		<li>In the selection list, choose the scheme to delete.
		<li>Click the <span class="bn-input">Edit</span> button.</li>
		<li>Click the <span class="bn-input">Delete</span> button.</li>
		<li>When prompted to verify the deletion, click the <span class="bn-input">OK</span> button.</li>
	</ol>
</p>
</div>