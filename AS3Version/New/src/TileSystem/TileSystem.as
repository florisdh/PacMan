package TileSystem 
{
	/**
	 * ...
	 * @author FDH
	 */
	public class TileSystem 
	{
		// -- Properties -- //
		
		public var Map:Vector.<int>;
		public var MapWidth:int;
		public var MapHeight:int;
		
		// Only to make life easyer
		public var TileWidth:int;
		public var TileHeigth:int;
		
		// -- Vars -- //
		
		// -- Construct -- //
		
		public function TileSystem() 
		{
		}
		
		// -- Methods -- //
		
		public function LoadMap(map:Vector.<int>, mapWidth:int, mapHeigth:int):void 
		{
			Map = new Vector.<int>();
			for each (var c:int in map)
			{
				Map.push(c);
			}
			
			MapWidth = mapWidth;
			MapHeight = mapHeigth;
		}
		
		public function GetTile(mapX:int, mapY:int):int
		{
			// Validate
			if (mapX < 0 || mapX >= MapWidth || mapY < 0 || mapY >= MapHeight) return -1;
			
			// Get array index
			var arrInd:int = mapX + mapY * MapWidth;
			
			// Return tile
			return Map[arrInd];
		}
		
		public function SetTile(mapX:int, mapY:int, tile:int):void 
		{
			// Validate
			if (mapX < 0 || mapX >= MapWidth || mapY < 0 || mapY >= MapHeight) return;
			
			// Get array index
			var arrInd:int = mapX + mapY * MapWidth;
			
			// Set tile
			Map[arrInd] = tile;
		}
		
	}

}