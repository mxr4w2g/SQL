USE [QueensClassSchedule]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mudabir Rizvi
-- Create date: 12/05/2023
-- Description:	Loads Data into Location.RoomLocation
-- =============================================
CREATE PROCEDURE [Project3].[Load_RoomLocation]
@GroupMemberUserAuthorizationKey [Udt].[SurrogateKeyInt]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();
	DECLARE @startT DATETIME2;
    set @startT = SYSDATETIME();
	
    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

    INSERT INTO Location.RoomLocation(RoomBuilding,RoomNumber)
    SELECT DISTINCT 
        SUBSTRING(Location, 1, CHARINDEX(',', Location) - 1),
        SUBSTRING(Location, CHARINDEX(',', Location) + 2, LEN(Location)) 
    FROM Uploadfile.CurrentSemesterCourseOfferings;
	

	
	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM Location.RoomLocation);
	
	DECLARE @endT DATETIME2;
    set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Room Locations.',
		@startT,
		 @endT,
		@rowCount
	)


END