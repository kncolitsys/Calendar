<cfsetting enablecfoutputonly="yes" />

<cfheader name="Content-Disposition" value="inline; filename=event.vcs" />
<cfheader name="Content-Type" value="text/x-vCalendar" />
<cfoutput>#request.icalendar#</cfoutput>

<cfsetting showdebugoutput="no" />
<cfsetting enablecfoutputonly="no" />