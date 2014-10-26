package TileSystem
{
	import Display.SpriteSheet;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class TileSystem extends Sprite
	{
		// -- Properties -- //
		
		// Tile Sheet Image
		public var TileSheet:SpriteSheet;
		
		// Map Content
		public var Map:Vector.<int>;
		public var MapWidth:int;
		public var MapHeight:int;
		
		// -- Vars -- //
		
		private var _scale:Number = 1;
		
		// -- Construct -- //
		
		public function TileSystem(sheet:SpriteSheet, map:Vector.<int>, mapWidth:int, mapHeight:int) 
		{
			TileSheet = sheet;
			Map = map;
			MapWidth = mapWidth;
			MapHeight = mapHeight;
		}
		
		// -- PublicMethods -- //
		
		public function DrawMap():void 
		{
			// Reserver vars for performance
			var finalFrame:Bitmap, finalFrameData:BitmapData,
				tileInd:int, tile:Bitmap,
				sourceRect:Rectangle, targetPoint:Point;
			
			sourceRect = new Rectangle(0, 0, TileSheet.FrameWidth, TileSheet.FrameHeight);
			
			// Create back buffer to draw on
			finalFrameData = new BitmapData(MapWidth * TileSheet.FrameWidth, MapHeight * TileSheet.FrameHeight, true, 0x000000);
			finalFrame = new Bitmap(finalFrameData);
			
			// Draw full map
			for (var mapY:int = 0; mapY < MapHeight; mapY++ )
			for (var mapX:int = 0; mapX < MapWidth; mapX++ )
			{
				// Get tile
				tileInd = Map[mapX + mapY * MapWidth];
				tile = TileSheet.GetFrame(tileInd);
				if (tileInd < 0 || !tile) continue;
				
				// Calc draw point
				targetPoint = new Point
				(
					mapX * TileSheet.FrameWidth,
					mapY * TileSheet.FrameHeight
				);
				
				// Draw on frame
				finalFrameData.copyPixels(tile.bitmapData, sourceRect, targetPoint);
			}
			
			addChild(finalFrame);
		}
		
		/**
		 * Get a tile from map coordinates.
		 * @param	x	Map x position.
		 * @param	y	Map y position.
		 * @return	
		 */
		public function GetTile(mapX:int, mapY:int):int
		{
			// Validate
			var ind:int = _getMapIndex(mapX, mapY);
			if (ind < 0 || ind > Map.length) return -1;
			
			return Map[ind];
		}
		
		public function SetTile():void 
		{
			
		}
		
		public function Scale(scalar:Number):void 
		{
			_scale = scalar;
			scaleX = scalar;
			scaleY = scalar;
		}
		
		public function WorldToMapPos(worldPos:Vector3D):void 
		{
			
		}
		
		public function GetTileFromPosition(worldPos:Vector3D):int 
		{
			//var ind:int = 
			
			
			return -1;
		}
		
		// -- PrivateMethods -- //
		
		private function _getMapIndex(x:int, y:int):int
		{
			return x + y * MapWidth;
		}
		
		// -- GetSet -- //
		
		public function get TileWidth():int
		{
			return TileSheet.FrameWidth * _scale;
		}
		public function get TileHeight():int
		{
			return TileSheet.FrameHeight * _scale;
		}
		
	}

}