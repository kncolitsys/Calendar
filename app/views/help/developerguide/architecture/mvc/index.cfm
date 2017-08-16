<h3 class="bp-subtitle">MVC (Model-View-Controller) Architecture</h3>

<div class="bp-text">
<p>The calendarInfusion architecture uses an approach similiar to a Model-View-Controller (MVC) architecture for the organization of the application components.	The MVC architecture is designed to encapsulate functionality into the three groups:</p>

<ul>
	<li>
		<span style="font-weight:bold;">Model</span><br>
		The model manages the behavior and data of the application, responds to requests for information about the its state (usually from the view), and responds to instructions to change its state (usually from the controller).
	</li>
	<li>
		<span style="font-weight:bold;">View</span><br>
		The view manages the user interface of the application.	It is typically updated by requests from the controller using information provided by the model.
	</li>
	<li>
		<span style="font-weight:bold;">Controller</span><br>
		The controller interprets mouse and keyboard inputs from the user, and makes the appropriate requests to the model and/or view so that they can be updated appropriately.
	</li>
</ul>

<p>Although calendarInfusion does not strictly follow this approach, the general concepts are implemented to encapsulate the various functionality of the application:</p>

<ul>
	<li>
		<span style="font-weight:bold;">Model</span><br>
		calendarInfusion uses the model to manage the data and state of the various objects and instances used in the application.	All interactions with the application database and management of objects and their functionality is performed through the model.	For calendarInfusion, the &quot;model&quot; consists of all of the classes contained in the <span style="font-style:italic;">com.infusion.calendar.*</span> package.
	</li>
	<li>
		<span style="font-weight:bold;">View</span><br>
		The calendarInfusion view manages all of the user interface aspects of the application.	All content that is displayed to the user through their web browser is a result of the view.	The vast majority of this content is the generation of HTML code, but this also includes such items as Javascript code and the interactivity that results from these scripts.	For calendarInfusion, the &quot;view&quot; consists of standard CFML/HTML files contained in the <span style="font-style:italic;">&lt;webroot&gt;/shared/ui/</span> directory.
	</li>
	<li>
		<span style="font-weight:bold;">Controller</span><br>
		The calendarInfusion controller interprets all of the application events and takes the appropriate actions based on these events.	In almost all cases, these events are produce by a user clicking on a link within the application.	For calendarInfusion, the &quot;controller&quot; consists of most of the files contained within the webroot of the application.
	</li>
</ul>

<p>There are a number of benefits that are a result of using this methodology for application architecture.	Most notably:</p>

<ul>
	<li>
		<span style="font-weight:bold;">Separation of data, logic, and presentation</span><br>
		By separating these components of the application, it provides a framework that allows the appropriate developers to work on the appropriate sections of code.	Graphic designers and user interface developers can focus on the visual components of the application, which are isolated to the view.	At the same time, software engineers and developers can focus on the data and logic of the application, which is contained in the model and view.	Lastly, database developers only need to manipulate the model of the application, since all database interactions are contained there.
	</li>
	<li>
		<span style="font-weight:bold;">Security</span><br>
		A side-effect of the MVC architecture is (potentially) more secure web application.	The only component of the application that must be directly accessible to users of the application is the controller, since the controller manages which model and view components to use.	This allows the model and view components to be stored in a location on a web server that is <span style="font-weight:bold;">outside</span> the web tree.	The business logic and interface are not directly accessible through the website, which makes it much more difficult for non-authorized users to access the source of these components.	(Obviously, there are many other factors affecting website security and the security of your web applications is only as strong as the weakest link in the chain.)
	</li>
</ul>
</div>