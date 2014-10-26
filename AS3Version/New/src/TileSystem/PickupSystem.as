package TileSystem 
{
	import flash.display.Stage;
	import flash.geom.Vector3D;
	import Maps.MapTiles;
	import Pickups.Energizer;
	import Pickups.Pellet;
	import Pickups.Pickup;
	/**
	 * ...
	 * @author FDH
	 */
	public class PickupSystem 
	{
		
		private var _mapTiles:TileSystem;
		private var _pickups:Vector.<Pickup>;
		private var _stage:Stage;
		private var _tileSize:int;
		
		public function PickupSystem(mapTiles:TileSystem, stage:Stage) 
		{
			_mapTiles = mapTiles;
			_stage = stage;
			_pickups = new Vector.<Pickup>();
		}
		
		public function loadPickups():void 
		{
			for (var mapY:int = 0; mapY < _mapTiles.MapHeight; mapY++)
			for (var mapX:int = 0; mapX < _mapTiles.MapWidth; mapX++)
			{
				var tile:int = _mapTiles.GetTile(mapX, mapY);
				switch (tile) 
				{
					case MapTiles.TILE_PELLET:
						addPickup(mapX, mapY, new Pellet());
					break;
					case MapTiles.TILE_ENERGIZER:
						addPickup(mapX, mapY, new Energizer());
					break;
					case MapTiles.TILE_FRUIT:
						//addPickup(mapX, mapY, new Pellet());
					break;
					default:
				}
			}
		}
		
		public function removePickups():void 
		{
			var items:int = _pickups.length;
			for (var i:int = 0; i < items; i++)
			{
				_stage.removeChild(_pickups[i]);
			}
			_pickups.splice(0, items);
			_pickups = null;
		}
		
		public function removePickup(mapX:int, mapY:int):void 
		{
			var items:int = _pickups.length;
			for (var i:int = 0; i < items; i++)
			{
				if (_pickups[i].MapPos.x == mapX && _pickups[i].MapPos.y == mapY)
				{
					_stage.removeChild(_pickups[i]);
					_pickups.splice(i, 1);
					return;
				}
			}
		}
		
		private function addPickup(mapX:int, mapY:int, item:Pickup):void 
		{
			// Set pos
			item.x = mapX * _mapTiles.TileWidth;
			item.y = mapY * _mapTiles.TileHeigth;
			item.MapPos = new Vector3D(mapX, mapY);
			
			// Add
			_stage.addChild(item);
			_pickups.push(item);
		}
	}

}