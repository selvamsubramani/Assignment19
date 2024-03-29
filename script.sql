USE [master]
GO
/****** Object:  Database [Assignment19]    Script Date: 17-06-2019 00:18:28 ******/
CREATE DATABASE [Assignment19]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Assignment19', FILENAME = N'G:\DataFiles\Assignment19.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Assignment19_log', FILENAME = N'G:\DataFiles\Assignment19_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment19].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment19] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment19] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment19] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment19] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment19] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment19] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Assignment19] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment19] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment19] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment19] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment19] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment19] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment19] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment19] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment19] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment19] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Assignment19] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment19] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment19] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment19] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment19] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment19] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment19] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment19] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Assignment19] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment19] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment19] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment19] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment19] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [Assignment19]
GO
/****** Object:  StoredProcedure [dbo].[AddCustomer]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddCustomer]
(
	@Name		NVARCHAR(100),
	@Address	NVARCHAR(200),
	@DOB		DATETIME,
	@Salary		INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO Customers
		SELECT @Name [Name], @Address [Address], @DOB [DOB], @Salary [Salary]
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteCustomer]
(
	@Id	INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM Customers WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomerBornAfterDate]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomerBornAfterDate]
(
	@date	DATETIME
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [Id], [Name], [Address], [DOB], [Salary] 
		FROM Customers
		WHERE DOB > @date
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomerById]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomerById]
(
	@Id	INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [Id], [Name], [Address], [DOB], [Salary] 
		FROM Customers
		WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCustomers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [Id], [Name], [Address], [DOB], [Salary] FROM Customers
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCustomer]
(
	@Id	INT,
	@Name		NVARCHAR(100),
	@Address	NVARCHAR(200),
	@DOB		DATETIME,
	@Salary		INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	@Name = ISNULL(@Name, [Name]), 
			@Address = ISNULL(@Address, [Address]),
			@DOB = ISNULL(@DOB, [DOB]), 
			@Salary = ISNULL(@Salary, [Salary]) 
		FROM Customers
		WHERE Id =@Id

	UPDATE Customers SET
		[Name] = @Name,
		[Address] = @Address,
		[DOB] = @DOB,
		[Salary] = @Salary
		WHERE Id = @Id
END

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 17-06-2019 00:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[DOB] [datetime] NULL,
	[Salary] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [Assignment19] SET  READ_WRITE 
GO
