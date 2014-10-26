package Characters 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import Maps.MapTiles;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Character extends Sprite 
	{
		// -- Properties -- //
		
		public var Speed:Number = 0.2;
		public var Freeze:Boolean = true;
		public var SpawnPos:Vector3D;
		
		// -- Vars -- //
		
		protected var _paused:Boolean = false;
		
		protected var _art:MovieClip;
		
		protected var _mapTiles:TileSystem;
		
		protected var _mapPos:Vector3D;
		
		protected var _lastDir:int = -1;
		protected var _dir:int = 0;
		protected var _preferedDir:int = -1;
		
		// -- Construct -- //
		
		public function Character(mapTile:TileSystem) 
		{
			_mapTiles = mapTile;
			_mapPos = new Vector3D(1, 1);
		}
		
		// -- Methods -- //
		
		public function update(e:Event):void 
		{
			// Validate prefered dir
			if (_preferedDir != _dir)
			{
				// Check if there is no collision at direction
				if (validateNewDir(_preferedDir))
				{
					setDir(_preferedDir);
				}
			}
			
			// Apply dir
			if (!Freeze)
			{
				switch (_dir) 
				{
					case 0: // Up
						_mapPos.y -= Speed;
					break;
					case 1: // Right
						_mapPos.x += Speed;
					break;
					case 2: // Down
						_mapPos.y += Speed;
					break;
					case 3: // Left
						_mapPos.x -= Speed;
					break;
					default:
				}
			}
			
			// Collision
			if (_dir == 0 && checkTileOffset(0) < Speed && checkCollision(0))
			{ // Top
				_mapPos.y = Math.round(_mapPos.y);
			}
			if (_dir == 1 && checkTileOffset(1) < Speed && checkCollision(1))
			{ // Right
				_mapPos.x = Math.round(_mapPos.x);
			}
			if (_dir == 2 && checkTileOffset(2) < Speed && checkCollision(2))
			{ // Bottom
				_mapPos.y = Math.round(_mapPos.y);
			}
			if (_dir == 3 && checkTileOffset(3) < Speed && checkCollision(3))
			{ // Left
				_mapPos.x = Math.round(_mapPos.x);
			}
			
			// 2 tunnels
			if (_mapPos.x < -1) _mapPos.x = _mapTiles.MapWidth;
			if (_mapPos.x > _mapTiles.MapWidth) _mapPos.x = -1;
			
			// Apply position
			applyMapPos();
		}
		
		public function pause():void 
		{
			if (_paused) return;
			_paused = true;
			_art.stop();
		}
		
		public function resume():void 
		{
			if (!_paused) return;
			_paused = false;
			_art.play();
		}
		
		protected function onDirChange():void 
		{
		}
		
		protected function setDir(newDir:int):void 
		{
			_lastDir = _dir;
			_dir = newDir;
			onDirChange();
			
			if (_dir == 0 || _dir == 2) _mapPos.x = Math.round(_mapPos.x);
			if (_dir == 1 || _dir == 3) _mapPos.y = Math.round(_mapPos.y);
		}
		
		protected function checkTileOffset(side:int):Number
		{
			switch (side) 
			{
				case 0: // Top
					return _mapPos.y - Math.round(_mapPos.y);
				break;
				case 1: // Right
					return Math.round(_mapPos.x) - _mapPos.x;
				break;
				case 2: // Bottom
					return Math.round(_mapPos.y) - _mapPos.y;
				break;
				case 3: // Left
					return _mapPos.x - Math.round(_mapPos.x);
				break;
				default:
			}
			return -1;
		}
		
		// Up down right left
		protected function checkCollision(side:int):Boolean
		{
			return getTileAtSide(side) == MapTiles.TILE_WALL;
		}
		
		protected function getTileAtSide(side:int):int 
		{
			var tilePos:Vector3D = getSidePos(side);
			return _mapTiles.GetTile(tilePos.x, tilePos.y);
		}
		
		protected function getSidePos(side:int):Vector3D 
		{
			var rv:Vector3D = new Vector3D();
			var mapX:int = Math.round(_mapPos.x), mapY:int = Math.round(_mapPos.y);
			
			switch (side) 
			{
				case 0: // up
					rv = new Vector3D(mapX, mapY - 1);
				break;
				case 1: // right
					rv = new Vector3D(mapX + 1, mapY);
				break;
				case 2: // down
					rv = new Vector3D(mapX, mapY + 1);
				break;
				case 3: // left
					rv = new Vector3D(mapX - 1, mapY);
				break;
				default:
			}
			return rv;
		}
		
		protected function applyMapPos():void 
		{
			x = _mapPos.x * _mapTiles.TileWidth;
			y = _mapPos.y * _mapTiles.TileHeigth;
		}
		
		protected function validateNewDir(newDir:int):Boolean
		{
			// Check if not already going to dir
			if (newDir == _dir) return false;
			
			// No way to go
			if (checkCollision(_preferedDir)) return false;
			
			// Check if too far from entry
			if (checkTileOffset(_dir) >= Speed) return false;
			
			return true;
		}
		
		// -- GetSet -- //
		
		public function get FacingTilePosition():Vector3D
		{
			return getSidePos(_dir);
		}
		
		public function get TilePos():Vector3D
		{
			return new Vector3D(Math.round(_mapPos.x), Math.round(_mapPos.y));
		}
		public function set TilePos(newVal:Vector3D):void
		{
			_mapPos = newVal;
		}
	}

}