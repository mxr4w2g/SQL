USE PrestigeCars

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Cars Table
CREATE TABLE [Data].[Cars](
	[CarsId] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[Color] [Udt].[Color] NOT NULL,
	[RepairsCost] [Udt].[RepairsCost] NOT NULL,
	[PartsCost] [Udt].[PartsCost] NOT NULL,
	[ModelId] [Udt].[ModelId] NOT NULL,
	[TransportInCost] [Udt].[TransportInCost] NOT NULL,

 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[CarsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stock Table
Create TABLE [Data].[Stock](
	[StockId] [Udt].[SurrogateKeyInt] IDENTITY(1,1) NOT NULL,
	[StockCode] [Udt].[StockCode] NOT NULL,
	[BuyerComments] [Udt].[BuyerComments] NOT NULL,
	[DateBought] [Udt].[DateBought] NOT NULL,
	[TimeBought] [Udt].[TimeBought] NOT NULL,
	[Cost] [Udt].[Cost] NOT NULL,
	[IsRHD] [Udt].[isRHD] NOT NULL,
	[CarsId] [Udt].[SurrogateKeyInt] NOT NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[StockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [Data].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock_Cars] FOREIGN KEY([CarsId])
REFERENCES [Data].[Cars] ([CarsId])
GO

ALTER TABLE [Data].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock] FOREIGN KEY([StockId])
REFERENCES [Data].[Stock] ([StockId])

