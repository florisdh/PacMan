function TileSystem(sheet)
{
	// Tiles
	var Tiles =
	[
		0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	2,
		8,	12,	12,	12,	12,	12,	12,	12,	12,	12,	12,	12,	12,	10,
		8,	12,	3,	4,	4,	5,	12,	3,	4,	4,	4,	5,	12,	10,
		8,	9,	11,	-1,	-1,	13,	12,	11,	-1,	-1,	-1,	13,	12,	10,
		8,	12,	19,	20,	20,	21,	12,	19,	20,	20,	20,	21,	12,	10,
		
		/* 0,	1,	1,	1,	1,	1,	1,	2,
		8,	-1,	-1,	-1, -1, -1, -1, 10,
		8,	-1,	-1,	-1, -1, -1, -1, 10,
		8,	-1,	-1,	-1, -1, -1, -1, 10,
		8,	-1,	-1,	-1, -1, -1, -1, 10,
		8,	-1,	-1,	-1, -1, -1, -1, 10,
		8,	-1,	-1,	-1, -1, -1, -1, 10,
		16, 17,	17,	17, 17, 17, 17, 18 */
	];
	
	// Art
	var TileSheet = sheet;
	var SourceTileWidth = 8;
	var SourceTileHeight = 8;
	var SourceTileAmountX = 8;
	var SourceTileAmountY = 8;
	
	// TileSize
	var TileWidth = 24;
	var TileHeight = 24;
	var TileAmountX = 14;
	var TileAmountY = 5;
	
	// 
	this.draw = function(g)
	{
		for (var y = 0; y < TileAmountY; y++)
		for (var x = 0; x < TileAmountX; x++)
		{
			var tile = Tiles[x + y * TileAmountX];
			
			if (tile == -1) continue;
			
			var source = new Vector2
			(
				SourceTileWidth * (tile % SourceTileWidth),
				SourceTileHeight * Math.floor(tile / SourceTileWidth)
			);
			
			var target = new Vector2
			(
				x * TileWidth,
				y * TileHeight
			);
			
			// Draw on g
			g.drawImage
			(
				TileSheet,
				source.x, source.y, SourceTileWidth, SourceTileHeight,
				target.x, target.y, TileWidth, TileHeight
			);
		}
	}
}