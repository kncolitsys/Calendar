<h3 class="bp-subtitle">Embedding calendarInfusion Views in External Applications (using CFHTTP)</h3>

<div class="bp-text">
<p>While calendarInfusion is designed primarily as a standalone web application, it may be desired to integrate event information into an external website.	calendarInfusion provides limited functionality to allow this using the ColdFusion CFHTTP tag.</p>

<p>calendarInfusion currently has three basic display specifications:</p>

<ul>
	<li>
		<span style="font-weight:bold;">Display Type</span> - standard, http, embed<br>
	</li>
	<li>
		<span style="font-weight:bold;">Format Type</span> - calendar, list<br>
	</li>
	<li>
		<span style="font-weight:bold;">View Type</span> - year, month, list, day<br>
	</li>
</ul>
 
<p>Any combination of these specifications will provide a view of the event information.	The &quot;http&quot; display type provides a full-sized view of the calendar that is designed to be displayed on its own webpage outside of the calendarInfusion application.	The &quot;embed&quot; display type provides a small view of the calendar that is designed to be embedded into a section of another webpage.	An example of the code required to use an embedded calendarInfusion display follows:</p>

<div style="padding-left:30px;">
<code>
	&lt;!-- external website HTML code --&gt;<br>
	<br>
	&lt;cfhttp method="post" url="http://localhost/calendar/public/calendar/index.cfm"&gt;<br>
	&nbsp;&nbsp;&lt;cfhttpparam name="cid" type="formfield" value="4D24E3D02B0B44348EB9559F514F0BC8"&gt;<br>
	&nbsp;&nbsp;&lt;cfhttpparam name="displayType" type="formfield" value="http"&gt;<br>
	&nbsp;&nbsp;&lt;cfhttpparam name="format" type="formfield" value="list"&gt;<br>
	&nbsp;&nbsp;&lt;cfhttpparam name="viewType" type="formfield" value="week"&gt;<br>
	&nbsp;&nbsp;&lt;cfhttpparam name="calendarDate" type="formfield" value="#now()#"&gt;<br>
	&nbsp;&nbsp;&lt;cfhttpparam name="filter" type="formfield" value=""&gt;<br>
	&lt;/cfhttp&gt;<br>
	<br>
	&lt;cfoutput&gt;#cfhttp.filecontent#&lt;/cfoutput&gt;<br>
	<br>
	&lt;!-- external website HTML code --&gt;<br>
</code>
</div>

<p>The HTTP parameters that may be passed are:</p>

<ul>
	<li><span style="font-weight:bold;">cid</span> - the ID of the calendar of interest<br></li>
	<li><span style="font-weight:bold;">displayType</span> - the type of display to use. Should be &quot;http&quot; or &quot;embed&quot;<br></li>
	<li><span style="font-weight:bold;">format</span> - the format to display (list, calendar)<br></li>
	<li><span style="font-weight:bold;">viewType</span> - the view to display (year, month, week, day)<br></li>
	<li><span style="font-weight:bold;">calendarDate</span> - the day to display.	Note: If a viewType of year, month, or week is specified, the appropriate view which <span style="font-weight:bold;">contains</span> the calendarDate will be displayed.<br></li>
	<li><span style="font-weight:bold;">filter</span> - a mechanism to filter the events that are displayed.	Currently, events may only be filtered by category.	To filter by categories, the filter value should be set to &quot;categories:XXX,YYY,ZZZ&quot;, where XXX,YYY,ZZZ represents a comma-delimited list of category IDs to display.	For example: &quot;categories:F40BF1C9-C1E8-46BF-A0C057372098C794,AC0BF1D9-C124-46BF-AAD037322098C772&quot;.	To display all events, simply leave this value blank.<br></li>
</ul>

</div>