<h3 class="bp-subtitle">Creating Custom Schemes</h3>

<div class="bp-text">
<p>The colors and layout of calendarInfusion are managed using &quot;schemes,&quot; which are simply cascading style sheets designed for calendarInfusion.	There are a number of schemes included with calendarInfusion, but custom schemes can also be created to better integrate calendarInfusion into the design of your website.	Schemes use the following hierarchy to identify particular portions of the calendarInfusion user interface:</p>

<ul>
	<li>Body (b)
		<ul>
			<li>style</li>
			<li>Header (h)
				<ul>
					<li>style</li>
				</ul>
			</li>
			<li>Page (p)
				<ul>
					<li>style</li>
					<li>title</li>
					<li>subtitle</li>
					<li>Dialog (d)
						<ul>
							<li>style</li>
							<li>title</li>
							<li>subtitle</li>
						</ul>
					</li>
				</ul>
			</li>
			</li>
			<li>Calendar (c)
				<ul>
					<li>style</li>
					<li>title</li>
					<li>header</li>
					<li>time</li>
					<li>weekday</li>
					<li>weekend</li>
					<li>workhours</li>
					<li>afterhours</li>
					<li>alternate1</li>
					<li>alternate2</li>
					<li>event</li>
					<li>Category (c)
						<ul>
							<li>style</li>
						</ul>
					</li>
					<li>Day (d)
						<ul>
							<li>style</li>
							<li>active</li>
							<li>inactive</li>
							<li>empty</li>
						</ul>
					</li>
					<li>Title (t)
						<ul>
							<li>style</li>
							<li>event</li>
							<li>holiday</li>
							<li>time</li>
							<li>smallevent</li>
							<li>smallholiday</li>
							<li>smalltime</li>
							<li>printevent</li>
							<li>printholiday</li>
							<li>printtime</li>
						</ul>
					</li>
					<li>Menu (m)
						<ul>
							<li>style</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>Event (e)
				<ul>
					<li>style</li>
					<li>title</li>
					<li>description</li>
					<li>heading</li>
				</ul>
			</li>
			<!--- <li>Login (l)</li> --->
 <!---			<li>Menu (m)
				<ul>
					<li>Navigation Menu (n)
						<ul>
							<li>style</li>
							<li>title</li>
							<li>link</li>
							<li>link:hover</li>
							<li>link:visited</li>
							<li>link:visited:hover</li>
							<li>link:active</li>
							<li>text</li>
						</ul>
					</li>
					<li>Administration Menu (a)
						<ul>
							<li>style</li>
							<li>cell</li>
							<li>separator</li>
							<li>link</li>
							<li>link:hover</li>
							<li>link:visited</li>
							<li>link:visited:hover</li>
							<li>link:active</li>
							<li>text</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>Profile (u)</li>
			<li>Register (r)</li>
			<li>Search (s)</li> --->
		</ul>
	</li>
</ul>

<p>The syntax for stylesheet classes is: <span style="font-style:italic;">hierarchy_traversal</span>&#150;<span style="font-style:italic;">style_name</span> { <span style="font-style:italic;">style_information</span> }.	For example, to specify the color red as the default color of an event title on a calendar, you would define:</p>

<div style="padding-left:30px;">
<pre>
.bct-event {
	color: #ff0000;
}
</pre>
</div>

<p>The following table gives a complete list of the styles that can be modified using calendarInfusion schemes, along with a brief description of the page elements affected and the typical styles that are defined for these elements.</p>

<table width="90%" align="center" border="1" cellpadding="2" cellspacing="2" style="border:1px solid silver;border-collapse:collapse;">
	<tr>
		<th align="left">Class</th>
		<th align="left">Element description</th>
		<th align="left">Typical usage</th>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.b-style</span></td>
		<td>General BODY tag</td>
		<td>Backgrounds, fonts, scrollbars</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bh-style</span></td>
		<td>Body header styles</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bp-style</span></td>
		<td>General calendarInfusion page</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bp-title</span></td>
		<td>Page title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bp-subtitle</span></td>
		<td>Page subtitle</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bpd-style</span></td>
		<td>General dialog box style</td>
		<td>Backgrounds, borders, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bpd-title</span></td>
		<td>Dialog box title</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bpd-subtitle</span></td>
		<td>Dialog box subtitle</td>
		<td>Backgrounds, fonts</td>
	</tr>	
	<tr>
		<td><span style="white-space:nowrap;">.bc-style</span></td>
		<td>General calendar style</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-title</span></td>
		<td>Calendar title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-header</span></td>
		<td>Calendar header</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-time</span></td>
		<td>Date/Times used in calendar</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-weekday</span></td>
		<td>Weekday (M-F) of calendar</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-weekend</span></td>
		<td>Weekend (Sa-Su) of calendar</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-workhours</span></td>
		<td>Work hours (8a-5p) of calendar</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-afterhours</span></td>
		<td>Non-work hours (5p-8a) of calendar</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-alternate1</span></td>
		<td>Color #1 when alternating colors are used</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-alternate2</span></td>
		<td>Color #2 when alternating colors are used</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bc-event</span></td>
		<td>Title of an event displayed on the calendar view</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bcc-style</span></td>
		<td>Event category when displayed on the calendar view.	Used to </td>
		<td>Font size</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bcd-style</span></td>
		<td>General calendar day style</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bcd-active</span></td>
		<td>Day on which event occurs</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bcd-inactive</span></td>
		<td>Day on which no events occur</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bcd-empty</span></td>
		<td>Placeholder for empty day on month calendar</td>
		<td>Backgrounds</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-style</span></td>
		<td>General calendar title style</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-event</span></td>
		<td>Calendar event title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-holiday</span></td>
		<td>Calendar holiday title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-time</span></td>
		<td>Calendar time title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-smallevent</span></td>
		<td>Calendar small event title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-smallholiday</span></td>
		<td>Calendar small holiday title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-smalltime</span></td>
		<td>Calendar small time title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-printevent</span></td>
		<td>Calendar print-friendly event title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-printholiday</span></td>
		<td>Calendar print-friendly holiday title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bct-printtime</span></td>
		<td>Calendar print-friendly time title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bcm-style</span></td>
		<td>General calendar menu style</td>
		<td>Backgrounds, fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.be-style</span></td>
		<td>General event style</td>
		<td>Backgrounds, fonts, borders</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.be-title</span></td>
		<td>Event title</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.be-description</span></td>
		<td>Event description</td>
		<td>Fonts</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.be-heading</span></td>
		<td>Miscellaneous event heading info (e.g. location, time)</td>
		<td>Fonts</td>
	</tr>
	<!---<tr>
		<td><span style="white-space:nowrap;">.bmn-style</span></td>
		<td>General navigation menu style</td>
		<td>Backgrounds, fonts, padding</td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-title</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-link</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-link:hover</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-link:visited</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-link:visited:hover</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-link:active</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-text</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-style</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-cell</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-separator</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bmn-link</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-link:hover</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-link:visited</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-link:visited:hover</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-link:active</span></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span style="white-space:nowrap;">.bma-text</span></td>
		<td></td>
	</tr>--->
</table>

</div>