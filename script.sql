USE [Task1]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [int] NOT NULL,
	[Name] [varchar](255) NULL,
	[Author] [varchar](255) NULL,
	[IsAvailable] [bit] NULL,
	[Price] [decimal](10, 2) NULL,
	[RackID] [int] NULL,
	[ShelfID] [int] NULL,
	[Flag] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Racks]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Racks](
	[Code] [varchar](255) NULL,
	[RackID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shelves]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shelves](
	[Code] [varchar](255) NOT NULL,
	[ShelfID] [int] IDENTITY(1,1) NOT NULL,
	[RackID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ShelfID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([BookID], [Code], [Name], [Author], [IsAvailable], [Price], [RackID], [ShelfID], [Flag]) VALUES (1, 1, N'C Programming Absolute Beginner''s Guide', N'Greg Perry 3rd edition Edition. 3rd. Publisher. Que Publishing. Publication date. August 7, 2013 ', 1, CAST(100.00 AS Decimal(10, 2)), 1, 2, 1)
INSERT [dbo].[Book] ([BookID], [Code], [Name], [Author], [IsAvailable], [Price], [RackID], [ShelfID], [Flag]) VALUES (2, 2, N'C Programming Language', N'Kernighan Brian W. 2nd edition Publisher. Pearson. Publication date. March 22, 1988', 1, CAST(200.00 AS Decimal(10, 2)), 1, 2, 1)
INSERT [dbo].[Book] ([BookID], [Code], [Name], [Author], [IsAvailable], [Price], [RackID], [ShelfID], [Flag]) VALUES (3, 3, N'Head First C: A Brain-Friendly ', N'David Griffiths 1st edition  Griffiths, David J. (1981).', 1, CAST(100.00 AS Decimal(10, 2)), 2, 2, 1)
INSERT [dbo].[Book] ([BookID], [Code], [Name], [Author], [IsAvailable], [Price], [RackID], [ShelfID], [Flag]) VALUES (4, 25, N'C: The Complete Reference', N'Herbert Schildt 4th edition 4th edition (December 10, 2002)', 1, CAST(300.00 AS Decimal(10, 2)), 1, 1, 1)
INSERT [dbo].[Book] ([BookID], [Code], [Name], [Author], [IsAvailable], [Price], [RackID], [ShelfID], [Flag]) VALUES (6, 3456, N'fgh', N'fdghfgjh', 1, CAST(54657.00 AS Decimal(10, 2)), 1, 1, 0)
INSERT [dbo].[Book] ([BookID], [Code], [Name], [Author], [IsAvailable], [Price], [RackID], [ShelfID], [Flag]) VALUES (5, 34454, N'etst', N'sfdsfg', 1, CAST(24354.00 AS Decimal(10, 2)), 2, 2, 0)
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
SET IDENTITY_INSERT [dbo].[Racks] ON 

INSERT [dbo].[Racks] ([Code], [RackID]) VALUES (N'R001', 1)
INSERT [dbo].[Racks] ([Code], [RackID]) VALUES (N'R002', 2)
SET IDENTITY_INSERT [dbo].[Racks] OFF
GO
SET IDENTITY_INSERT [dbo].[Shelves] ON 

INSERT [dbo].[Shelves] ([Code], [ShelfID], [RackID]) VALUES (N'S001', 1, 1)
INSERT [dbo].[Shelves] ([Code], [ShelfID], [RackID]) VALUES (N'S002', 2, 2)
SET IDENTITY_INSERT [dbo].[Shelves] OFF
GO
ALTER TABLE [dbo].[Shelves]  WITH CHECK ADD  CONSTRAINT [FK_Shelves_Racks] FOREIGN KEY([RackID])
REFERENCES [dbo].[Racks] ([RackID])
GO
ALTER TABLE [dbo].[Shelves] CHECK CONSTRAINT [FK_Shelves_Racks]
GO
/****** Object:  StoredProcedure [dbo].[DeleteBook]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteBook]
	  @Code int
AS
BEGIN
	Update Book set Flag = 0  where Code =@Code
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllBookslist]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllBookslist]
	
AS
BEGIN
	SELECT  [BookID]
      ,B.Code
      ,[Name]
      ,[Author]
      ,[IsAvailable]
      ,[Price]
      ,r.Code as 'RackID'
      ,S.Code as 'ShelfID'
      ,[Flag]
  FROM [Task1].[dbo].[Book] B  
  inner join  Racks R on R.RackID =  b.RackID 
   inner join  Shelves S on S.ShelfID =  b.ShelfID
	where flag = 1
END


GO
/****** Object:  StoredProcedure [dbo].[InsertNewBookDetails]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertNewBookDetails]
	@Code int,
	@Name  varchar(255)=null,
	@Author  Varchar(255)=null,
	@IsAvailable bit=false,
	@Price decimal=null,
	@RackID int=1,
	@ShelfID int=123456
AS
BEGIN
	insert into Book (Code, Name, Author, IsAvailable, Price,RackID, ShelfID, flag)  values(@Code, @Name, @Author , @IsAvailable , @Price , @RackID, @ShelfID, 1)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBookDetails]    Script Date: 4/28/2023 3:44:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateBookDetails]
	@BookID int,
	@Name  varchar(255)=null,
	@Author  Varchar(255)=null,
	@IsAvailable bit=false,
	@Price decimal=null,
	@RackID int=1,
	@ShelfID int=123456
AS
BEGIN
	update book set Name =@Name, 
	Author =@Author,
	IsAvailable = @IsAvailable,
	Price =@Price,
	RackID= @RackID,
	ShelfID = @ShelfID
	where BookID =@BookID
END
GO
