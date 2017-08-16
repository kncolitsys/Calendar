<h3 class="bp-subtitle">Installing calendarInfusion on Windows</h3>

<div class="bp-text">
<ol>
	<li>Download and unzip the calendarInfusion installation package to &lt;unzip_root&gt;.<br></li><br>
	<li>Install the calendarInfusion database:<br>
		<ol type="a">
			<li>Microsoft Access
				<ol type="i">
					<li>Copy the calendarInfusion.mdb file from &lt;unzip_root&gt;\databases\msaccess\ to your preferred database storage location</li>
				</ol>
			</li>
			<li>Microsoft SQL Server
				<ol type="i">
					<li>Start Microsoft SQL Server</li>
					<li>Create a new database for calendarInfusion</li>
					<li>For the calendarInfusion database, in osql or Query Analyzer, execute:<br>
						 <code>&lt;unzip_root&gt;\database\mssql\calendar.sql</code><br>
						 <code>&lt;unzip_root&gt;\database\mssql\calendar_init.sql</code><br>
					</li>
				</ol>
			</li>
		</ol>		
 	</li><br>
	<li>Create the calendarInfusion DSN within the ColdFusion Administrator
		<ol type="a">
      <li>Login to the ColdFusion Administrator</li>
			<li>Click on the 'ODBC' data sources link</li>
			<li>Create the calendarInfusion DSN using the appropriate driver, login, and password</li>
		</ol>
	</li><br>
	<li>
		Create the &lt;install_root&gt; directory and copy the directories from the 'package' directory to this new directory.<br>
		Recommended &lt;install_root&gt;: C:\infusion<br>
	</li><br>
	<li>
		Create the &lt;website_root&gt; directory and copy the directories from the 'webroot' folder to this new directory.<br>
		Recommended &lt;website_root&gt;: C:\InetPub\wwwroot<br>
	</li><br>
	<li>Create a ColdFusion mapping:
		<ol type="a">
			<li>Login to the ColdFusion Administrator</li>
			<li>Click on the 'Mappings' link</li>
			<li>Enter the necessary information to create a new mapping:<br>
				Logical Path - the ColdFusion mapping string.<br>
				Recommended: /infusion_root/<br>
				Directory Path - &lt;install_root&gt; directory for Infusion Technology applications.<br>
				Recommended: C:\infusion\<br>
			</li>
			<li>Note: If anything other than /infusion_root/ is used for the ColdFusion mapping string or subdirectory, you will need to update the application.ini file contained in each package directory and will need to perform a global search and replace of all instances of 'infusion_root' with your string of choice.</li>
		</ol>
	</li><br>
	<li>Update the application.ini config files with the values specific to your environment.  These files are located in the root package directories.  For example, &lt;install_root&gt;\com\infusion\calendar\application.ini. These config files exists for both passportInfusion and calendarInfusion.<br></li><br>
	<li>Using a web browser, access the calendarInfusion installation page at &lt;calendarInfusion_website_root&gt;/install.cfm and follow the instructions to complete the installation.<br></li><br>
	<li>For security reasons, you should probably delete, move, or reset the permissions on the install.cfm files, to prevent any unauthorized access to this file after the installation is complete.<br></li><br>
</ol>
</div>