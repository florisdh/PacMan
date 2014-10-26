package Characters 
{
	import Display.Animation;
	import Display.SpriteSheet;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import TileSystem.MapTiles;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Character extends Sprite 
	{
		// -- Properties -- //
		
		public var Speed:Number;
		
		public function set Position(newPos:Vector3D):void 
		{
			this.x = newPos.x * _map.TileWidth - _map.TileWidth / _scale;
			this.y = newPos.y * _map.TileHeight - _map.TileHeight / _scale;
			_currentTile = newPos;
		}
		
		public function set Scale(newScale:Number):void 
		{
			this.scaleX = newScale;
			this.scaleY = newScale;
			_scale = newScale;
		}
		
		// -- Vars -- //
		
		// Velocity to apply (outside tile system)
		protected var _velo:Vector3D = new Vector3D();
		
		// Direction (0=up, 1=right, 2=down, 3=left)
		protected var _lastDir:int = -1;
		protected var _dir:int = -1;
		protected var _preferedDir:int = -1;
		
		protected var _map:TileSystem;
		protected var _currentTile:Vector3D;
		
		// Art
		protected var _anim:Animation;
		protected var _scale:Number = 1;
		
		protected var _canGoUp:Boolean;
		protected var _canGoRight:Boolean;
		protected var _canGoDown:Boolean;
		protected var _canGoLeft:Boolean;
		
		// -- Construct -- //
		
		public function Character(sheet:SpriteSheet, map:TileSystem) 
		{
			_anim = new Animation(sheet, 15);
			addChild(_anim);
			_map = map;
		}
		
		// -- PublicMethods -- //
		
		public function update(e:Event):void 
		{
			var newPos:Vector3D, newTilePos:Vector3D;
			
			// Calc next position
			newPos = new Vector3D
			(
				x + _velo.x,
				y + _velo.y
			);
			
			// Calc next tile
			newTilePos = new Vector3D
			(
				(newPos.x + _map.TileWidth / _scale) / _map.TileWidth,
				(newPos.y + _map.TileHeight / _scale) / _map.TileHeight
			);
			
			// Check if tile changed
			if (newTilePos != _currentTile)
			{
				var upcommingTile:int;
				var blockX:Boolean;
				// Check for directional tile
				switch (_dir) 
				{
					case 0: // Up
						upcommingTile = _map.GetTile(newTilePos.x, Math.floor(newTilePos.y));
						blockX = false;
					break;
					case 1: // Right
						upcommingTile = _map.GetTile(Math.ceil(newTilePos.x), newTilePos.y);
						blockX = true;
					break;
					case 2: // Down
						upcommingTile = _map.GetTile(newTilePos.x, Math.ceil(newTilePos.y));
						blockX = false;
					break;
					case 3: // Left
						upcommingTile = _map.GetTile(Math.floor(newTilePos.x), newTilePos.y);
						blockX = true;
					break;
					default:
				}
				
				// Collision check
				if (!_canGoUp)
				if (MapTiles.IsWall(upcommingTile))
				{
					if (blockX) newPos.x = x;
					else newPos.y = y;
				}
			}
			
			// Apply velo
			x = newPos.x;
			y = newPos.y;
		}
		
		// -- PrivateMethods -- //
		
	}

}