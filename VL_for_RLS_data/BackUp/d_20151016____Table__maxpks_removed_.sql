USE [RLS]
GO

/****** Object:  Table [dbo].[maxpks]    Script Date: 10/16/2015 2:46:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[maxpks](
	[T] [varchar](18) NOT NULL,
	[N] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/*
T	N
AnswerSet_number	56
Svy_RespAnswer_pk	3839923
Pew_Answer_NoStd	1103
Pew_Answer_Std	10442
Pew_Question_NoStd	167
Pew_Question_Std	87