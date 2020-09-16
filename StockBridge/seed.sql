USE [StockBridge]
GO
/****** Object:  StoredProcedure [Employee].[UpsertRole]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP PROCEDURE IF EXISTS [Employee].[UpsertRole]
GO
/****** Object:  StoredProcedure [Employee].[UpsertEmployee]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP PROCEDURE IF EXISTS [Employee].[UpsertEmployee]
GO
/****** Object:  StoredProcedure [Employee].[UpsertDepartment]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP PROCEDURE IF EXISTS [Employee].[UpsertDepartment]
GO
/****** Object:  StoredProcedure [Employee].[GetEmployees]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP PROCEDURE IF EXISTS [Employee].[GetEmployees]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
ALTER TABLE [Employee].[Role] DROP CONSTRAINT IF EXISTS [FK_Role_ModifiedBy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
ALTER TABLE [Employee].[Role] DROP CONSTRAINT IF EXISTS [FK_Role_CreatedBy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_Role]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_ModifiedBy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_Department]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_CreatedBy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Department]') AND type in (N'U'))
ALTER TABLE [Employee].[Department] DROP CONSTRAINT IF EXISTS [FK_Department_ModifiedBy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Department]') AND type in (N'U'))
ALTER TABLE [Employee].[Department] DROP CONSTRAINT IF EXISTS [FK_Department_CreatedBy]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
ALTER TABLE [Employee].[Role] DROP CONSTRAINT IF EXISTS [DF_Role_DeletedFlag]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
ALTER TABLE [Employee].[Role] DROP CONSTRAINT IF EXISTS [DF_Role_DateCreated]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [DF_Employee_DateCreated]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [DF_Employee_TerminatedFlag]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [DF_Employee_StartDate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Department]') AND type in (N'U'))
ALTER TABLE [Employee].[Department] DROP CONSTRAINT IF EXISTS [DF_Department_DateCreated]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Department]') AND type in (N'U'))
ALTER TABLE [Employee].[Department] DROP CONSTRAINT IF EXISTS [DF_Department_DeletedFlag]
GO
/****** Object:  Index [Unqiue_SystemName]    Script Date: 9/16/2020 4:50:53 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
ALTER TABLE [Employee].[Role] DROP CONSTRAINT IF EXISTS [Unqiue_SystemName]
GO
/****** Object:  Index [Unique_Name]    Script Date: 9/16/2020 4:50:53 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Role]') AND type in (N'U'))
ALTER TABLE [Employee].[Role] DROP CONSTRAINT IF EXISTS [Unique_Name]
GO
/****** Object:  Index [Unique_Employee]    Script Date: 9/16/2020 4:50:53 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Employee].[Employee]') AND type in (N'U'))
ALTER TABLE [Employee].[Employee] DROP CONSTRAINT IF EXISTS [Unique_Employee]
GO
/****** Object:  Table [Employee].[Role]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP TABLE IF EXISTS [Employee].[Role]
GO
/****** Object:  Table [Employee].[Employee]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP TABLE IF EXISTS [Employee].[Employee]
GO
/****** Object:  Table [Employee].[Department]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP TABLE IF EXISTS [Employee].[Department]
GO
/****** Object:  Schema [Employee]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP SCHEMA IF EXISTS [Employee]
GO
USE [master]
GO
/****** Object:  Database [StockBridge]    Script Date: 9/16/2020 4:50:53 PM ******/
DROP DATABASE IF EXISTS [StockBridge]
GO
/****** Object:  Database [StockBridge]    Script Date: 9/16/2020 4:50:53 PM ******/
CREATE DATABASE [StockBridge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StockBridge', FILENAME = N'C:\StockBridge.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StockBridge_log', FILENAME = N'C:\StockBridge_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Schema [Employee]    Script Date: 9/16/2020 4:50:53 PM ******/
CREATE SCHEMA [Employee]
GO
/****** Object:  Table [Employee].[Department]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [Employee].[Employee]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Employee].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
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
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NULL,
	[CreatedByEmployeeID] [int] NOT NULL,
	[ModifiedByEmployeeID] [int] NULL,
 CONSTRAINT [PK_Employee.Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Employee].[Role]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (1, N'Admin', N'User', N'admin', N'admin@stockbridge.com', 0xC7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC, CAST(N'2020-01-01' AS Date), 1, CAST(0.00 AS Decimal(5, 2)), 0.0000, 6, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (32, N'Douglas', N'Adams', N'dAdams', N'dAdams@stockbridge.com', 0x1CACF396B051E9F452A8CF4F5C3EACC950C3B8E737B95C6822502CB5AF1AEB39B538905A9F8B7D7DA56333CF8603049AD08A9D4A843E48C80926DFC05291CEF3, CAST(N'2020-09-14' AS Date), 1, CAST(42.00 AS Decimal(5, 2)), 42.0000, 5, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (33, N'Sou', N'Granholm', N'sGranholm', N'sgranholm@stockbridge.com', 0xAD99698A6C99A274E73010B99269407B8018856F80651CF0419CBED6AD8F2D0F53275BC57DCB6BCEC5C689A540371E3BA8907DCE33584BEB2F48987DE093EEE0, CAST(N'2018-04-18' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 17.6600, 5, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (34, N'Sunnie', N'Meyette', N'sMeyette', N'smeyette@stockbridge.com', 0x77D642069DBFE8C2B7627E8D8F1B24C5139BC5722E801960C2E0238F465CF67A6CFE2CDBE0C132DB1D46EEB185FC953B3A6E55E1547DA2305F7CC88C9C668B01, CAST(N'2014-11-04' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 31.7800, 5, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (35, N'Shunteria', N'Ritchhart', N'sRitchhart', N'sritchhart@stockbridge.com', 0xFFB21B26DE67FBA3FAC5F42445B3C3DAEE44B93D174966A5AC89645E9145998FFF63E649868EEED9E8643F5985D1D14524650AF02A0448E97E058E57A602C029, CAST(N'2016-10-21' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 14.8000, 5, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (36, N'Ashleigh', N'Neddo', N'aNeddo', N'aneddo@stockbridge.com', 0xE77DF7233F66A9B8285FA6EC7570893594BD6267379A31266907D5A41FA8349C55642D691A547653B2875FAA35328F574E77D62E943B614E1BE46BB77BF3167D, CAST(N'2019-11-19' AS Date), 2, CAST(120.00 AS Decimal(5, 2)), 32.2800, 2, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (37, N'Malary', N'Crease', N'mCrease', N'mcrease@stockbridge.com', 0x2FFCDF77DAA599F23C958EB0ADA57A02938D8F4B5DDE813740F6B6276D5D71F757BC099FDD590466E174ABE4B377D680BFFBAF0ED4036B326BCB5F61C964D41C, CAST(N'2017-01-30' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 9.3000, 2, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (38, N'Ernestina', N'Angland', N'eAngland', N'eangland@stockbridge.com', 0xFDAC710A33A1AC40E7020C616E571C68F90CD236E9FA6480C878BA02A768FCC2ABB1A75EEB4A430C2C55049CC35F89D72C1AE7A8A8EB76F219EB35E9EF911393, CAST(N'2015-08-23' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 12.0800, 2, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (39, N'Travaris', N'Brahney', N'tBrahney', N'tbrahney@stockbridge.com', 0xD4C6EE8E12D20C165EE437B941221F404D90A958CDEDB3DD50A142B13F1098E1708783727B105EC11397510C89D25E216A29A0F5B6BA2065C1C7C29C96772DE9, CAST(N'2018-09-22' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 17.7500, 2, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (40, N'Rahmell', N'Aranas', N'rAranas', N'raranas@stockbridge.com', 0xEF71388E3D2879011864834F8C7B539875884EB80FA9F190EA5F53B390E582B97FFA38B8944F67C480A61963ADE00486469B8DA3FA310499BAFB094898A5642B, CAST(N'2014-01-04' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 7.5100, 2, 0, CAST(N'2020-09-16T11:35:37.163' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (41, N'Micaela', N'Moron', N'mMoron', N'mmoron@stockbridge.com', 0xAF612D0874B38479203C9C9029203B9B93AAF8C93990AC437CDBFE8555DCA58FE2157407DFB60F83FE49F9D34B524A853D7DFF472683E224429083127F0CC50E, CAST(N'2019-04-10' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 21.2200, 1, 0, CAST(N'2020-09-16T13:34:51.783' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (42, N'Latika', N'Sandefer', N'lSandefer', N'lsandefer@stockbridge.com', 0x0F753C284A5E64ABA3101B30F66ED97D7B96B9884FFCFFCAC2DB70D1D1B2A0A887BFF6341C8D0712A77732BDED68CB01BC592E7E80DF0969FEC4382B84C70519, CAST(N'2014-03-13' AS Date), 2, CAST(120.00 AS Decimal(5, 2)), 31.6600, 2, 0, CAST(N'2020-09-16T16:14:30.453' AS DateTime), NULL, 1, NULL)
INSERT [Employee].[Employee] ([ID], [FirstName], [LastName], [UserName], [Email], [Password], [StartDate], [RoleID], [AvailableVacationHours], [BaseRate], [DepartmentID], [TerminatedFlag], [DateCreated], [DateModified], [CreatedByEmployeeID], [ModifiedByEmployeeID]) VALUES (43, N'Nicholis', N'Barze', N'nBarze', N'nbarze@stockbridge.com', 0x8C9388AC70F15CC60E7297AFA2BD08E64CD974ED264B2B27EB41FE3F92D5B1012169C9481B1F64507328A789702C15A6A96E67439C00AA09152AF2E435626175, CAST(N'2015-04-22' AS Date), 1, CAST(120.00 AS Decimal(5, 2)), 34.7300, 2, 0, CAST(N'2020-09-16T16:43:14.790' AS DateTime), NULL, 1, NULL)
SET IDENTITY_INSERT [Employee].[Employee] OFF
SET IDENTITY_INSERT [Employee].[Role] ON 

INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (1, N'Employee', N'Employee', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (2, N'Manager', N'Manager', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (3, N'Owner', N'Owner', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (4, N'Independent Contractor', N'IndependentContractor', 1, CAST(N'2020-09-16T11:29:45.100' AS DateTime), NULL, 0, NULL)
INSERT [Employee].[Role] ([ID], [Name], [SystemName], [CreatedByEmployeeID], [DateCreated], [DateModified], [DeletedFlag], [ModifiedByEmployeeID]) VALUES (5, N'Intern', N'Intern', 1, CAST(N'2020-09-16T16:27:25.043' AS DateTime), NULL, 0, NULL)
SET IDENTITY_INSERT [Employee].[Role] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Employee]    Script Date: 9/16/2020 4:50:53 PM ******/
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [Unique_Employee] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Name]    Script Date: 9/16/2020 4:50:53 PM ******/
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [Unique_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unqiue_SystemName]    Script Date: 9/16/2020 4:50:53 PM ******/
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [Unqiue_SystemName] UNIQUE NONCLUSTERED 
(
	[SystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Employee].[Department] ADD  CONSTRAINT [DF_Department_DeletedFlag]  DEFAULT ((0)) FOR [DeletedFlag]
GO
ALTER TABLE [Employee].[Department] ADD  CONSTRAINT [DF_Department_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [DF_Employee_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [DF_Employee_TerminatedFlag]  DEFAULT ((0)) FOR [TerminatedFlag]
GO
ALTER TABLE [Employee].[Employee] ADD  CONSTRAINT [DF_Employee_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [DF_Role_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [Employee].[Role] ADD  CONSTRAINT [DF_Role_DeletedFlag]  DEFAULT ((0)) FOR [DeletedFlag]
GO
ALTER TABLE [Employee].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
ALTER TABLE [Employee].[Department] CHECK CONSTRAINT [FK_Department_CreatedBy]
GO
ALTER TABLE [Employee].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
ALTER TABLE [Employee].[Department] CHECK CONSTRAINT [FK_Department_ModifiedBy]
GO
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_CreatedBy]
GO
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [Employee].[Department] ([ID])
GO
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_ModifiedBy]
GO
ALTER TABLE [Employee].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Role] FOREIGN KEY([RoleID])
REFERENCES [Employee].[Role] ([ID])
GO
ALTER TABLE [Employee].[Employee] CHECK CONSTRAINT [FK_Employee_Role]
GO
ALTER TABLE [Employee].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_CreatedBy] FOREIGN KEY([CreatedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
ALTER TABLE [Employee].[Role] CHECK CONSTRAINT [FK_Role_CreatedBy]
GO
ALTER TABLE [Employee].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_ModifiedBy] FOREIGN KEY([ModifiedByEmployeeID])
REFERENCES [Employee].[Employee] ([ID])
GO
ALTER TABLE [Employee].[Role] CHECK CONSTRAINT [FK_Role_ModifiedBy]
GO
/****** Object:  StoredProcedure [Employee].[GetEmployees]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		James C
-- Create date: 9/9/2020
-- Description:	Get employees (by parameter)
-- =============================================
CREATE PROCEDURE [Employee].[GetEmployees]
    -- Add the parameters for the stored procedure here
    @Id INT = NULL,
    @Username NVARCHAR(50) = NULL
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
END;
GO
/****** Object:  StoredProcedure [Employee].[UpsertDepartment]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Update or insert new Roles
-- =============================================
CREATE PROCEDURE [Employee].[UpsertDepartment]
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
/****** Object:  StoredProcedure [Employee].[UpsertEmployee]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Update or insert new Employees
-- =============================================
CREATE PROCEDURE [Employee].[UpsertEmployee]
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
/****** Object:  StoredProcedure [Employee].[UpsertRole]    Script Date: 9/16/2020 4:50:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Update or insert new Roles
-- =============================================
CREATE PROCEDURE [Employee].[UpsertRole]
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
USE [master]
GO
ALTER DATABASE [StockBridge] SET  READ_WRITE 
GO
