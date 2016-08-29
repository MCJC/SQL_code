Thank you, Fengyan!

I’d add some security backup in the code, something as:

/**************************************************************************************************************************/
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Answer_2013_06_05]
  FROM      [forum].[dbo].[Pew_Answer]
/**************************************************************************************************************************/

Regarding DataSource_pk, same procedure

I already added the provisional parameters

Once you finish the code the three tables can be updated today in the main database


Best

Juan Carlos




From: Anne Shi 
Sent: Wednesday, July 31, 2013 10:19 AM
To: Juan Carlos Esparza Ochoa
Subject: RE: Pew_field

Hi Juan Carlos,
Thank you very much! It’s like this now (below). Please tell me about DataSource_pk. Thank you.
Anne

***
USE SHIdb
GO

--SELECT *
--INTO [dbo].[Pew_Field]
--FROM [FORUM].[dbo].[Pew_Field]

DROP TABLE [dbo].[Pew_Field]

/****** Object:  Table [dbo].[Pew_Field]    Script Date: 7/30/2013 12:55:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pew_Field](
       [Field_pk] [int] NOT NULL,
       [Field_name] [nvarchar](50) NULL,
       [Field_note] [nvarchar](255) NULL,
       [Field_type] [nvarchar](50) NULL,
       [Field_year] [nvarchar](15) NULL,
       [Data_source_fk] [int] NULL,
CONSTRAINT [PK_Pew_Field] PRIMARY KEY CLUSTERED 
(
       [Field_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO SHIdb..[Pew_Field]
SELECT * 
FROM forum..Pew_Field

INSERT INTO SHIdb..[Pew_Field]
  VALUES
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+1, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+2, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+3, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+4, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+5, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+6, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+7, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL),
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+8, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL)
  ((SELECT DISTINCT MAX([Field_pk]) FROM SHIdb.[dbo].[Pew_Field])+2, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', NULL)



From: Juan Carlos Esparza Ochoa 
Sent: Wednesday, July 31, 2013 9:46 AM
To: Anne Shi
Subject: RE: Pew_field

Hi Fengyan,

Yes!
I think that the main part mostly works, but it does not automatically selects the pk value

We should also link to new data-source pks


INSERT INTO SHIdb..[Pew_Field]
  VALUES
  (55, 'Migration Flow', 'Pew Estimate', NULL, 2010, NULL),
  (56, 'Migration Flow', 'Pew Estimate', NULL, 2015, NULL),
  (57, 'Migration Flow', 'Pew Estimate', NULL, 2020, NULL),
  (58, 'Migration Flow', 'Pew Estimate', NULL, 2025, NULL),
  (59, 'Migration Flow', 'Pew Estimate', NULL, 2030, NULL),
  (60, 'Migration Flow', 'Pew Estimate', NULL, 2035, NULL),
  (61, 'Migration Flow', 'Pew Estimate', NULL, 2040, NULL),
  (62, 'Migration Flow', 'Pew Estimate', NULL, 2045, NULL)

This could probably help:
 
Please let me know of any questions

Juan Carlos


From: Anne Shi 
Sent: Tuesday, July 30, 2013 6:21 PM
To: Juan Carlos Esparza Ochoa
Subject: Pew_field

Hi Juan Carlos,
Is this the way to update the Pew_Field table? Thank you.
Anne

USE SHIdb
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pew_Field](
       [Field_pk] [int] NOT NULL,
       [Field_name] [nvarchar](50) NULL,
       [Field_note] [nvarchar](255) NULL,
       [Field_type] [nvarchar](50) NULL,
       [Field_year] [nvarchar](15) NULL,
       [Data_source_fk] [int] NULL,
CONSTRAINT [PK_Pew_Field] PRIMARY KEY CLUSTERED 
(
       [Field_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO SHIdb..[Pew_Field]
SELECT * 
FROM forum..Pew_Field

INSERT INTO SHIdb..[Pew_Field]
  VALUES
  (55, 'Migration Flow', 'Pew Estimate', NULL, 2010, NULL),
  (56, 'Migration Flow', 'Pew Estimate', NULL, 2015, NULL),
  (57, 'Migration Flow', 'Pew Estimate', NULL, 2020, NULL),
  (58, 'Migration Flow', 'Pew Estimate', NULL, 2025, NULL),
  (59, 'Migration Flow', 'Pew Estimate', NULL, 2030, NULL),
  (60, 'Migration Flow', 'Pew Estimate', NULL, 2035, NULL),
  (61, 'Migration Flow', 'Pew Estimate', NULL, 2040, NULL),
  (62, 'Migration Flow', 'Pew Estimate', NULL, 2045, NULL)


