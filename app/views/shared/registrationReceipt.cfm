<!---
****************************************************************************
* Copyright (c) 1999-2007,  
*
* Method:			
*	 com.infusion.passport.ui.RegistrationPanel::displayReceipt
*
* Description:
*	 Displays a receipt message to user after their registration has been
*	 submitted.	The 'received' message is displayed if registration approval
*	 is required.
*
****************************************************************************
--->
<br>
<table class="bpd-style" align="center" width="360" border="0" cellpadding="5" cellspacing="0">
	<tr>
		<td>
			<cfoutput>#application.resource.bundle.text.registration_received#</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" onclick="window.close();" style="font-size:10px;border:1px solid;padding:0px 3px 1px 3px;">X</a> <a href="#" onclick="window.close();"><cfoutput>#application.resource.bundle.text.close_this_window#</cfoutput></a>
		</td>
	</tr>
</table>
<br>
