USE [master]
GO
/****** Object:  Database [CVManagerSystemDB]    Script Date: 11/13/2022 5:04:48 PM ******/
CREATE DATABASE [CVManagerSystemDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CVManagerSystemDB', FILENAME = N'D:\Ahmed\Angular\CV_Manager_System\DB\CVManagerSystemDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CVManagerSystemDB_log', FILENAME = N'D:\Ahmed\Angular\CV_Manager_System\DB\CVManagerSystemDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CVManagerSystemDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CVManagerSystemDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CVManagerSystemDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CVManagerSystemDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CVManagerSystemDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CVManagerSystemDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CVManagerSystemDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CVManagerSystemDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CVManagerSystemDB] SET  MULTI_USER 
GO
ALTER DATABASE [CVManagerSystemDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CVManagerSystemDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CVManagerSystemDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CVManagerSystemDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CVManagerSystemDB]
GO
/****** Object:  User [ATHEEB\afarag]    Script Date: 11/13/2022 5:04:48 PM ******/
CREATE USER [ATHEEB\afarag] FOR LOGIN [ATHEEB\afarag] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddCv]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddCv]

@Name nvarchar(500),
@Personal_Information_Id nvarchar(50),
@Experience_Information_Id nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[CV]
           ([Name],Personal_Information_Id,Experience_Information_Id)
     VALUES
           (@Name
		   ,@Personal_Information_Id
		   ,@Experience_Information_Id)

END

GO
/****** Object:  StoredProcedure [dbo].[SP_AddExperienceInfo]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddExperienceInfo]

@CompanyName nvarchar(150),
@City nvarchar(150),
@CompanyField  nvarchar(150)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [dbo].ExperienceInformation
           ([CompanyName]
           ,[City]
           ,[CompanyField])
     VALUES
           (@CompanyName
           ,@City
           ,@CompanyField)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_AddPersonalInfo]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddPersonalInfo]

@FullName nvarchar(150),
@CityName nvarchar(150),
@Email  nvarchar(150),
@MobileNumber varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [dbo].[PersonalInformation]
           ([FullName]
           ,[CityName]
           ,[Email]
           ,[MobileNumber])
     VALUES
           (@FullName
           ,@CityName
           ,@Email
           ,@MobileNumber)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ListAllCVs]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ListAllCVs]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID]
      ,[Name]
	  ,(select [FullName] from [dbo].[PersonalInformation] where Personal_Information_Id = [PersonalInformation].[ID]) as PerInfo
	  ,(select [CompanyName] from [dbo].[ExperienceInformation] where [Experience_Information_Id] = [ExperienceInformation].[Id] ) as ExpInfo
  FROM [dbo].[CV]

END

GO
/****** Object:  StoredProcedure [dbo].[SP_ListAllExperienceInfo]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[SP_ListAllExperienceInfo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID]
      ,[CompanyName]
      ,[City]
      ,[CompanyField]
  FROM [dbo].[ExperienceInformation]

END

GO
/****** Object:  StoredProcedure [dbo].[SP_ListAllPersonalInfo]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ListAllPersonalInfo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID]
      ,[FullName]
      ,[CityName]
      ,[Email]
      ,[MobileNumber]
  FROM [dbo].[PersonalInformation]

END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateExperienceInfo]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[SP_UpdateExperienceInfo]

@CompanyName nvarchar(150),
@City nvarchar(150),
@CompanyField  nvarchar(150),
@ID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[ExperienceInformation]
   SET [CompanyName] = @CompanyName
			,City = @City
           ,CompanyField = @CompanyField
		   where ID = @ID
END

GO
/****** Object:  Table [dbo].[CV]    Script Date: 11/13/2022 5:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CV](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Personal_Information_Id] [nvarchar](100) NULL,
	[Experience_Information_Id] [nvarchar](100) NULL,
 CONSTRAINT [PK_CV] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExperienceInformation]    Script Date: 11/13/2022 5:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExperienceInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](20) NULL,
	[City] [nvarchar](150) NULL,
	[CompanyField] [nvarchar](150) NULL,
 CONSTRAINT [PK_ExperienceInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonalInformation]    Script Date: 11/13/2022 5:04:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PersonalInformation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NULL,
	[CityName] [nvarchar](150) NULL,
	[Email] [varchar](150) NULL,
	[MobileNumber] [varchar](50) NULL,
 CONSTRAINT [PK_PersonalInformation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [CVManagerSystemDB] SET  READ_WRITE 
GO
