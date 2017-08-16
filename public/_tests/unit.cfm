<cfset CFUnitRoot = "net.sourceforge.cfunit" />

<cfset tests = ArrayNew(1) />
<cfset ArrayAppend(tests, "calendar.tests.unit.calendar_test") />
<cfset ArrayAppend(tests, "calendar.tests.unit.category_test") />
<cfset testsuite = CreateObject("component", "#CFUnitRoot#.framework.TestSuite").init(tests) />

<h2>Test Templates</h2>
<cfinvoke component="#CFUnitRoot#.framework.TestRunner" method="run">
	<cfinvokeargument name="test" value="#testsuite#">
	<cfinvokeargument name="name" value="">
</cfinvoke>

<!---
// Run each unit test independently
<cfinvoke component="net.sourceforge.cfunit.framework.TestSuite" method="init" classes="calendar.tests.unit.calendar_test" returnvariable="calendarUnitTest" />
<cfinvoke component="net.sourceforge.cfunit.framework.TestRunner" method="run">
	<cfinvokeargument name="test" value="#calendarUnitTest#">
	<cfinvokeargument name="name" value="Calendar Unit Test">
</cfinvoke>

<cfinvoke component="net.sourceforge.cfunit.framework.TestSuite" method="init" classes="calendar.tests.unit.category_test" returnvariable="categoryUnitTest" />
<cfinvoke component="net.sourceforge.cfunit.framework.TestRunner" method="run">
	<cfinvokeargument name="test" value="#categoryUnitTest#">
	<cfinvokeargument name="name" value="Category Unit Test">
</cfinvoke>
--->