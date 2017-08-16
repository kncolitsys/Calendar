<cfcomponent>
	
	<cffunction name="init" access="public" returntype="timezoneLib" output="false">
		<cfscript>
			timezones = arrayNew(1);
			timezones[01] = listToArray("000; Dateline Standard Time; GMT-12:00; International Date Line West; -12", ";");
			timezones[02] = listToArray("001; Samoa Standard Time; GMT-11:00; Midway Island, Samoa; -11", ";");
			timezones[03] = listToArray("002; Hawaiian Standard Time; GMT-10:00; Hawaii; -10", ";");
			timezones[04] = listToArray("003; Alaskan Standard Time; GMT-09:00; Alaska; -9", ";");
			timezones[05] = listToArray("004; Pacific Standard Time; GMT-08:00; Pacific Time (US and Canada), Tijuana; -8", ";");
			timezones[06] = listToArray("010; Mountain Standard Time; GMT-07:00; Mountain Time (US and Canada); -7", ";");
			timezones[07] = listToArray("013; Mexico Standard Time 2; GMT-07:00; Chihuahua, La Paz, Mazatlan; -7", ";");
			timezones[08] = listToArray("015; U.S. Mountain Standard Time; GMT-07:00; Arizona; -7", ";");
			timezones[09] = listToArray("020; Central Standard Time; GMT-06:00; Central Time (US and Canada); -6", ";");
			timezones[10] = listToArray("025; Canada Central Standard Time; GMT-06:00; Saskatchewan; -6", ";");
			timezones[11] = listToArray("030; Mexico Standard Time; GMT-06:00; Guadalajara, Mexico City, Monterrey; -6", ";");
			timezones[12] = listToArray("033; Central America Standard Time; GMT-06:00; Central America; -6", ";");
			timezones[13] = listToArray("035; Eastern Standard Time; GMT-05:00; Eastern Time (US and Canada); -5", ";");
			timezones[14] = listToArray("040; U.S. Eastern Standard Time; GMT-05:00; Indiana (East); -5", ";");
			timezones[15] = listToArray("045; S.A. Pacific Standard Time; GMT-05:00; Bogota, Lima, Quito; -5", ";");
			timezones[16] = listToArray("050; Atlantic Standard Time; GMT-04:00; Atlantic Time (Canada); -4", ";");
			timezones[17] = listToArray("055; S.A. Western Standard Time; GMT-04:00; Caracas, La Paz; -4", ";");
			timezones[18] = listToArray("056; Pacific S.A. Standard Time; GMT-04:00; Santiago; -4", ";");
			timezones[19] = listToArray("060; Newfoundland Standard Time; GMT-03:30; Newfoundland; -3.5", ";");
			timezones[20] = listToArray("065; E. South America Standard Time; GMT-03:00; Brasilia; -3", ";");
			timezones[21] = listToArray("070; S.A. Eastern Standard Time; GMT-03:00; Buenos Aires, Georgetown; -3", ";");
			timezones[22] = listToArray("073; Greenland Standard Time; GMT-03:00; Greenland; -3", ";");
			timezones[23] = listToArray("075; Mid-Atlantic Standard Time; GMT-02:00; Mid-Atlantic; -2", ";");
			timezones[24] = listToArray("080; Azores Standard Time; GMT-01:00; Azores; -1", ";");
			timezones[25] = listToArray("083; Cape Verde Standard Time; GMT-01:00; Cape Verde Islands; -1", ";");
			timezones[26] = listToArray("085; GMT Standard Time; GMT+00:00; Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London; 0", ";");
			timezones[27] = listToArray("090; Greenwich Standard Time; GMT+00:00; Casablanca, Monrovia; 0", ";");
			timezones[28] = listToArray("095; Central Europe Standard Time; GMT+01:00; Belgrade, Bratislava, Budapest, Ljubljana, Prague; 1", ";");
			timezones[29] = listToArray("100; Central European Standard Time; GMT+01:00; Sarajevo, Skopje, Warsaw, Zagreb; 1", ";");
			timezones[30] = listToArray("105; Romance Standard Time; GMT+01:00; Brussels, Copenhagen, Madrid, Paris; 1", ";");
			timezones[31] = listToArray("110; W. Europe Standard Time; GMT+01:00; Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna; 1", ";");
			timezones[32] = listToArray("113; W. Central Africa Standard Time; GMT+01:00; West Central Africa; 1", ";");
			timezones[33] = listToArray("115; E. Europe Standard Time; GMT+02:00; Bucharest; 2", ";");
			timezones[34] = listToArray("120; Egypt Standard Time; GMT+02:00; Cairo; 2", ";");
			timezones[35] = listToArray("125; FLE Standard Time; GMT+02:00; Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius; 2", ";");
			timezones[36] = listToArray("130; GTB Standard Time; GMT+02:00; Athens, Istanbul, Minsk; 2", ";");
			timezones[37] = listToArray("135; Israel Standard Time; GMT+02:00; Jerusalem; 2", ";");
			timezones[38] = listToArray("140; South Africa Standard Time; GMT+02:00; Harare, Pretoria; 2", ";");
			timezones[39] = listToArray("145; Russian Standard Time; GMT+03:00; Moscow, St. Petersburg, Volgograd; 3", ";");
			timezones[40] = listToArray("150; Arab Standard Time; GMT+03:00; Kuwait, Riyadh; 3", ";");
			timezones[41] = listToArray("155; E. Africa Standard Time; GMT+03:00; Nairobi; 3", ";");
			timezones[42] = listToArray("158; Arabic Standard Time; GMT+03:00; Baghdad; 3", ";");
			timezones[43] = listToArray("160; Iran Standard Time; GMT+03:30; Tehran; 3.5", ";");
			timezones[44] = listToArray("165; Arabian Standard Time; GMT+04:00; Abu Dhabi, Muscat; 4", ";");
			timezones[45] = listToArray("170; Caucasus Standard Time; GMT+04:00; Baku, Tbilisi, Yerevan; 4", ";");
			timezones[46] = listToArray("175; Afghanistan Standard Time; GMT+04:30; Kabul; 4.5", ";");
			timezones[47] = listToArray("180; Ekaterinburg Standard Time; GMT+05:00; Ekaterinburg; 5", ";");
			timezones[48] = listToArray("185; West Asia Standard Time; GMT+05:00; Islamabad, Karachi, Tashkent; 5", ";");
			timezones[49] = listToArray("190; India Standard Time; GMT+05:30; Chennai, Kolkata, Mumbai, New Delhi; 5.5", ";");
			timezones[50] = listToArray("193; Nepal Standard Time; GMT+05:45; Kathmandu; 5.75", ";");
			timezones[51] = listToArray("195; Central Asia Standard Time; GMT+06:00; Astana, Dhaka; 6", ";");
			timezones[52] = listToArray("200; Sri Lanka Standard Time; GMT+06:00; Sri Jayawardenepura; 6", ";");
			timezones[53] = listToArray("201; N. Central Asia Standard Time; GMT+06:00; Almaty, Novosibirsk; 6", ";");
			timezones[54] = listToArray("203; Myanmar Standard Time; GMT+06:30; Rangoon; 6.5", ";");
			timezones[55] = listToArray("205; S.E. Asia Standard Time; GMT+07:00; Bangkok, Hanoi, Jakarta; 7", ";");
			timezones[56] = listToArray("207; North Asia Standard Time; GMT+07:00; Krasnoyarsk; 7", ";");
			timezones[57] = listToArray("210; China Standard Time; GMT+08:00; Beijing, Chongqing, Hong Kong SAR, Urumqi; 8", ";");
			timezones[58] = listToArray("215; Singapore Standard Time; GMT+08:00; Kuala Lumpur, Singapore; 8", ";");
			timezones[59] = listToArray("220; Taipei Standard Time; GMT+08:00; Taipei; 8", ";");
			timezones[60] = listToArray("225; W. Australia Standard Time; GMT+08:00; Perth; 8", ";");
			timezones[61] = listToArray("227; North Asia East Standard Time; GMT+08:00; Irkutsk, Ulaan Bataar; 8", ";");
			timezones[62] = listToArray("230; Korea Standard Time; GMT+09:00; Seoul; 9", ";");
			timezones[63] = listToArray("235; Tokyo Standard Time; GMT+09:00; Osaka, Sapporo, Tokyo; 9", ";");
			timezones[64] = listToArray("240; Yakutsk Standard Time; GMT+09:00; Yakutsk; 9", ";");
			timezones[65] = listToArray("245; A.U.S. Central Standard Time; GMT+09:30; Darwin; 9.5", ";");
			timezones[66] = listToArray("250; Cen. Australia Standard Time; GMT+09:30; Adelaide; 9.5", ";");
			timezones[67] = listToArray("255; A.U.S. Eastern Standard Time; GMT+10:00; Canberra, Melbourne, Sydney; 10", ";");
			timezones[68] = listToArray("260; E. Australia Standard Time; GMT+10:00; Brisbane; 10", ";");
			timezones[69] = listToArray("265; Tasmania Standard Time; GMT+10:00; Hobart; 10", ";");
			timezones[70] = listToArray("270; Vladivostok Standard Time; GMT+10:00; Vladivostok; 10", ";");
			timezones[71] = listToArray("275; West Pacific Standard Time; GMT+10:00; Guam, Port Moresby; 10", ";");
			timezones[72] = listToArray("280; Central Pacific Standard Time; GMT+11:00; Magadan, Solomon Islands, New Caledonia; 11", ";");
			timezones[73] = listToArray("285; Fiji Islands Standard Time; GMT+12:00; Fiji Islands, Kamchatka, Marshall Islands; 12", ";");
			timezones[74] = listToArray("290; New Zealand Standard Time; GMT+12:00; Auckland, Wellington; 12", ";");
			timezones[75] = listToArray("300; Tonga Standard Time; GMT+13:00; Nuku'alofa; 13", ";");
		
			// Create an array of timezones in the variables scope
			variables.a_timezones = timezones;
			
			// Create a struct of timezones in the variables scope
			variables.s_timezones = structNew();
			for(i=1; i lte arrayLen(timezones); i=i+1) {
				id = trim(timezones[i][1]);
				variables.s_timezones[id] = structNew();
				variables.s_timezones[id]["code"] = trim(timezones[i][1]);
				variables.s_timezones[id]["title"] = trim(timezones[i][2]);
				variables.s_timezones[id]["offset"] = trim(timezones[i][3]);
				variables.s_timezones[id]["location"] = trim(timezones[i][4]);
				variables.s_timezones[id]["noffset"] = trim(timezones[i][5]);
			}
			
			// Create a query of timezones in the variables scope
			variables.q_timezones = queryNew("code,title,offset,location,noffset");
			queryAddRow(variables.q_timezones,arrayLen(timezones));
			for(i=1; i lte arrayLen(timezones); i=i+1) {
				querySetCell(variables.q_timezones,"code",trim(timezones[i][1]),i);
				querySetCell(variables.q_timezones,"title",trim(timezones[i][2]),i);
				querySetCell(variables.q_timezones,"offset",trim(timezones[i][3]),i);
				querySetCell(variables.q_timezones,"location",trim(timezones[i][4]),i);
				querySetCell(variables.q_timezones,"noffset",trim(timezones[i][5]),i);
			}
		</cfscript>
		<cfreturn this />
	</cffunction>

	<cffunction name="getOffset" access="public" returntype="numeric" output="false" hint="Returns the time offset (in hours) for a particular timezone">
		<cfargument name="tzcode" type="string" required="true" />
		<cfreturn variables.s_timezones[arguments.tzcode]["noffset"] />
	</cffunction>
	
	<cffunction name="getTimeZones" access="public" returntype="query" output="false">
		<cfscript>
			return variables.q_timezones;
		</cfscript>
	</cffunction>

	<cffunction name="toUtc" access="public" returntype="date" output="false" hint="returns a local time converted to UTC time">
		<cfargument name="datetime" type="date" required="true" />
		<cfargument name="tzcode" type="string" required="true" />
		<cfset offset = variables.s_timezones[arguments.tzcode]["noffset"] />
		<cfreturn dateAdd("s", -offset*60*60, arguments.datetime) />
	</cffunction>

	<cffunction name="toLocal" access="public" returntype="date" output="false" hint="returns a UTC time converted to local time">
		<cfargument name="datetime" type="date" required="true" />
		<cfargument name="tzcode" type="string" required="true" />
		<cfset offset = variables.s_timezones[arguments.tzcode]["noffset"] />
		<cfreturn dateAdd("s", offset*60*60, arguments.datetime) />
	</cffunction>

</cfcomponent>