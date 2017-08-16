SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[applications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[applications](
	[applicationDsid] [int] NOT NULL,
	[applicationId] [nvarchar](36) NULL,
	[package] [nvarchar](255) NULL,
	[product] [nvarchar](50) NULL,
	[version] [nvarchar](24) NULL,
	[edition] [nvarchar](30) NULL,
	[serial] [nvarchar](24) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[calendars]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[calendars](
	[calendarDsid] [int] NOT NULL,
	[calendarId] [nvarchar](36) NOT NULL,
	[status] [int] NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[anonymousUserUid] [nvarchar](36) NULL,
	[defaultSchemeDsid] [int] NULL,
	[header] [nvarchar](max) NULL,
	[footer] [nvarchar](max) NULL,
	[exitUrl] [nvarchar](150) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[calendars_events]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[calendars_events](
	[calendarDsid] [int] NULL,
	[eventDsid] [int] NULL,
	[status] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[calendars_eventseries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[calendars_eventseries](
	[calendarDsid] [int] NULL,
	[seriesDsid] [int] NULL,
	[status] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[calendars_holidays]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[calendars_holidays](
	[calendarDsid] [int] NOT NULL,
	[holidayDsid] [int] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[categories](
	[categoryDsid] [int] NOT NULL,
	[categoryId] [nvarchar](36) NOT NULL,
	[title] [nvarchar](40) NOT NULL,
	[description] [nvarchar](max) NULL,
	[bgColor] [nvarchar](6) NULL,
	[calendarDsid] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[configCatalog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[configCatalog](
	[dsid] [int] NULL,
	[title] [nvarchar](100) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[configLookup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[configLookup](
	[objectType] [int] NOT NULL,
	[objectValue] [int] NOT NULL,
	[configType] [int] NOT NULL,
	[configValue] [nvarchar](max) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[configObject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[configObject](
	[dsid] [int] NULL,
	[title] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[events]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[events](
	[eventDsid] [int] NOT NULL,
	[eventId] [nvarchar](36) NOT NULL,
	[seriesDsid] [int] NULL,
	[title] [nvarchar](100) NOT NULL,
	[description] [nvarchar](max) NULL,
	[categoryDsid] [int] NULL,
	[eventUrl] [nvarchar](max) NULL,
	[startDateTime] [datetime] NOT NULL,
	[duration] [int] NULL,
	[location] [nvarchar](100) NULL,
	[allDay] [bit] NOT NULL,
	[contactFirstName] [nvarchar](30) NULL,
	[contactLastName] [nvarchar](30) NULL,
	[contactEmail] [nvarchar](50) NULL,
	[contactPhone] [nvarchar](20) NULL,
	[comments] [nvarchar](max) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[approvedDate] [datetime] NULL,
	[approvedBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[events_users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[events_users](
	[eventDsid] [int] NULL,
	[userDsid] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[events_reminders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[events_reminders](
	[eventDsid] [int] NULL,
	[reminderDsid] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eventseries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[eventseries](
	[seriesDsid] [int] NOT NULL,
	[seriesId] [nvarchar](36) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[description] [nvarchar](max) NULL,
	[calendarDsid] [int] NOT NULL,
	[categoryDsid] [int] NOT NULL,
	[eventUrl] [nvarchar](max) NULL,
	[recurrenceStartDate] [datetime] NOT NULL,
	[recurrenceEndDate] [datetime] NULL,
	[duration] [int] NULL,
	[location] [nvarchar](100) NULL,
	[allDay] [bit] NOT NULL,
	[recurrence] [bit] NOT NULL,
	[recurrenceRule] [nvarchar](max) NULL,
	[contactFirstName] [nvarchar](30) NULL,
	[contactLastName] [nvarchar](30) NULL,
	[contactEmail] [nvarchar](50) NULL,
	[contactPhone] [nvarchar](20) NULL,
	[comments] [nvarchar](max) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[approvedDate] [datetime] NULL,
	[approvedBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[eventseries_reminders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[eventseries_reminders](
	[seriesDsid] [int] NULL,
	[reminderDsid] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[groups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[groups](
	[groupDsid] [int] NOT NULL,
	[groupId] [nvarchar](36) NULL,
	[groupName] [nvarchar](100) NULL,
	[comments] [nvarchar](max) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[groups_rights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[groups_rights](
	[groupDsid] [int] NULL,
	[rightDsid] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[holidays]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[holidays](
	[holidayDsid] [int] NOT NULL,
	[holidayId] [nvarchar](36) NOT NULL,
	[globalObject] [bit] NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[recurrenceRule] [nvarchar](max) NOT NULL,
	[comments] [nvarchar](max) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mailservers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mailservers](
	[mailserverDsid] [int] NOT NULL,
	[mailserverId] [nvarchar](36) NOT NULL,
	[server] [nvarchar](64) NOT NULL,
	[port] [int] NULL,
	[timeout] [int] NULL,
	[mailerId] [nvarchar](80) NULL,
	[serverusername] [nvarchar](50) NULL,
	[serverpassword] [nvarchar](50) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[messages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[messages](
	[mailDsid] [int] NOT NULL,
	[mailId] [nvarchar](36) NOT NULL,
	[mailType] [int] NOT NULL,
	[calendarDsid] [int] NOT NULL,
	[toAddress] [nvarchar](max) NOT NULL,
	[fromAddress] [nvarchar](max) NOT NULL,
	[ccAddress] [nvarchar](max) NULL,
	[bccAddress] [nvarchar](max) NULL,
	[subject] [nvarchar](100) NULL,
	[body] [nvarchar](max) NULL,
	[sent] [bit] NOT NULL,
	[sentDate] [datetime] NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[registrations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[registrations](
	[registrationDsid] [int] NOT NULL,
	[registrationId] [nvarchar](36) NOT NULL,
	[userId] [nvarchar](36) NOT NULL,
	[calendarId] [nvarchar](36) NOT NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[remindermethods]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[remindermethods](
	[reminderMethodDsid] [int] NOT NULL,
	[reminderDsid] [int] NOT NULL,
	[method] [nvarchar](16) NOT NULL,
	[toAddress] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[reminders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[reminders](
	[reminderDsid] [int] NOT NULL,
	[reminderId] [nvarchar](36) NOT NULL,
	[userId] [nvarchar](36) NOT NULL,
	[schedule] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[rights](
	[rightDsid] [int] NOT NULL,
	[calendarDsid] [int] NULL,
	[privilege] [nvarchar](30) NOT NULL,
	[description] [nvarchar](50) NULL,
	[comments] [nvarchar](max) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[schemes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[schemes](
	[schemeDsid] [int] NOT NULL,
	[schemeId] [nvarchar](36) NOT NULL,
	[calendarDsid] [int] NOT NULL,
	[globalObject] [bit] NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[stylesheet] [nvarchar](max) NULL,
	[filePath] [nvarchar](255) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[searchindexes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[searchindexes](
	[searchIndexDsid] [int] NOT NULL,
	[searchIndexId] [nvarchar](36) NOT NULL,
	[title] [nvarchar](70) NULL,
	[collection] [nvarchar](53) NOT NULL,
	[calendarDsid] [int] NOT NULL,
	[indexLanguage] [nvarchar](20) NULL,
	[path] [nvarchar](255) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[status]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[status](
	[statusDsid] [int] NULL,
	[code] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users](
	[userDsid] [int] NOT NULL,
	[userId] [nvarchar](36) NULL,
	[userlogin] [nvarchar](24) NULL,
	[userpassword] [nvarchar](48) NULL,
	[firstname] [nvarchar](50) NULL,
	[lastname] [nvarchar](50) NULL,
	[email] [nvarchar](80) NULL,
	[phoneHome] [nvarchar](20) NULL,
	[phoneWork] [nvarchar](20) NULL,
	[phoneMobile] [nvarchar](20) NULL,
	[timezone] [nvarchar](50) NULL,
	[comments] [nvarchar](max) NULL,
	[createDate] [datetime] NULL,
	[createBy] [nvarchar](36) NULL,
	[updateDate] [datetime] NULL,
	[updateBy] [nvarchar](36) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users_groups]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users_groups](
	[userDsid] [int] NULL,
	[groupDsid] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users_rights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[users_rights](
	[userDsid] [int] NULL,
	[rightDsid] [int] NULL
) ON [PRIMARY]
END

/*** Delete existing data, just in case ***/
DELETE FROM applications;
DELETE FROM calendars;
DELETE FROM holidays;
DELETE FROM categories;
DELETE FROM configCatalog;
DELETE FROM configLookup;
DELETE FROM configObject;
DELETE FROM groups;
DELETE FROM mailservers;
DELETE FROM rights;
DELETE FROM schemes;
DELETE FROM users;
DELETE FROM status;
DELETE FROM calendars_holidays;
DELETE FROM groups_rights;
DELETE FROM users_groups;
DELETE FROM users_rights;

/*** Now, initialize the application content ***/
INSERT INTO applications (applicationDsid, applicationId, package, product, version) VALUES (1, '2942617F-E029-4712-3D8F5753DB6584DB', 'com.infusion.calendar', 'calendarInfusion', '3.0');
GO

INSERT INTO calendars (calendarDsid, calendarId, status, title, description, defaultSchemeDsid, header, footer, createDate, createBy, updateDate, updateBy) VALUES (1, '29427EC2-E029-4712-3D7B173E956040E5', 1, 'Default Calendar', 'calendarInfusion Default Calendar', 1, '<table border=0 cellpadding=0 cellspacing=0 class="bp-style" style="width:100%;"><tr><td colspan=2 class="bh-style" style="text-align: right;">calendarInfusion</td></tr></table>', '<table border=0 cellpadding=0 cellspacing=0 class="bp-style" style="width:100%;"><tr><td class="bh-style"></td></tr></table><div align="right"><span style="font-size:11px; font-family:Verdana,Arial,Helvetica,sans-serif;">&copy;1999-2006, Infusion Technology</span></div>', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (1, '09ADCD69-E029-4712-3D28422B621FE217', 1, 'New Year''s Day', 'd_1_1', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (2, '09ADCD7D-E029-4712-3D5633B32A6B5793', 1, 'Martin Luther King''s Birthday', 'o_3_2_1', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (3, '09ADCD91-E029-4712-3DCA0EE47647879C', 1, 'Groundhog Day', 'd_2_2', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (4, '09ADCDA5-E029-4712-3D22A6A396569959', 1, 'Washington''s Birthday', 'o_3_2_2', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (5, '09ADCDB9-E029-4712-3D5CE48A0F9CE315', 1, 'Valentine''s Day', 'd_2_14', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (6, '09ADCDCD-E029-4712-3D7800C2CA72D206', 1, 'St. Patrick''s Day', 'd_3_17', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (7, '09ADCDE1-E029-4712-3D7CF849F4443451', 1, 'April Fool''s Day', 'd_4_1', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (8, '09ADCDF5-E029-4712-3DF9772C63B6B740', 1, 'Easter', 'a_golden=(year mod 19)+1;century=Int(year/100)+1;correction1=Int(3*century/4)-12;correction2=Int((8*century+5)/25)-5;sunday=Int(5*year/4)-correction1-10;epact=(11*golden+20+correction2-correction1) mod 30;if((epact eq 25 and golden gt 11) or (epact eq 24)){epact=epact+1;};n=44-epact;if(n lt 21){n=n+30;};offset=n+7-((sunday+n) mod 7);holidayInstance=DateAdd(''d'', -1, DateAdd(''d'',offset,CreateDate(year,3,1)));', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (9, '09ADCE13-E029-4712-3D12C0019E79D70D', 1, 'Mother''s Day', 'o_2_1_5', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (10, '09ADCE27-E029-4712-3D7F73AAD7503C1D', 1, 'Memorial Day', 'o_5_2_5', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (11, '09ADCE3B-E029-4712-3D11BB700B220843', 1, 'Father''s Day', 'o_3_1_6', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (12, '09ADCE4F-E029-4712-3D7841F4B87AC575', 1, 'Independence Day', 'd_7_4', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (13, '09ADCE63-E029-4712-3DB2D46E406ACD30', 1, 'Labor Day', 'o_1_2_9', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (14, '09ADCE81-E029-4712-3DD1A933FEF17B66', 1, 'Columbus Day', 'o_2_2_10', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (15, '09ADCE95-E029-4712-3D87ED8D32BBD5B5', 1, 'Halloween', 'd_10_31', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (16, '09ADCEA9-E029-4712-3D84F00E1F016F9E', 1, 'Veterans Day', 'd_11_11', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (17, '09ADCEC7-E029-4712-3DDC62C68F69D646', 1, 'Thanksgiving', 'o_4_5_11', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (18, '09ADCEDB-E029-4712-3DA04E40269B6B19', 1, 'Christmas Eve', 'd_12_24', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (19, '09ADCEEF-E029-4712-3D95E6FC483237B5', 1, 'Christmas', 'd_12_25', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
INSERT INTO holidays (holidayDsid, holidayId, globalObject, title, recurrenceRule, createDate, createBy, updateDate, updateBy) VALUES (20, '09ADCF03-E029-4712-3D55CBC3670F050B', 1, 'New Year''s Eve', 'd_12_31', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO categories (categoryDsid, categoryId, title, description, bgColor, calendarDsid, createDate, createBy, updateDate, updateBy) VALUES (1, '09BCF997-E029-4712-3D457A95C0D989E7', 'Main', 'Main events', 'defdaa', 1, '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO configCatalog (dsid, title) VALUES (1000, 'application_debug_enabled');
INSERT INTO configCatalog (dsid, title) VALUES (1001, 'application_debug_file');
INSERT INTO configCatalog (dsid, title) VALUES (1100, 'application_language_locale');
INSERT INTO configCatalog (dsid, title) VALUES (1200, 'application_timezone');
INSERT INTO configCatalog (dsid, title) VALUES (2000, 'calendar_week_start');
INSERT INTO configCatalog (dsid, title) VALUES (2001, 'calendar_week_end');
INSERT INTO configCatalog (dsid, title) VALUES (2002, 'calendar_display_workhours');
INSERT INTO configCatalog (dsid, title) VALUES (2003, 'calendar_search_enabled');
INSERT INTO configCatalog (dsid, title) VALUES (2004, 'calendar_default_group');
INSERT INTO configCatalog (dsid, title) VALUES (2005, 'calendar_vcalendar_enabled');
INSERT INTO configCatalog (dsid, title) VALUES (2104, 'calendar_access_public_id');
INSERT INTO configCatalog (dsid, title) VALUES (2105, 'calendar_access_public_username');
INSERT INTO configCatalog (dsid, title) VALUES (2106, 'calendar_access_public_password');
INSERT INTO configCatalog (dsid, title) VALUES (2107, 'calendar_access_public_permissions');
INSERT INTO configCatalog (dsid, title) VALUES (3000, 'policy_userapprovalrequired');
INSERT INTO configCatalog (dsid, title) VALUES (4000, 'mail_registrationapproved_body');
INSERT INTO configCatalog (dsid, title) VALUES (4001, 'mail_registrationapproved_subject');
INSERT INTO configCatalog (dsid, title) VALUES (4002, 'mail_registrationreceived_body');
INSERT INTO configCatalog (dsid, title) VALUES (4003, 'mail_registrationreceived_subject');
INSERT INTO configCatalog (dsid, title) VALUES (4004, 'mail_registrationdenied_body');
INSERT INTO configCatalog (dsid, title) VALUES (4005, 'mail_registrationdenied_subject');
GO

INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (1, 1, 1000, '0');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (1, 1, 1001, 'C:\calendarInfusion.log');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (1, 1, 1100, 'en-us');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (1, 1, 1200, '045');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2000, '1');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2001, '7');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2002, '0');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2003, '1');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2004, '');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2005, '1');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2104, '955C7E09-E029-4712-3D720E97E2EB43F0');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2105, 'public');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2106, 'XXXXXX');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 2107, '');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 3000, '0');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 4000, 'Dear #user.firstName#\n\nWelcome to the calendarInfusion Event Calendar!\nWe are delighted that you have decided to become a member of our community. As a member you now have complete access to the premiere ColdFusion-based calendar.\n *************************************************************\nYour account information is listed below for future reference:\n\n	Username: #user.username#\n	Email Address: #user.email#\n\nIf you did not authorize this registration, someone has mistakenly registered using your e-mail address.  We regret the inconvenience; please forward this e-mail to our administrators and write "cancel registration" in the subject line.');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 4001, 'Calendar Registration (Approved)');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 4002, 'Dear #user.firstName#,\n\nThank you for submitting your registration to the calendarInfusion Event Calendar.  Our administrators will review your registration shortly.  After your registration is reviewed, you will receive an email notifying you of the results of the approval process.  For questions, please contact our administrative team.  Thanks again for your interest.');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 4003, 'Calendar Registration (Received)');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 4004, 'Dear #user.firstName#,\n\nWe''re sorry to inform you that our calendarInfusion Event Calendar administrators reviewed your registration and did not approve your registration.  For questions, please contact our administrative team.');
INSERT INTO configLookup (objectType, objectValue, configType, configValue) VALUES (2, 1, 4005, 'Calendar Registration (Denied)');
GO

INSERT INTO configObject(dsid, title) VALUES (1, 'application');
INSERT INTO configObject(dsid, title) VALUES (2, 'calendar');
INSERT INTO configObject(dsid, title) VALUES (3, 'event');
INSERT INTO configObject(dsid, title) VALUES (4, 'category');
INSERT INTO configObject(dsid, title) VALUES (5, 'mail');
INSERT INTO configObject(dsid, title) VALUES (6, 'mailserver');
INSERT INTO configObject(dsid, title) VALUES (7, 'scheme');
INSERT INTO configObject(dsid, title) VALUES (8, 'searchindex');
INSERT INTO configObject(dsid, title) VALUES (9, 'policy');
INSERT INTO configObject(dsid, title) VALUES (10, 'filter');
GO

INSERT INTO groups (groupDsid, groupId, groupName, comments, createDate, createBy, updateDate, updateBy) VALUES (1, '0E1E4A22-E029-4712-3DAAE52EF42AE729', 'Calendar Administrators', 'Administrator group for the calendarInfusion application', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO mailservers (mailserverDsid, mailserverId, server, port, timeout, mailerId, updateDate, updateBy) VALUES (1, '09B711E4-E029-4712-3D94936E25F0B5A4', 'mailserver', 25, 0, '', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (1, 0, 'ADMINISTER_APPLICATION', 'Administer the calendarInfusion application');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (2, 1, 'ADMINISTER', 'Administer the calendar');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (3, 1, 'VIEW', 'View the calendar');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (4, 1, 'SEARCH', 'Search the calendar');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (5, 1, 'RECEIVE_EMAIL', 'Receive emails');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (6, 1, 'SUBMIT_EVENTS', 'Submit events');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (7, 1, 'ATTACH_DOCUMENTS', 'Attach documents to events');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (8, 1, 'EDIT_EVENTS', 'Edit events');
INSERT INTO rights (rightDsid, calendarDsid, privilege, description) VALUES (9, 1, 'APPROVE_EVENTS', 'Approve Events');
GO

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (1, '2AE73F9F-F0E8-47EA-81242461228343B2', 0, 1, 'Default Scheme', 'BODY {
 background-color: #ccccee;
 font-family: Verdana,Arial,Helvetica,sans-serif;
 font-size: 14px;
 text-decoration: none;
 scrollbar-base-color: #404080;
 scrollbar-arrow-color: #ffffff;
 scrollbar-track-color: #B3B3C1;
}

/* Header ***************************************/
.bh-style {
 color: #ffffff;
 font-size: 18px;
 font-weight: bold;
 text-align: right;
 padding: 2px;
 background-color: #000033;
}

/* Dialog ***************************************/
.bp-style {
 background-color: #eeeeee;
}

.bp-title {
 font-size: 18px;
 font-weight: bold;
 color: #000000;
}

.bp-subtitle {
 font-size: 12px;
 font-weight: bold;
}

.bpd-style {
 background-color: #ffffff;
 border: 1px solid #000066;
 padding: 2px;
 border-collapse: collapse;
 font-size: 12px;
 width: 100%;
}

.bpd-title {
 background-color: #e0e0e0;
 font-weight: bold;
}

.bpd-subtitle {
 background-color: #B3B3C1;
}

/* Calendar *************************************/
.bc-style {
 background-color: #ffffff;
 border: 1px solid #404080;
}

.bc-page {
 border: 1px solid #bfbfbf;
 background-color: #eeeeee;
}

TH.bc-style {
 background-color: #e3e3e3;
 font-size: 14px;
}

.bc-title {
 font-size: 18px;
 font-weight: bold;
}

.bcd-style {
 font-size: 10px;
 text-decoration: none;
}

.bcd-active {
 font-size: 12px;
 font-weight: bold;
 text-decoration: none;
}

.bcd-inactive {
 font-size: 12px;
 color: #333333;
 text-decoration: none;
}

.bcd-empty {
 background-color: #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend {
 background-color: #e3e3e3;
}

.bc-workhours, .bc-alternate1, .bc-weekday {
 background-color: #eeeeee;
}

.bc-event {
 border: 1px solid #404040;
 background-color: #e0e0e0;
}

.bct-time {
 font-size: 12px;
 font-weight: bold;
 white-space: nowrap;
}

.bct-holiday {
 font-size: 12px;
 color: #808080;
}

.bct-event {
 font-size: 12px;
}

.bct-smalltime {
 font-size: 10px;
 color: #000000;
 white-space: nowrap;
}

.bct-smallholiday {
 font-size: 10px;
 color: #808080;
 white-space: nowrap;
}

.bct-smallevent {
 font-size: 10px;
 margin-bottom: 1px;
 white-space: nowrap;
}

.bct-printevent {
 font-size: 12px;
}

.bct-printholiday {
 font-size: 12px;
 color: #808080;
}

.bct-printtime {
 font-size: 12px;
 font-weight: bold;
}

.bcm-style {
 background-color: #404080;
 color: #ffffff;
}

.bcm-text {
 color: #ffffff;
 font-size: 14px;
 font-weight: bold;
 padding: 0px 12px 0px 12px;
 background-color: #404080;
}

.bcm-text:hover {
 color: #ffffff;
 text-decoration: underline;
}

.be-style {
 font-size: 12px;
}

.be-title {
 font-size: 14px;
 font-weight: bold;
 color: #000000;
}

.be-description {
 font-size: 12px;
}

.be-heading {
 font-size: 12px;
 font-weight: bold;
}

/* Category Layout ******************************/
TD.bcc-style {
 background-color: #ffffff;
 border: 1px solid #404080;
 font-size: 10px;
 text-align: center;
}',
'stylesheets/schemes/2AE73F9F-F0E8-47EA-81242461228343B2.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970',  '00000000-0000-0000-0000000000000000');

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (2, '77208121-0A43-427A-93B8CF5D48E2C4F2', 0, 1, 'Evergreen Forest', 'BODY {
 background-color: #d6e6d6;
 font-family: Verdana,Arial,Helvetica,sans-serif;
 font-size: 12px;
 text-decoration: none;
 scrollbar-base-color: #73B47B;
 scrollbar-arrow-color : #000000;
 scrollbar-track-color : #b3b3b3;
}

/* Header ***************************************/
.bh-style {
 color: #ffffff;
 font-size: 18px;
 font-weight: bold;
 text-align: right;
 padding: 2px;
 background-color: #3A8544;
}

/* Dialog ***************************************/
.bp-style {
 background-color: #eeeeee;
}

.bp-title {
 font-size: 18px;
 font-weight: bold;
 color: #000000;
}

.bp-subtitle {
 font-size: 12px;
 font-weight: bold;
}

.bpd-style {
 background-color: #ffffff;
 border: 1px solid #3A8544;
 padding: 2px;
 border-collapse: collapse;
 font-size: 12px;
 width: 100%;
}

.bpd-title {
 background-color: #e0e0e0;
 font-weight: bold;
}

.bpd-subtitle {
 background-color: #B3C1B3;
}

/* Calendar *************************************/
.bc-style {
 background-color: #ffffff;
 border: 1px solid #3A8544;459F51
}

.bc-page  {
 border: 1px solid #bfbfbf;
 background-color: #f3f3f3;
}

TH.bc-style {
 background-color: #e3e3e3;
 font-size: 14px;
}

.bc-title {
 font-size: 18px;
 font-weight: bold;
}

.bcd-style {
 font-size: 10px;
 text-decoration: none;
}

.bcd-active {
 font-size: 12px;
 font-weight: bold;
 text-decoration: none;
}

.bcd-inactive {
 font-size: 12px;
 color: #333333;
 text-decoration: none;
}

.bcd-empty {
 background-color: #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend {
 background-color: #e3e3e3;
}

.bc-workhours, .bc-alternate1, .bc-weekday {
 background-color: #eeeeee;
}

.bc-event {
 border: 1px solid #404040;
 background-color: #e0e0e0;
}

.bct-time {
 font-size: 12px;
 font-weight: bold;
 white-space: nowrap;
}

.bct-holiday {
 font-size: 12px;
 color: #808080;
}

.bct-event {
 font-size: 12px;
}

.bct-smalltime {
 font-size: 10px;
 color: #000000;
 white-space: nowrap;
}

.bct-smallholiday {
 font-size: 10px;
 color: #808080;
 white-space: nowrap;

}

.bct-smallevent {
 font-size: 10px;
 margin-bottom:1px;
 white-space: nowrap;
}

.bct-printevent {
 font-size: 12px;
}

.bct-printholiday {
 font-size: 12px;
 color: #808080;
}

.bct-printtime {
 font-size: 12px;
 font-weight: bold;
}

.bcm-style {
 background-color: #3A8544;
 color: #ffffff;
}

.bcm-text {
 color: #ffffff;
 font-size: 14px;
 font-weight: bold;
 padding: 0px 12px 0px 12px;
 background-color: #3A8544;
}

.bcm-text:hover {
 color: #ffffff;
 text-decoration: underline;
}

.be-style {
 font-size: 12px;
}

.be-title {
 font-size: 14px;
 font-weight: bold;
 color: #000000;
}

.be-description {
 font-size: 12px;
}

.be-heading {
 font-size: 12px;
 font-weight: bold;
}

/*** Category Layout ****************************/
TD.bcc-style {
 background-color: #ffffff;
 border: 1px solid #3A8544;
 font-size: 10px;
 text-align: center;}',
'stylesheets/schemes/77208121-0A43-427A-93B8CF5D48E2C4F2.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970',  '00000000-0000-0000-0000000000000000');

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (3, '966CA60F-F436-4EA6-9C148FE0214902EA', 0, 1, 'Rastafari', 'BODY {
 background-color : #ffffff;
 font-family : Verdana,Arial,Helvetica,sans-serif;
 font-size : 14px;
 text-decoration : none;
 scrollbar-base-color : #000000;
 scrollbar-arrow-color : #ffffff;
 scrollbar-track-color : #999999;
}

/* Header ***************************************/
.bh-style  {
 color: #000000;
 font-size: 18px;
 font-weight: bold;
 text-align : right;
 padding : 2px;
 background-color : #ffcc00;
}

/* Dialog ***************************************/
.bp-style  {
 background-color : #eeeeee;
}

.bp-title  {
 font-size : 18px;
 font-weight : bold;
 color: #000000;
}

.bp-subtitle  {
 font-size : 12px;
 font-weight : bold;
}

.bpd-style  {
 background-color : #ffffff;
 border : 1px solid #009900;
 padding : 2px;
 border-collapse : collapse;
 font-size : 12px;
 width : 100%;
}

.bpd-title  {
 background-color : #ff0000;
 font-weight : bold;
 border : 1px solid #ffcc00;
}

.bpd-subtitle  {
 background-color : #cccccc;
}

/* Calendar *************************************/
.bc-style  {
 background-color : #ffffff;
 border : 1px solid #000000;
}

.bc-page  {
 border : 1px solid #bfbfbf;
 background-color : #f3f3f3;
}

TH.bc-style  {
 background-color : #ff0000;
 font-size : 14px;
}

.bc-title  {
 font-size : 18px;
 font-weight : bold;
}

.bcd-style  {
 font-size : 10px;
 text-decoration : none;
}

.bcd-active  {
 font-size : 12px;
 font-weight : bold;
 text-decoration : none;
}

.bcd-inactive  {
 font-size : 12px;
 color : #333333;
 text-decoration : none;
}

.bcd-empty {
 background-color: #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend  {
 background-color : #e3e3e3;
}

.bc-workhours, .bc-alternate1, .bc-weekday  {
 background-color : #eeeeee;
}

.bc-event  {
 border : 1px solid #404040;
 background-color : #e0e0e0;
}

.bct-time  {
 font-size : 12px;
 font-weight : bold;
 white-space : nowrap;
}

.bct-holiday  {
 font-size : 12px;
 color : #808080;
}

.bct-event  {
 font-size : 12px;
}

.bct-smalltime  {
 font-size : 10px;
 color : #000000;
 white-space : nowrap;
}

.bct-smallholiday  {
 font-size : 10px;
 color : #808080;
 white-space : nowrap;
}

.bct-smallevent  {
 font-size : 10px;
 margin-bottom : 1px;
 white-space : nowrap;
}

.bct-printevent  {
 font-size : 12px;
}

.bct-printholiday  {
 font-size : 12px;
 color : #808080;
}

.bct-printtime  {
 font-size : 12px;
 font-weight : bold;
}

.bcm-style  {
 background-color : #000000;
 color : #ffffff;
}

.bcm-text  {
 color : #ffffff;
 font-size : 14px;
 font-weight : bold;
 padding : 0px 12px 0px 12px;
 background-color : #009900;
}

.bcm-text:hover  {
 color : #ffffff;
 text-decoration : underline;
}

.be-style  {
 font-size : 12px;
}

.be-title  {
 font-size : 14px;
 font-weight : bold;
 color: #000000;
}

.be-description  {
 font-size : 12px;
}

.be-heading  {
 font-size : 12px;
 font-weight : bold;
}

/* Category Layout ******************************/
TD.bcc-style  {
 background-color : #ffffff;
 border : 1px solid #000000;
 font-size : 10px;
 text-align : center;}',
'stylesheets/schemes/966CA60F-F436-4EA6-9C148FE0214902EA.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970',  '00000000-0000-0000-0000000000000000');

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (4, 'F933EE89-BF52-424E-B676E99ED287845B', 0, 1, 'Blue Monday', 'BODY {
 background-color : #D1D9DE;
 font-family : Verdana,Arial,Helvetica,sans-serif;
 font-size : 14px;
 text-decoration : none;
 scrollbar-base-color : #3E5D7C;
 scrollbar-arrow-color : #ffffff;
 scrollbar-track-color : #748FAB;
}

/* Header ***************************************/
.bh-style  {
 color : #ffffff;
 font-size : 18px;
 font-weight : bold;
 text-align : right;
 padding : 2px;
 background-color : #3E5D7C;
}

/* Dialog ***************************************/
.bp-style  {
 background-color : #e0e0e0;
}

.bp-title  {
 font-size : 18px;
 font-weight : bold;
}

.bp-subtitle  {
 font-size : 12px;
 font-weight : bold;
}

.bpd-style  {
 background-color : #ffffff;
 border : 1px solid #B6C4D2;
 padding : 2px;
 border-collapse : collapse;
 font-size : 12px;
 width : 100%;
}

.bpd-title  {
 background-color : #e0e0e0;
 font-weight : bold;
}

.bpd-subtitle  {
 background-color : #B6C4D2;
}


/* Calendar *************************************/
.bc-style  {
 background-color : #ffffff;
 border : 1px solid #B6C4D2;
}

.bc-page  {
 border : 1px solid #bfbfbf;
 background-color : #f3f3f3;
}

TH.bc-style  {
 background-color : #e3e3e3;
 font-size : 14px;
}

.bc-title  {
 font-size : 18px;
 font-weight : bold;
}

.bcd-style  {
 font-size : 10px;
 text-decoration : none;
}

.bcd-active  {
 font-size : 12px;
 font-weight : bold;
 text-decoration : none;
}

.bcd-inactive  {
 font-size : 12px;
 color : #333333;
 text-decoration : none;
}

.bcd-empty {
 background-color: #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend  {
 background-color : #e3e3e3;
}

.bc-workhours, .bc-alternate1, .bc-weekday  {
 background-color : #eeeeee;
}

.bc-event  {
 border : 1px solid #3E5D7C;
 background-color : #e0e0e0;
}

.bct-time  {
 font-size : 12px;
 font-weight : bold;
 white-space : nowrap;
}

.bct-holiday  {
 font-size : 12px;
 color : #808080;
}

.bct-event  {
 font-size : 12px;
}

.bct-smalltime  {
 font-size : 10px;
 color : #000000;
 white-space : nowrap;
}

.bct-smallholiday  {
 font-size : 10px;
 color : #808080;
 white-space : nowrap;
}

.bct-smallevent  {
 font-size : 10px;
 margin-bottom : 1px;
 white-space : nowrap;
}

.bct-printevent  {
 font-size : 12px;
}

.bct-printholiday  {
 font-size : 12px;
 color : #808080;
}

.bct-printtime  {
 font-size : 12px;
 font-weight : bold;
}

.bcm-style  {
 background-color : #748FAB;
}

.bcm-text  {
 background-color : #748FAB;
 color : #ffffff;
 font-size : 14px;
 font-weight : bold;
 padding : 0px 12px 0px 12px;
}

.bcm-text:hover  {
 color : #ffffff;
 text-decoration : underline;
}

.be-style  {
 font-size : 12px;
}

.be-title  {
 font-size : 14px;
 font-weight : bold;
}

.be-description  {
 font-size : 12px;
}

.be-heading  {
 font-size : 12px;
 font-weight : bold;
}

/* Category Layout ******************************/
TD.bcc-style  {
 background-color : #ffffff;
 border : 1px solid #748FAB;
 font-size : 10px;
 text-align : center;}',
'stylesheets/schemes/F933EE89-BF52-424E-B676E99ED287845B.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970',  '00000000-0000-0000-0000000000000000');

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (5, '4074481C-55AB-43A5-8806CD03171F1D7F', 0, 1, 'Dirt', 'BODY {
 background-color : #D1D9DE;
 font-family : Verdana,Arial,Helvetica,sans-serif;
 font-size : 14px;
 text-decoration : none;
 scrollbar-base-color : #A29A6C;
 scrollbar-arrow-color : #000000;
 scrollbar-track-color : #776D39;
}

/* Header ***************************************/
.bh-style  {
 color : #ffffff;
 font-size : 18px;
 font-weight : bold;
 text-align : right;
 padding : 2px;
 background-color : #776D39;
}

/* Dialog ***************************************/
.bp-style  {
 background-color : #e0e0e0;
}

.bp-title  {
 font-size : 18px;
 font-weight : bold;
}

.bp-subtitle  {
 font-size : 12px;
 font-weight : bold;
}

.bpd-style  {
 background-color : #ffffff;
 border : 1px solid #A29A6C;
 padding : 2px;
 border-collapse : collapse;
 font-size : 12px;
 width : 100%;
}

.bpd-title  {
 background-color : #A29A6C;
 font-weight : bold;
 color : #000000;
}

.bpd-subtitle  {
 background-color : #C6C3AC;
}

/* Calendar *************************************/
.bc-style  {
 background-color : #ffffff;
 border : 1px solid #776D39;
}

.bc-page  {
 border : 1px solid #d0d0d0;
 background-color : #f3f3f3;
}

TH.bc-style  {
 background-color : #D2CDC5;
 font-size : 14px;
}

.bc-title  {
 font-size : 18px;
 font-weight : bold;
}

.bcd-style  {
 font-size : 10px;
 text-decoration : none;
}

.bcd-active  {
 font-size : 12px;
 font-weight : bold;
 text-decoration : none;
}

.bcd-inactive  {
 font-size : 12px;
 color : #333333;
 text-decoration : none;
}

.bcd-empty  {
 background-color : #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend  {
 background-color : #D2CDC5;
}

.bc-workhours, .bc-alternate1, .bc-weekday  {
 background-color : #D9D6CF;
}

.bc-event  {
 border : 1px solid #A29A6C;
 background-color : #D2CDC5;
}

.bct-time  {
 font-size : 12px;
 font-weight : bold;
 white-space : nowrap;
}

.bct-holiday  {
 font-size : 12px;
 color : #808080;
}

.bct-event  {
 font-size : 12px;
}

.bct-smalltime  {
 font-size : 10px;
 color : #000000;
 white-space : nowrap;
}

.bct-smallholiday  {
 font-size : 10px;
 color : #808080;
 white-space : nowrap;
}

.bct-smallevent  {
 font-size : 10px;
 margin-bottom : 1px;
 white-space : nowrap;
}

.bct-printevent  {
 font-size : 12px;
}

.bct-printholiday  {
 font-size : 12px;
 color : #808080;
}

.bct-printtime  {
 font-size : 12px;
 font-weight : bold;
}

.bcm-style  {
 background-color : #A29A6C;
}

.bcm-text  {
 background-color : #776D39;
 color : #ffffff;
 font-size : 14px;
 font-weight : bold;
 padding : 0px 12px 0px 12px;
}

.bcm-text:hover  {
 color : #ffffff;
 text-decoration : underline;
}

.be-style  {
 font-size : 12px;
}

.be-title  {
 font-size : 14px;
 font-weight : bold;
}

.be-description  {
 font-size : 12px;
}

.be-heading  {
 font-size : 12px;
 font-weight : bold;
}

/* Category Layout ******************************/
TD.bcc-style  {
 background-color : #ffffff;
 border : 1px solid #776D39;
 font-size : 10px;
 text-align : center;}',
'stylesheets/schemes/4074481C-55AB-43A5-8806CD03171F1D7F.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (6, '2F0D0CBC-9B41-4269-BC6D312071364BC7', 0, 1, 'Ice', 'BODY {
 background-color : #D1D9DE;
 font-family : Verdana,Arial,Helvetica,sans-serif;
 font-size : 14px;
 text-decoration : none;
 scrollbar-base-color : #C5D3DB;
 scrollbar-arrow-color : #000000;
 scrollbar-track-color : #B1C0C9;
}

/* Header ***************************************/
.bh-style  {
 color : #ffffff;
 font-size : 18px;
 font-weight : bold;
 text-align : right;
 padding : 2px;
 background-color : #B1C0C9;
}

/* Dialog ***************************************/
.bp-style  {
 background-color : #E7ECED;
}

.bp-title  {
 font-size : 18px;
 font-weight : bold;
}

.bp-subtitle  {
 font-size : 12px;
 font-weight : bold;
}

.bpd-style  {
 background-color : #ffffff;
 border : 1px solid #C5D3DB;
 padding : 2px;
 border-collapse : collapse;
 font-size : 12px;
 width : 100%;
}

.bpd-title  {
 background-color : #C5D3DB;
 font-weight : bold;
 color : #000000;
}

.bpd-subtitle  {
 background-color : #DDE4E9;
}

/* Calendar *************************************/
.bc-style  {
 background-color : #ffffff;
 border : 1px solid #B1C0C9;
 color : #333333;
}

.bc-page  {
 border : 1px solid #d0d0d0;
 background-color : #f3f3f3;
}

TH.bc-style  {
 background-color : #C5D3DB;
 font-size : 14px;
}

.bc-title  {
 font-size : 18px;
 font-weight : bold;
}

.bcd-style  {
 font-size : 10px;
 text-decoration : none;
}

.bcd-active  {
 font-size : 12px;
 font-weight : bold;
 text-decoration : none;
}

.bcd-inactive  {
 font-size : 12px;
 color : #333333;
 text-decoration : none;
}

.bcd-empty  {
 background-color : #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend  {
 background-color : #E7ECED;
}

.bc-workhours, .bc-alternate1, .bc-weekday  {
 background-color : #DDE4E9;
}

.bc-event  {
 border : 1px solid #C5D3DB;
 background-color : #DDE4E9;
}

.bct-time  {
 font-size : 12px;
 font-weight : bold;
 white-space : nowrap;
}

.bct-holiday  {
 font-size : 12px;
 color : #808080;
}

.bct-event  {
 font-size : 12px;
}

.bct-smalltime  {
 font-size : 10px;
 color : #000000;
 white-space : nowrap;
}

.bct-smallholiday  {
 font-size : 10px;
 color : #808080;
 white-space : nowrap;
}

.bct-smallevent  {
 font-size : 10px;
 margin-bottom : 1px;
 white-space : nowrap;
}

.bct-printevent  {
 font-size : 12px;
 background-color : #C5D3DB;
}

.bct-printholiday  {
 font-size : 12px;
 color : #808080;
}

.bct-printtime  {
 font-size : 12px;
 font-weight : bold;
}

.bcm-style  {
 background-color : #C5D3DB;
}

.bcm-text  {
 background-color : #B1C0C9;
 color : #ffffff;
 font-size : 14px;
 font-weight : bold;
 padding : 0px 12px 0px 12px;
}

.bcm-text:hover  {
 color : #ffffff;
 text-decoration : underline;
}

.be-style  {
 font-size : 12px;
}

.be-title  {
 font-size : 14px;
 font-weight : bold;
}

.be-description  {
 font-size : 12px;
}

.be-heading  {
 font-size : 12px;
 font-weight : bold;
}

/* Category Layout ******************************/
TD.bcc-style  {
 background-color : #ffffff;
 border : 1px solid #B1C0C9;
 font-size : 10px;
 text-align : center; }',
'stylesheets/schemes/2F0D0CBC-9B41-4269-BC6D312071364BC7.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');

INSERT INTO schemes (schemeDsid, schemeId, calendarDsid, globalObject, title, stylesheet, filePath, createDate, createBy, updateDate, updateBy)
VALUES (7, 'DC1DFB89-0F71-48EC-9AF030DAD5E4815C', 0, 1, 'Black as Night', 'BODY {
 background-color : #d1d9de;
 font-family : Verdana,Arial,Helvetica,sans-serif;
 font-size : 14px;
 text-decoration : none;
 scrollbar-base-color : #000000;
 scrollbar-arrow-color : #ffffff;
 scrollbar-track-color : #707070;
}

/* Header ***************************************/
.bh-style  {
 color : #ffffff;
 font-size : 18px;
 font-weight : bold;
 text-align : right;
 padding : 2px;
 background-color : #000000;
}

/* Dialog ***************************************/
.bp-style  {
 background-color : #E7ECED;
}

.bp-title  {
 font-size : 18px;
 font-weight : bold;
}

.bp-subtitle  {
 font-size : 12px;
 font-weight : bold;
}

.bpd-style  {
 background-color : #ffffff;
 border : 1px solid #C5D3DB;
 padding : 2px;
 border-collapse : collapse;
 font-size : 12px;
 width : 100%;
}

.bpd-title  {
 background-color : #1B1B1B;
 font-weight : bold;
 color : #ffffff;
}

.bpd-subtitle  {
 background-color : #707070;
 color : #ffffff;
}

/* Calendar *************************************/
.bc-style  {
 background-color : #ffffff;
 border : 1px solid #1B1B1B;
}

.bc-page  {
 border : 1px solid #d0d0d0;
 background-color : #f3f3f3;
}

TH.bc-style  {
 background-color : #707070;
 font-size : 14px;
 color : #ffffff;
}

.bc-title  {
 font-size : 18px;
 font-weight : bold;
}

.bcd-style  {
 font-size : 10px;
 text-decoration : none;
}

.bcd-active  {
 font-size : 12px;
 font-weight : bold;
 text-decoration : none;
}

.bcd-inactive  {
 font-size : 12px;
 color : #333333;
 text-decoration : none;
}

.bcd-empty  {
 background-color : #e0e0e0;
}

.bc-afterhours, .bc-alternate2, .bc-weekend  {
 background-color : #eeeeee;
}

.bc-workhours, .bc-alternate1, .bc-weekday  {
 background-color : #e3e3e3;
}

.bc-event  {
 border : 1px solid #C5D3DB;
 background-color : #cfcfcf;
}

.bct-time  {
 font-size : 12px;
 font-weight : bold;
 white-space : nowrap;
}

.bct-holiday  {
 font-size : 12px;
 color : #808080;
}

.bct-event  {
 font-size : 12px;
}

.bct-smalltime  {
 font-size : 10px;
 color : #000000;
 white-space : nowrap;
}

.bct-smallholiday  {
 font-size : 10px;
 color : #808080;
 white-space : nowrap;
}

.bct-smallevent  {
 font-size : 10px;
 margin-bottom : 1px;
 white-space : nowrap;
}

.bct-printevent  {
 font-size : 12px;
 background-color : #cfcfcf;
}

.bct-printholiday  {
 font-size : 12px;
 color : #808080;
}

.bct-printtime  {
 font-size : 12px;
 font-weight : bold;
}

.bcm-style  {
 background-color : #cfcfcf;
}

.bcm-text  {
 background-color : #1B1B1B;
 color : #ffffff;
 font-size : 14px;
 font-weight : bold;
 padding : 0px 12px 0px 12px;
}

.bcm-text:hover  {
 color : #ffffff;
 text-decoration : underline;
}

.be-style  {
 font-size : 12px;
}

.be-title  {
 font-size : 14px;
 font-weight : bold;
}

.be-description  {
 font-size : 12px;
}

.be-heading  {
 font-size : 12px;
 font-weight : bold;
}

/* Category Layout ******************************/
TD.bcc-style  {
 background-color : #ffffff;
 border : 1px solid #1B1B1B;
 font-size : 10px;
 text-align : center; }', 
'stylesheets/schemes/DC1DFB89-0F71-48EC-9AF030DAD5E4815C.css', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO searchindexes (searchIndexDsid, searchIndexId, title, collection, calendarDsid, createDate, createBy, updateDate, updateBy) VALUES (1, '09436E48-E029-4712-3DB2C2F6DF405981', 'Search Index for 29427EC2-E029-4712-3D7B173E956040E5', 'calendarInfusion_09436E48-E029-4712-3DB2C2F6DF405981', 1, '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO status (statusDsid, code) VALUES (1, 'approved');
INSERT INTO status (statusDsid, code) VALUES (2, 'pending');
GO

INSERT INTO users (userDsid, userId, userlogin, userpassword, firstname, lastname, timezone, createDate, createBy, updateDate, updateBy) VALUES (1, '0E1E4A22-E029-4712-3DAAE52EF42AF979', 'administrator', 'password', 'Application', 'Administrator', '085', '1/1/1970', '00000000-0000-0000-0000000000000000', '1/1/1970', '00000000-0000-0000-0000000000000000');
GO

INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 1);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 2);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 3);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 4);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 5);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 6);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 7);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 8);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 9);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 10);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 11);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 12);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 13);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 14);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 15);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 16);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 17);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 18);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 19);
INSERT INTO calendars_holidays (calendarDsid, holidayDsid) VALUES (1, 20);
GO

INSERT INTO groups_rights (groupDsid, rightDsid) VALUES (1, 1);
GO

INSERT INTO users_groups (userDsid, groupDsid) VALUES (1, 1);
GO

INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 1);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 2);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 3);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 4);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 5);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 6);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 7);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 8);
INSERT INTO users_rights (userDsid, rightDsid) VALUES (1, 9);
GO



