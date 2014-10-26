package Characters 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import Maps.MapTiles;
	import TileSystem.PickupSystem;
	import TileSystem.TileSystem;
	/**
	 * ...
	 * @author FDH
	 */
	public class Player extends Character 
	{
		// -- Static -- //
		
		public static const Key_UP:int = 87;
		public static const Key_Down:int = 83;
		public static const Key_Left:int = 65;
		public static const Key_Right:int = 68;
		
		// -- Properties -- //
		
		// -- Vars -- //
		
		// -- Construct -- //
		
		public function Player(mapTiles:TileSystem) 
		{
			super(mapTiles);
			
			_art = new Art_Player();
			_art.gotoAndPlay(0);
			_art.x = _art.y = 8;
			addChild(_art);
			
			_mapPos = new Vector3D(14, 23);
			applyMapPos();
			setDir(3);
			
			//graphics.lineStyle(1, 0xFF0000);
			//graphics.drawRect(8, 8, tileSize, tileSize);
		}
		
		// -- Methods -- //
		
		override public function update(e:Event):void 
		{
			super.update(e);
			
		}
		
		override protected function onDirChange():void 
		{
			switch (_dir) 
			{
				case 0:
					_art.rotation = 270;
				break;
				case 1:
					_art.rotation = 0;
				break;
				case 2:
					_art.rotation = 90;
				break;
				case 3:
					_art.rotation = 180;
				break;
				default:
			}
		}
		
		public function onKeyDown(e:KeyboardEvent):void 
		{
			if (Freeze) return;
			switch (e.keyCode) 
			{
				case Key_UP:
					_preferedDir = 0;
				break;
				case Key_Right:
					_preferedDir = 1;
				break;
				case Key_Down:
					_preferedDir = 2;
				break;
				case Key_Left:
					_preferedDir = 3;
				break;
				default:
			}
		}
		
	}

}