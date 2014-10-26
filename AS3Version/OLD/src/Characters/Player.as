package Characters 
{
	import Display.Animation;
	import Display.SpriteSheet;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import TileSystem.TileSystem;
	/**
	 * ...
	 * @author FDH
	 */
	public class Player extends Character 
	{
		// -- Properties -- //
		
		public var KEY_UP:int = 87;
		public var KEY_DOWN:int = 83;
		public var KEY_LEFT:int = 65;
		public var KEY_RIGHT:int = 68;
		
		// -- Vars -- //
		
		// -- Construct -- //
		
		public function Player(sheet:SpriteSheet, map:TileSystem) 
		{
			super(sheet, map);
			Speed = 4;
			_anim.PlayFrames(new <int> [ 0, 1 ]);
		}
		
		// -- PublicMethods -- //
		
		public override function update(e:Event):void 
		{
			// Update animation
			if (_dir != _lastDir)
			{
				_lastDir = _dir;
				switch (_dir) 
				{
					case 0: // Up
						_anim.PlayFrames(new <int> [ 4, 5 ]);
					break;
					case 1: // Right
						_anim.PlayFrames(new <int> [ 0, 1 ]);
					break;
					case 2: // Down
						_anim.PlayFrames(new <int> [ 6, 7 ]);
					break;
					case 3: // left
						_anim.PlayFrames(new <int> [ 2, 3 ]);
					break;
					default:
				}
			}
			
			// Apply velo
			super.update(e);
		}
		
		public function keyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case KEY_UP:
					_preferedDir = 0;
				break;
				case KEY_RIGHT:
					_preferedDir = 1;
				break;
				case KEY_DOWN:
					_preferedDir = 2;
				break;
				case KEY_LEFT:
					_preferedDir = 3;
				break;
			}
		}
		
		public function keyUp(e:KeyboardEvent):void 
		{
			
		}
		
		// -- PrivateMethods -- //
		
	}

}