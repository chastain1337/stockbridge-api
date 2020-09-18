USE [master]
GO
/****** Object:  Database [StockBridge]    Script Date: 9/18/2020 4:21:26 PM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'StockBridge')
BEGIN
CREATE DATABASE [StockBridge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Omobono', FILENAME = N'C:\Omobono.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Omobono_log', FILENAME = N'C:\Omobono_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [StockBridge] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StockBridge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StockBridge] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StockBridge] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StockBridge] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StockBridge] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StockBridge] SET ARITHABORT OFF 
GO
ALTER DATABASE [StockBridge] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StockBridge] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StockBridge] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StockBridge] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StockBridge] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StockBridge] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StockBridge] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StockBridge] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StockBridge] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StockBridge] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StockBridge] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StockBridge] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StockBridge] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StockBridge] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StockBridge] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StockBridge] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StockBridge] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StockBridge] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StockBridge] SET  MULTI_USER 
GO
ALTER DATABASE [StockBridge] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StockBridge] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StockBridge] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StockBridge] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StockBridge] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StockBridge] SET QUERY_STORE = OFF
GO
USE [StockBridge]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [StockBridge]
GO
/****** Object:  Schema [Employee]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Employee')
EXEC sys.sp_executesql N'CREATE SCHEMA [Employee]'
GO
/****** Object:  Schema [Product]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Product')
EXEC sys.sp_executesql N'CREATE SCHEMA [Product]'
GO
/****** Object:  Schema [Vendor]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Vendor')
EXEC sys.sp_executesql N'CREATE SCHEMA [Vendor]'
GO
/****** Object:  Schema [Warehouse]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Warehouse')
EXEC sys.sp_executesql N'CREATE SCHEMA [Warehouse]'
GO
/****** Object:  Table [Employee].[Department]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Department]') AND type in (N'U'))
BEGIN
CREATE TABLE [Employee].[Department](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[SystemName] [nchar](100) NOT NULL,
	[DeletedFlag] [bit] NOT NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[ModifiedByEmployeeID] [int] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Employee].[Employee]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
BEGIN
CREATE TABLE [Employee].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [binary](64) NOT NULL,
	[StartDate] [date] NOT NULL,
	[RoleID] [int] NOT NULL,
	[AvailableVacationHours] [decimal](5, 2) NULL,
	[BaseRate] [money] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[TerminatedFlag] [bit] NOT NULL,
 CONSTRAINT [PK_Employee.Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Employee].[Role]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
BEGIN
CREATE TABLE [Employee].[Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[SystemName] [nvarchar](30) NOT NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[DeletedFlag] [bit] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Product].[Product]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[Product]') AND type in (N'U'))
BEGIN
CREATE TABLE [Product].[Product](
	[ID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[SKU] [nvarchar](15) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PartNumber] [nvarchar](50) NOT NULL,
	[OrderingPartNumber] [nvarchar](50) NULL,
	[PrimaryVendorID] [int] NULL,
	[SecondaryVendorID] [int] NULL,
	[LastUnitCost] [decimal](7, 2) NOT NULL,
	[LocationID] [int] NULL,
	[CasePack] [int] NOT NULL,
	[Length_IN] [decimal](4, 2) NULL,
	[Width_IN] [decimal](4, 2) NULL,
	[Height_IN] [decimal](4, 2) NULL,
	[Weight_OZ] [int] NULL,
	[Minimum] [int] NOT NULL,
	[Maximum] [int] NOT NULL,
	[ShelfCount] [int] NOT NULL,
	[Pending] [int] NOT NULL,
	[OnOrder] [int] NOT NULL,
	[Available]  AS ([ShelfCount]-[Pending]),
	[ToOrderQuantity]  AS (case when ([Maximum]-(([ShelfCount]-[Pending])+[OnOrder]))>(0) then [Maximum]-(([ShelfCount]-[Pending])+[OnOrder]) else (0) end),
	[ToOrderAmount]  AS ([LastUnitCost]*case when ([Maximum]-(([ShelfCount]-[Pending])+[OnOrder]))>(0) then [Maximum]-(([ShelfCount]-[Pending])+[OnOrder]) else (0) end),
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Vendor].[OrderingMethod]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[OrderingMethod]') AND type in (N'U'))
BEGIN
CREATE TABLE [Vendor].[OrderingMethod](
	[ID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
	[MethodName] [nvarchar](50) NOT NULL,
	[MethodSystemName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OrderingMethods] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Vendor].[Vendor]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[Vendor]') AND type in (N'U'))
BEGIN
CREATE TABLE [Vendor].[Vendor](
	[ID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[Code] [nvarchar](5) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[OrderingMin] [decimal](4, 2) NULL,
	[OrderingMethodID] [int] NOT NULL,
	[Email] [nvarchar](50) NULL,
	[AccountNumber] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[WillDropShipForUs] [bit] NULL,
	[WillChargeFreightForDropShip] [bit] NULL,
	[WillChargeFreightForOrders] [bit] NULL,
	[LeadTimeBusinessDays] [int] NULL,
	[UseAutoOrdering] [bit] NOT NULL,
 CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [Warehouse].[Location]    Script Date: 9/18/2020 4:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Warehouse].[Location]') AND type in (N'U'))
BEGIN
CREATE TABLE [Warehouse].[Location](
	[ID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
	[DeleteFlag] [bit] NOT NULL,
	[QuickPick] [int] NULL,
	[Aisle] [int] NULL,
	[Section] [char](2) NULL,
	[Shelf] [int] NULL,
	[Name]  AS (concat(coalesce([Aisle],''),coalesce([Section],''),coalesce([Shelf],''))),
	[CustomName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [Employee].[Department] ON 

INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (1, N'Accounting', N'Accounting                                                                                          ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (2, N'Development', N'Development                                                                                         ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (3, N'Warehouse', N'Warehouse                                                                                           ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (4, N'Shipping', N'Shipping                                                                                            ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (5, N'Customer Service', N'CustomerService                                                                                     ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (6, N'Other', N'Other                                                                                               ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (7, N'Human Resources', N'HumanResources                                                                                      ', 0, 1, CAST(N'2020-09-16T11:31:27.950' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (8, N'IT', N'IT                                                                                                  ', 0, 1, CAST(N'2020-09-16T16:35:21.400' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (9, N'Maintenance', N'Maintenance                                                                                         ', 0, 1, CAST(N'2020-09-16T16:35:58.477' AS DateTime), NULL, NULL)
INSERT [Employee].[Department] ([ID], [Name], [SystemName], [DeletedFlag], [CreatedByEmployeeID], [DateCreated], [DateModified], [ModifiedByEmployeeID]) VALUES (10, N'Public Relations', N'PublicRelations                                                                                     ', 0, 1, CAST(N'2020-09-16T16:39:38.683' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [Employee].[Department] OFF
SET IDENTITY_INSERT [Employee].[Employee] ON 

INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (1, CAST(N'2020-09-16T11:35:37.163' AS DateTime), CAST(N'2020-09-18T09:02:55.613' AS DateTime), 1, NULL, N'Admin', N'User', N'admin', N'admin@stockbridge.com', 0xC7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC, CAST(N'2020-01-01' AS Date), 1, CAST(0.00 AS Decimal(5, 2)), 0.0000, 6, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (32, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Douglas', N'Adams', N'dAdams', N'dAdams@stockbridge.com', 0x1CACF396B051E9F452A8CF4F5C3EACC950C3B8E737B95C6822502CB5AF1AEB39B538905A9F8B7D7DA56333CF8603049AD08A9D4A843E48C80926DFC05291CEF3, CAST(N'2020-09-14' AS Date), 1, CAST(42.00 AS Decimal(5, 2)), 42.0000, 5, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (33, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Sou', N'Granholm', N'sGranholm', N'sgranholm@stockbridge.com', 0xAD99698A6C99A274E73010B99269407B8018856F80651CF0419CBED6AD8F2D0F53275BC57DCB6BCEC5C689A540371E3BA8907DCE33584BEB2F48987DE093EEE0, CAST(N'2018-04-18' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 17.6600, 5, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (34, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Sunnie', N'Meyette', N'sMeyette', N'smeyette@stockbridge.com', 0x77D642069DBFE8C2B7627E8D8F1B24C5139BC5722E801960C2E0238F465CF67A6CFE2CDBE0C132DB1D46EEB185FC953B3A6E55E1547DA2305F7CC88C9C668B01, CAST(N'2014-11-04' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 31.7800, 5, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (35, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Shunteria', N'Ritchhart', N'sRitchhart', N'sritchhart@stockbridge.com', 0xFFB21B26DE67FBA3FAC5F42445B3C3DAEE44B93D174966A5AC89645E9145998FFF63E649868EEED9E8643F5985D1D14524650AF02A0448E97E058E57A602C029, CAST(N'2016-10-21' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 14.8000, 5, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (36, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Ashleigh', N'Neddo', N'aNeddo', N'aneddo@stockbridge.com', 0xE77DF7233F66A9B8285FA6EC7570893594BD6267379A31266907D5A41FA8349C55642D691A547653B2875FAA35328F574E77D62E943B614E1BE46BB77BF3167D, CAST(N'2019-11-19' AS Date), 2, CAST(120.00 AS Decimal(5, 2)), 32.2800, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (37, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Malary', N'Crease', N'mCrease', N'mcrease@stockbridge.com', 0x2FFCDF77DAA599F23C958EB0ADA57A02938D8F4B5DDE813740F6B6276D5D71F757BC099FDD590466E174ABE4B377D680BFFBAF0ED4036B326BCB5F61C964D41C, CAST(N'2017-01-30' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 9.3000, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (38, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Ernestina', N'Angland', N'eAngland', N'eangland@stockbridge.com', 0xFDAC710A33A1AC40E7020C616E571C68F90CD236E9FA6480C878BA02A768FCC2ABB1A75EEB4A430C2C55049CC35F89D72C1AE7A8A8EB76F219EB35E9EF911393, CAST(N'2015-08-23' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 12.0800, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (39, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Travaris', N'Brahney', N'tBrahney', N'tbrahney@stockbridge.com', 0xD4C6EE8E12D20C165EE437B941221F404D90A958CDEDB3DD50A142B13F1098E1708783727B105EC11397510C89D25E216A29A0F5B6BA2065C1C7C29C96772DE9, CAST(N'2018-09-22' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 17.7500, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (40, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL, N'Rahmell', N'Aranas', N'rAranas', N'raranas@stockbridge.com', 0xEF71388E3D2879011864834F8C7B539875884EB80FA9F190EA5F53B390E582B97FFA38B8944F67C480A61963ADE00486469B8DA3FA310499BAFB094898A5642B, CAST(N'2014-01-04' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 7.5100, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (41, CAST(N'2020-09-16T13:34:51.783' AS DateTime), NULL, 1, NULL, N'Micaela', N'Moron', N'mMoron', N'mmoron@stockbridge.com', 0xAF612D0874B38479203C9C9029203B9B93AAF8C93990AC437CDBFE8555DCA58FE2157407DFB60F83FE49F9D34B524A853D7DFF472683E224429083127F0CC50E, CAST(N'2019-04-10' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 21.2200, 1, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (42, CAST(N'2020-09-16T16:14:30.453' AS DateTime), NULL, 1, NULL, N'Latika', N'Sandefer', N'lSandefer', N'lsandefer@stockbridge.com', 0x0F753C284A5E64ABA3101B30F66ED97D7B96B9884FFCFFCAC2DB70D1D1B2A0A887BFF6341C8D0712A77732BDED68CB01BC592E7E80DF0969FEC4382B84C70519, CAST(N'2014-03-13' AS Date), 2, CAST(120.00 AS Decimal(5, 2)), 31.6600, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (43, CAST(N'2020-09-16T16:43:14.790' AS DateTime), NULL, 1, NULL, N'Nicholis', N'Barze', N'nBarze', N'nbarze@stockbridge.com', 0x8C9388AC70F15CC60E7297AFA2BD08E64CD974ED264B2B27EB41FE3F92D5B1012169C9481B1F64507328A789702C15A6A96E67439C00AA09152AF2E435626175, CAST(N'2015-04-22' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 34.7300, 2, 0)
INSERT [Employee].[Employee] ([ID], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag]) VALUES (1041, CAST(N'2020-09-18T09:25:28.030' AS DateTime), NULL, 1, NULL, N'Sunnie', N'Nerren', N'sNerren', N'snerren@stockbridge.com', 0x2A933CADD72D5F9484A660FF11D84959EDD9E24F875856243C095BA95E3A630A9016BB0B72B36A121F4CE46E1D388AC02FB34199D52B9FC4521833F1BACAAB17, CAST(N'2016-07-22' AS Date), 2, CAST(120.00 AS Decimal(5, 2)), 12.6700, 2, 0)
SET IDENTITY_INSERT [Employee].[Employee] OFF
SET IDENTITY_INSERT [Employee].[Role] ON 

INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (1, N'Employee', N'Employee', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (2, N'Manager', N'Manager', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (3, N'Owner', N'Owner', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (4, N'Independent Contractor', N'IndependentContractor', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (5, N'Intern', N'Intern', 1, CAST(N'2020-09-16T16:27:25.043' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (1005, N'Delete Me', N'DeleteMe', 1, CAST(N'2020-09-17T10:16:20.983' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (1006, N'Delete Me 2', N'DeleteMe2', 1, CAST(N'2020-09-17T10:20:54.157' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (1007, N'Delet me 3', N'Deletme3', 1, CAST(N'2020-09-17T10:21:42.350' AS DateTime), NULL, 0, NULL)
SET IDENTITY_INSERT [Employee].[Role] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Employee]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND name = N'Unique_Employee')
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [Unique_Employee] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Name]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND name = N'Unique_Name')
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [Unique_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unqiue_SystemName]    Script Date: 9/18/2020 4:21:27 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND name = N'Unqiue_SystemName')
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [Unqiue_SystemName] UNIQUE NONCLUSTERED 
(
	[SystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Department_DeletedFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Department] ADD  CONSTRAINT [DF_Department_DeletedFlag]  DEFAULT ((0)) FOR [DeletedFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Department_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Department] ADD  CONSTRAINT [DF_Department_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Employee_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [DF_Employee_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Employee_StartDate]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [DF_Employee_StartDate]  DEFAULT (getdate()) FOR [StartDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Employee_TerminatedFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [DF_Employee_TerminatedFlag]  DEFAULT ((0)) FOR [TerminatedFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Role_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [DF_Role_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[DF_Role_DeletedFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [DF_Role_DeletedFlag]  DEFAULT ((0)) FOR [DeletedFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_DeleteFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_CasePack]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_CasePack]  DEFAULT ((1)) FOR [CasePack]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_Minimum]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_Minimum]  DEFAULT ((0)) FOR [Minimum]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_Maximum]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_Maximum]  DEFAULT ((0)) FOR [Maximum]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_Available]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_Available]  DEFAULT ((0)) FOR [ShelfCount]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_Pending]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_Pending]  DEFAULT ((0)) FOR [Pending]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[DF_Product_OnOrder]') AND type = 'D')
BEGIN
ALTER TABLE [Product].[Product] ADD  CONSTRAINT [DF_Product_OnOrder]  DEFAULT ((0)) FOR [OnOrder]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[DF_OrderingMethods_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Vendor].[OrderingMethod] ADD  CONSTRAINT [DF_OrderingMethods_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[DF_Vendor_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Vendor].[Vendor] ADD  CONSTRAINT [DF_Vendor_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[DF_Vendor_DeleteFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Vendor].[Vendor] ADD  CONSTRAINT [DF_Vendor_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[DF_Vendor_UseAutoOrdering]') AND type = 'D')
BEGIN
ALTER TABLE [Vendor].[Vendor] ADD  CONSTRAINT [DF_Vendor_UseAutoOrdering]  DEFAULT ((1)) FOR [UseAutoOrdering]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Warehouse].[DF_Location_DateCreated]') AND type = 'D')
BEGIN
ALTER TABLE [Warehouse].[Location] ADD  CONSTRAINT [DF_Location_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Warehouse].[DF_Location_DeleteFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Warehouse].[Location] ADD  CONSTRAINT [DF_Location_DeleteFlag]  DEFAULT ((0)) FOR [DeleteFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Department_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Department]'))
ALTER TABLE [Employee].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Department_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Department]'))
ALTER TABLE [Employee].[Department] CHECK CONSTRAINT [FK_Department_CreatedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Department_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Department]'))
ALTER TABLE [Employee].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Department_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Department]'))
ALTER TABLE [Employee].[Department] CHECK CONSTRAINT [FK_Department_ModifiedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_CreatedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_Department]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [Employee].[Department] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_Department]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_ModifiedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_Role]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Role] FOREIGN KEY([RoleID])
REFERENCES [Employee].[Role] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Employee_Role]') AND parent_object_id = OBJECT_ID(N'[Employee].[Employee]'))
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_Role]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Role_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Role]'))
ALTER TABLE [Employee].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Role_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Role]'))
ALTER TABLE [Employee].[Role] CHECK CONSTRAINT [FK_Role_CreatedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Role_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Role]'))
ALTER TABLE [Employee].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Employee].[FK_Role_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Employee].[Role]'))
ALTER TABLE [Employee].[Role] CHECK CONSTRAINT [FK_Role_ModifiedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product] CHECK CONSTRAINT [FK_Product_CreatedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_Location]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Location] FOREIGN KEY([LocationID])
REFERENCES [Warehouse].[Location] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_Location]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product] CHECK CONSTRAINT [FK_Product_Location]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product] CHECK CONSTRAINT [FK_Product_ModifiedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_PrimaryVendor]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_PrimaryVendor] FOREIGN KEY([PrimaryVendorID])
REFERENCES [Vendor].[Vendor] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_PrimaryVendor]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product] CHECK CONSTRAINT [FK_Product_PrimaryVendor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_SecondaryVendor]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_SecondaryVendor] FOREIGN KEY([SecondaryVendorID])
REFERENCES [Vendor].[Vendor] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Product].[FK_Product_SecondaryVendor]') AND parent_object_id = OBJECT_ID(N'[Product].[Product]'))
ALTER TABLE [Product].[Product] CHECK CONSTRAINT [FK_Product_SecondaryVendor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_OrderingMethods_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[OrderingMethod]'))
ALTER TABLE [Vendor].[OrderingMethod]  WITH CHECK ADD  CONSTRAINT [FK_OrderingMethods_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_OrderingMethods_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[OrderingMethod]'))
ALTER TABLE [Vendor].[OrderingMethod] CHECK CONSTRAINT [FK_OrderingMethods_CreatedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_OrderingMethods_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[OrderingMethod]'))
ALTER TABLE [Vendor].[OrderingMethod]  WITH CHECK ADD  CONSTRAINT [FK_OrderingMethods_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_OrderingMethods_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[OrderingMethod]'))
ALTER TABLE [Vendor].[OrderingMethod] CHECK CONSTRAINT [FK_OrderingMethods_ModifiedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_Vendor_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[Vendor]'))
ALTER TABLE [Vendor].[Vendor]  WITH CHECK ADD  CONSTRAINT [FK_Vendor_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_Vendor_CreatedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[Vendor]'))
ALTER TABLE [Vendor].[Vendor] CHECK CONSTRAINT [FK_Vendor_CreatedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_Vendor_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[Vendor]'))
ALTER TABLE [Vendor].[Vendor]  WITH CHECK ADD  CONSTRAINT [FK_Vendor_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_Vendor_ModifiedBy]') AND parent_object_id = OBJECT_ID(N'[Vendor].[Vendor]'))
ALTER TABLE [Vendor].[Vendor] CHECK CONSTRAINT [FK_Vendor_ModifiedBy]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_Vendor_OrderingMethod]') AND parent_object_id = OBJECT_ID(N'[Vendor].[Vendor]'))
ALTER TABLE [Vendor].[Vendor]  WITH CHECK ADD  CONSTRAINT [FK_Vendor_OrderingMethod] FOREIGN KEY([OrderingMethodID])
REFERENCES [Vendor].[OrderingMethod] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Vendor].[FK_Vendor_OrderingMethod]') AND parent_object_id = OBJECT_ID(N'[Vendor].[Vendor]'))
ALTER TABLE [Vendor].[Vendor] CHECK CONSTRAINT [FK_Vendor_OrderingMethod]
GO
/****** Object:  StoredProcedure [Employee].[GetEmployees]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[GetEmployees]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Employee].[GetEmployees] AS' 
END
GO
-- =============================================
-- Author:		James C
-- Create date: 9/9/2020
-- Description:	Get employees (by parameter)
-- =============================================
ALTER PROCEDURE [Employee].[GetEmployees]
    -- Add the parameters for the stored procedure here
    @Id INT = NULL,
    @Username NVARCHAR(50) = NULL,
	@LastTimeUpdated DATETIME = NULL -- If provided, it will only pull employees updated after this datetime
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
		   r.ID
         , r.Name
		 , r.SystemName
         , d.ID
         , d.Name
         , d.SystemName
		 , e.ID
         , e.FirstName
         , e.LastName
         , e.UserName
         , e.Email
         , e.Password
         , e.DateCreated
         , e.StartDate
         , e.RoleID
         , e.DateModified
         , e.AvailableVacationHours
         , e.BaseRate
         , e.DepartmentID
         , e.TerminatedFlag
		 , e.CreatedByEmployeeID
		 , e.ModifiedByEmployeeID
         
    FROM Employee.Employee e
	JOIN Employee.Role r ON r.ID = e.RoleID
	JOIN Employee.Department d ON d.ID = e.DepartmentID
    WHERE e.RoleID = r.ID
          AND e.TerminatedFlag = 0
		  AND (
		  (ISNULL(@Id,0) = 0 AND e.ID > 0)
		  OR
		  (ISNULL(@Id,0) <> 0 AND e.ID = @Id)
		  )
		  AND (
		  (ISNULL(@Username,'') = '')
		  OR
		  (ISNULL(@Username,'') <> '' AND e.UserName = @Username)
		  )
		  AND (
		  (ISNULL(@LastTimeUpdated,0) = 0)
		  OR
		  (ISNULL(@LastTimeUpdated,0) <> 0 AND COALESCE(e.DateModified,e.DateCreated) > @LastTimeUpdated)
		  )
END;
GO
/****** Object:  StoredProcedure [Employee].[UpsertDepartment]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[UpsertDepartment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Employee].[UpsertDepartment] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new Roles
-- =============================================
ALTER PROCEDURE [Employee].[UpsertDepartment]
    @ID INT = NULL
  , @DepartmentName NVARCHAR(50)
  , @ActiveEmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnID INT = @ID;

    UPDATE Employee.Department
    SET Name = @DepartmentName
      , SystemName = REPLACE(@DepartmentName, ' ', '')
	  , DateModified = GETDATE()
	  , ModifiedByEmployeeID = @ActiveEmployeeID
    WHERE ID = @ID;

    IF @@rowcount = 0
    BEGIN
        INSERT INTO Employee.Department
        (
            Name
          , SystemName
		  , DateCreated
		  , CreatedByEmployeeID
        )
        VALUES
        (@DepartmentName, REPLACE(@DepartmentName, ' ', '')
		, GETDATE(), @ActiveEmployeeID);

        SET @ReturnID = SCOPE_IDENTITY();
    END;

    SELECT @ReturnID;
END;
GO
/****** Object:  StoredProcedure [Employee].[UpsertEmployee]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[UpsertEmployee]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Employee].[UpsertEmployee] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new Employees
-- =============================================
ALTER PROCEDURE [Employee].[UpsertEmployee]
	-- Add the parameters for the stored procedure here
	@ID INT = NULL
	, @DepartmentName NVARCHAR(50)
	, @RoleName NVARCHAR(50)
	, @FirstName NVARCHAR(50)
	, @LastName NVARCHAR(50)
	, @UserName NVARCHAR(50)
	, @Email NVARCHAR(50)
	, @Password VARCHAR(50)
	, @StartDate DATE
	, @AvailableVacationHours decimal(5, 2)
	, @BaseRate money
	, @TerminatedFlag BIT
	, @ActiveEmployeeID INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ReturnID INT = @ID
	DECLARE @DepartmentID INT = (SELECT TOP(1) ID FROM Employee.Department WHERE [Name] = @DepartmentName)
	DECLARE @RoleID INT  = (SELECT TOP(1) ID FROM Employee.Role WHERE [Name] = @RoleName)
	
	UPDATE Employee.Employee SET
	DepartmentID = COALESCE(@DepartmentID,DepartmentID),
	RoleID = COALESCE(@RoleID,RoleID),
	FirstName = COALESCE(@FirstName,FirstName),
	LastName = COALESCE(@LastName,LastName),
	UserName = COALESCE(@UserName,UserName),
	Email =COALESCE( @Email,Email),
	[Password] = COALESCE(HASHBYTES('SHA2_512',@Password),[Password]),
	StartDate = COALESCE(@StartDate,StartDate),
	AvailableVacationHours = COALESCE(@AvailableVacationHours,AvailableVacationHours),
	BaseRate = COALESCE(@BaseRate,BaseRate),
	TerminatedFlag = COALESCE(@TerminatedFlag,TerminatedFlag),
	DateModified = GETDATE(),
	ModifiedByEmployeeID = @ActiveEmployeeID
	WHERE ID = @ID

	IF @@rowcount = 0
	BEGIN
		INSERT INTO Employee.Employee
		(
		    FirstName
		  , LastName
		  , UserName
		  , Email
		  , [Password]
		  , StartDate
		  , RoleID
		  , AvailableVacationHours
		  , BaseRate
		  , DepartmentID
		  , TerminatedFlag
		  , DateCreated
		  , CreatedByEmployeeID
		)
		VALUES
		(   @FirstName
		  , @LastName
		  , @UserName
		  , @Email
		  , HASHBYTES('SHA2_512',@Password)
		  , @StartDate
		  , @RoleID
		  , @AvailableVacationHours
		  , @BaseRate
		  , @DepartmentID
		  , @TerminatedFlag
		  , GETDATE()
		  , @ActiveEmployeeID
		    )
		SET @ReturnID = SCOPE_IDENTITY()
	END
	
	SELECT @ReturnID
END
GO
/****** Object:  StoredProcedure [Employee].[UpsertRole]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[UpsertRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Employee].[UpsertRole] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new Roles
-- =============================================
ALTER PROCEDURE [Employee].[UpsertRole]
    -- Add the parameters for the stored procedure here
    @ID INT = NULL
  , @RoleName NVARCHAR(50)
  , @ActiveEmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnID INT = @ID;

    UPDATE Employee.Role
    SET Name = @RoleName
      , SystemName = REPLACE(@RoleName, ' ', '')
	  , DateModified = GETDATE()
	  , ModifiedByEmployeeID = @ActiveEmployeeID
    WHERE ID = @ID;

    IF @@rowcount = 0
    BEGIN
        INSERT INTO Employee.Role
        (
            Name
          , SystemName
		  , DateCreated
		  , CreatedByEmployeeID
        )
        VALUES
        (@RoleName, REPLACE(@RoleName, ' ', ''), GETDATE(), @ActiveEmployeeID);

        SET @ReturnID = SCOPE_IDENTITY();
    END;

    SELECT @ReturnID;
END;
GO
/****** Object:  StoredProcedure [Product].[GetProducts]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[GetProducts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Product].[GetProducts] AS' 
END
GO
-- =============================================
-- Description:	Get Products
-- =============================================
ALTER PROCEDURE [Product].[GetProducts]
@ModifiedAfter DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
         l.ID
         , l.DateCreated
         , l.DateModified
         , l.CreatedByEmployeeID
         , l.ModifiedByEmployeeID
         , l.DeleteFlag
         , l.QuickPick
         , l.Aisle
         , l.Section
         , l.Shelf
         , l.Name
         , l.CustomName
         , p.ID
		 , p.PrimaryVendorID
		 , p.SecondaryVendorID
         , p.DateCreated
         , p.DateModified
         , p.CreatedByEmployeeID
         , p.ModifiedByEmployeeID
         , p.DeleteFlag
         , p.SKU
         , p.Description
         , p.PartNumber
         , p.OrderingPartNumber
         , p.LastUnitCost
         , p.CasePack
         , p.Length_IN
         , p.Width_IN
         , p.Height_IN
         , p.Weight_OZ
         , p.Minimum
         , p.Maximum
         , p.ShelfCount
         , p.Pending
         , p.OnOrder
         , p.Available
         , p.ToOrderQuantity
         , p.ToOrderAmount
    FROM Product.Product        p
        JOIN Warehouse.Location l
            ON l.ID = p.LocationID
	WHERE (
		  (ISNULL(@ModifiedAfter,0) = 0)
		  OR
		  (ISNULL(@ModifiedAfter,0) <> 0 AND COALESCE(p.DateModified,p.DateCreated) > @ModifiedAfter)
		  )
END;
GO
/****** Object:  StoredProcedure [Product].[UpsertProduct]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Product].[UpsertProduct]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Product].[UpsertProduct] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new Product
-- =============================================
ALTER PROCEDURE [Product].[UpsertProduct]
    @ID INT = NULL
  , @ActiveEmployeeID INT
  , @SKU NVARCHAR(15)
  , @Description NVARCHAR(100)
  , @PartNumber NVARCHAR(50)
  , @OrderingPartNumber NVARCHAR(50)
  , @PrimaryVendorCode NVARCHAR(5)
  , @SecondaryVendorCode NVARCHAR(5)
  , @LastUnitCost DECIMAL(7, 2)
  , @LocationID INT
  , @CasePack INT
  , @Length_IN DECIMAL(4, 2)
  , @Width_IN DECIMAL(4, 2)
  , @Height_IN DECIMAL(4, 2)
  , @Weight_OZ INT
  , @Minimum INT
  , @Maximum INT
  , @ShelfCount INT
  , @Pending INT
  , @OnOrder INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnID INT = @ID;

    DECLARE @PrimaryVendorID INT =
                (
                    SELECT TOP (1) ID FROM Vendor.Vendor WHERE Code = @PrimaryVendorCode
                );
    DECLARE @SecondaryVendorID INT =
                (
                    SELECT TOP (1) ID FROM Vendor.Vendor WHERE Code = @SecondaryVendorCode
                );

    UPDATE Product.Product
    SET DateModified = GETDATE()
      , ModifiedByEmployeeID = @ActiveEmployeeID
      , SKU = @SKU
      , Description = @Description
      , PartNumber = @PartNumber
      , OrderingPartNumber = @OrderingPartNumber
      , PrimaryVendorID = @PrimaryVendorID
      , SecondaryVendorID = @SecondaryVendorID
      , LastUnitCost = @LastUnitCost
      , LocationID = @LocationID
      , CasePack = @CasePack
      , Length_IN = @Length_IN
      , Width_IN = @Width_IN
      , Height_IN = @Height_IN
      , Weight_OZ = @Weight_OZ
      , Minimum = @Minimum
      , Maximum = @Maximum
      , ShelfCount = @ShelfCount
      , Pending = @Pending
      , OnOrder = @OnOrder
    WHERE ID = @ID;

    IF @@rowcount = 0
    BEGIN
        INSERT INTO Product.Product
        (
            CreatedByEmployeeID
          , SKU
          , Description
          , PartNumber
          , OrderingPartNumber
          , PrimaryVendorID
          , SecondaryVendorID
          , LastUnitCost
          , LocationID
          , CasePack
          , Length_IN
          , Width_IN
          , Height_IN
          , Weight_OZ
          , Minimum
          , Maximum
          , ShelfCount
          , Pending
          , OnOrder
        )
        VALUES
        (@ActiveEmployeeID, @SKU, @Description, @PartNumber, @OrderingPartNumber, @PrimaryVendorID, @SecondaryVendorID
       , @LastUnitCost, @LocationID, @CasePack, @Length_IN, @Width_IN, @Height_IN, @Weight_OZ, @Minimum, @Maximum
       , @ShelfCount, @Pending, @OnOrder);

        SET @ReturnID = SCOPE_IDENTITY();
    END;

    SELECT @ReturnID;
END;
GO
/****** Object:  StoredProcedure [Vendor].[GetVendors]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[GetVendors]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Vendor].[GetVendors] AS' 
END
GO
-- =============================================
-- Description:	Get Vendors
-- =============================================
ALTER PROCEDURE [Vendor].[GetVendors]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
	om.ID
         , om.DateCreated
         , om.DateModified
         , om.CreatedByEmployeeID
         , om.ModifiedByEmployeeID
         , om.MethodName
         , om.MethodSystemName
		, v.ID
         , v.DateCreated
         , v.DateModified
         , v.CreatedByEmployeeID
         , v.ModifiedByEmployeeID
         , v.DeleteFlag
         , v.Code
         , v.Name
         , v.OrderingMin
         , v.Email
         , v.AccountNumber
         , v.PhoneNumber
         , v.WillDropShipForUs
         , v.WillChargeFreightForDropShip
         , v.WillChargeFreightForOrders
         , v.LeadTimeBusinessDays
         , v.UseAutoOrdering
	FROM Vendor.Vendor v JOIN Vendor.OrderingMethod om 
	ON om.ID = v.OrderingMethodID
END;
GO
/****** Object:  StoredProcedure [Vendor].[UpsertOrderingMethod]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[UpsertOrderingMethod]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Vendor].[UpsertOrderingMethod] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new OrderingMethod
-- =============================================
ALTER PROCEDURE [Vendor].[UpsertOrderingMethod]
    @ID INT = NULL
  , @ActiveEmployeeID INT
  , @MethodName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnID INT = @ID;

    UPDATE [Vendor].OrderingMethod
    SET DateModified = GETDATE()
      , ModifiedByEmployeeID = @ActiveEmployeeID
      , MethodName = @MethodName
      , MethodSystemName = REPLACE(@MethodName, ' ', '')
    WHERE ID = @ID;

    IF @@rowcount = 0
    BEGIN
        INSERT INTO Vendor.OrderingMethod
        (
            CreatedByEmployeeID
          , MethodName
          , MethodSystemName
        )
        VALUES
        (@ActiveEmployeeID, @MethodName, REPLACE(@MethodName, ' ', ''));

        SET @ReturnID = SCOPE_IDENTITY();
    END;

    SELECT @ReturnID;
END;
GO
/****** Object:  StoredProcedure [Vendor].[UpsertVendor]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Vendor].[UpsertVendor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Vendor].[UpsertVendor] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new Vendor
-- =============================================
ALTER PROCEDURE [Vendor].[UpsertVendor]
    @ID INT = NULL
  , @ActiveEmployeeID INT
  ,	@Code nvarchar(5)
	,	@Name nvarchar(50)
	,	@OrderingMin decimal(4, 2)
	,	@OrderingMethodName NVARCHAR(50)
	,	@Email nvarchar(50)
	,	@AccountNumber nvarchar(50)
	,	@PhoneNumber nvarchar(20)
	,	@WillDropShipForUs bit
	,	@WillChargeFreightForDropShip bit
	,	@WillChargeFreightForOrders bit
	,	@LeadTimeBusinessDays int
	,	@UseAutoOrdering bit
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnID INT = @ID;

	DECLARE @OrderingMethodID int = (SELECT TOP(1) ID FROM Vendor.OrderingMethod WHERE MethodName = @OrderingMethodName)

	UPDATE Vendor.Vendor
	SET DateModified = GETDATE()
	, ModifiedByEmployeeID = @ActiveEmployeeID
	, Code = @Code
	, Name = @Name
    , OrderingMin = @OrderingMin
    , OrderingMethodID = @OrderingMethodID
    , Email = @Email
    , AccountNumber = @AccountNumber
    , PhoneNumber = @PhoneNumber
    , WillDropShipForUs = @WillDropShipForUs
    , WillChargeFreightForDropShip = @WillChargeFreightForDropShip
    , WillChargeFreightForOrders = @WillChargeFreightForOrders
    , LeadTimeBusinessDays = @LeadTimeBusinessDays
    , UseAutoOrdering = @UseAutoOrdering
	WHERE ID = @ID
   
    IF @@rowcount = 0
    BEGIN
        INSERT INTO	 Vendor.Vendor
        (
          CreatedByEmployeeID
          , Code
          , Name
          , OrderingMin
          , OrderingMethodID
          , Email
          , AccountNumber
          , PhoneNumber
          , WillDropShipForUs
          , WillChargeFreightForDropShip
          , WillChargeFreightForOrders
          , LeadTimeBusinessDays
          , UseAutoOrdering
        )
        VALUES
        (   @ActiveEmployeeID
		,	@Code
		,	@Name
		,	@OrderingMin
		,	@OrderingMethodID
		,	@Email
		,	@AccountNumber
		,	@PhoneNumber
		,	@WillDropShipForUs
		,	@WillChargeFreightForDropShip
		,	@WillChargeFreightForOrders
		,	@LeadTimeBusinessDays
		,	@UseAutoOrdering
            )

        SET @ReturnID = SCOPE_IDENTITY();
    END;

    SELECT @ReturnID;
END;
GO
/****** Object:  StoredProcedure [Warehouse].[UpsertLocation]    Script Date: 9/18/2020 4:21:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Warehouse].[UpsertLocation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [Warehouse].[UpsertLocation] AS' 
END
GO
-- =============================================
-- Description:	Update or insert new Warehouse Location
-- =============================================
ALTER PROCEDURE [Warehouse].[UpsertLocation]
    @ID INT = NULL
  , @ActiveEmployeeID INT
  , @QuickPick INT
  , @Aisle INT
  , @Section CHAR(2)
  , @Shelf INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnID INT = @ID;

    UPDATE Warehouse.Location
    SET DateModified = GETDATE()
      , ModifiedByEmployeeID = @ActiveEmployeeID
      , QuickPick = @QuickPick
      , Aisle = @Aisle
      , Section = @Section
      , Shelf = @Shelf
    WHERE ID = @ID;

    IF @@rowcount = 0
    BEGIN
        INSERT INTO Warehouse.[Location]
        (
            CreatedByEmployeeID
          , QuickPick
          , Aisle
          , Section
          , Shelf
        )
        VALUES
        (   @ActiveEmployeeID -- CreatedByEmployeeID - int
          , @QuickPick        -- QuickPick - int
          , @Aisle            -- Aisle - int
          , @Section          -- Section - char(2)
          , @Shelf            -- Shelf - int
            );
        SET @ReturnID = SCOPE_IDENTITY();
    END;

    SELECT @ReturnID;
END;
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'Product', N'TABLE',N'Product', N'COLUMN',N'ToOrderQuantity'))
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Max - (Available + OnOrder)' , @level0type=N'SCHEMA',@level0name=N'Product', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ToOrderQuantity'
GO
USE [master]
GO
ALTER DATABASE [StockBridge] SET  READ_WRITE 
GO
