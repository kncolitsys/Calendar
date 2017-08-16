<h3 class="bp-subtitle">Customizing Language Settings</h3>

<div class="bp-text">
<p>calendarInfusion has been architected to support the use of alternate languages (other than English).  Although actual translations are not provided by calendarInfusion, all text and images that are displayed to users are contained within a two central locations: the resource bundle file and the image collection.</p>

<span style="font-weight:bold;">Resource Bundle</span><br>
<p>A resource bundle is a file that contains all of the text and formatting to be used for a particular language.  All text strings that are displayed to the user are contained within the resource bundle.  In addition, any date, number, or currency formatting is also controlled within this file.  The appropriate resource bundle is specified by setting the application.resource.language variable to the appropriate value. (This is done behind the scenes by the application or through the calendarInfusion Administrator Tool.)  By default, this variable is set to &quot;en-us&quot; (US English).</p>

<p>Resource bundles are stored in a subdirectory of the ResourceManager class, with the subdirectory name corresponding to the language code.  For example,  &lt;calendarInfusion_package_directory&gt;/com/infusion/calendar/resource/<span style="font-weight:bold;color:#ff0000;">en-us</span>.cfm is used for the US English language.  The resource file contains ColdFusion code that creates a CF structure and populates that structure with the various variables and strings (stored as key/value pairs) used throughout the application for text and formatting.</p>

<p>For performance reasons, the resource bundle structure is created and stored in memory.  This occurs when the application is accessed for the first time.  The resource bundle is only re-processed when: (1) the ColdFusion server is restarted, or (2) the language code is changed in the calendarInfusion Administrator Tool.</p>

<span style="font-weight:bold;">Image Collection</span><br>
<p>Because the text in calendarInfusion images cannot be manipulated simply by updating a text file, any images that contain text are stored in an image collection.  These image collections are stored in the images/ folder of the web tree and are also grouped together under a directory that corresponds to the language it supports.  For example, &lt;calendarInfusion_website_directory&gt;/images/<span style="font-weight:bold;color:#ff0000;">en-us</span>/ contains images for English language support.</p>

<span style="font-weight:bold;">Create a New Resource Bundle and Image Collection</span><br>
<p>To add support for a new language, you should follow these steps:</p>

<ol>
  <li style="padding-bottom:6px;">Copy and rename en-us.cfm file in the &lt;package_directory&gt;/com/infusion/calendar/resource/ directory.</li>
  <li style="padding-bottom:6px;">Modify the values of the variables in the resource file copied in the previous step.  <span style="font-weight:bold;">It is critical that you do not modify the variable names themselves... just the values!</span></li>
  <li style="padding-bottom:6px;">Create a new subdirectory within &lt;website_directory&gt;/images/.  The name of the subdirectory should correspond to the same language code used in Step 1.</li>
  <li style="padding-bottom:6px;">Copy all of the files from the &lt;package_directory&gt;/images/en-us/ directory to your newly created image collection directory.</li>
  <li style="padding-bottom:6px;">Modify the files appropriately with your new text.</li>
  <li style="padding-bottom:6px;">Modify the &lt;website_directory&gt;/shared/ui/editLanguagePanel.cfm and add this new language to the language struct contained in this file.</li>
  <li style="padding-bottom:6px;">Finally, login to the calendarInfusion Administrator Tool, click on the 'Language' link in the navigation menu, and change the language to your newly created language resource file.</li>
</ol>

</div>