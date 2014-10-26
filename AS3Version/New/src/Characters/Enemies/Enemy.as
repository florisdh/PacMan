package Characters.Enemies 
{
	import Characters.Character;
	import Characters.Player;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import Maps.MapTiles;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Enemy extends Character 
	{
		protected var _target:Player;
		protected var _targetPos:Vector3D;
		
		protected var _stateTimer:Timer;
		
		// State
		protected var _chase:Boolean = true;
		
		public function Enemy(mapTile:TileSystem, target:Player) 
		{
			super(mapTile);
			_target = target;
			
			_stateTimer = new Timer(5000);
			_stateTimer.addEventListener(TimerEvent.TIMER, onStateChange);
			_stateTimer.start();
			
			Freeze = false;
			_dir = 0;
		}
		
		override public function update(e:Event):void 
		{
			// AI
			if (_chase) doChase();
			else doScatter();
			
			// Animation
			var cFrame:int = _art.currentFrame;
			switch (_dir) 
			{
				case 0: // Up
					if (cFrame > 18 || cFrame < 13)
						_art.gotoAndPlay(13);
				break;
				case 1: // Right
					if (cFrame > 6 || cFrame < 0)
						_art.gotoAndPlay(0);
				break;
				case 2: // Down
					if (cFrame > 24 || cFrame < 19)
						_art.gotoAndPlay(19);
				break;
				case 3: // Left
					if (cFrame > 12 || cFrame < 7)
						_art.gotoAndPlay(7);
				break;
				default:
			}
			
			super.update(e);
		}
		
		protected function onStateChange(e:Event):void 
		{
			_chase = !_chase;
		}
		
		protected function doChase():void 
		{
			var newDir:int = -1;
			
			// Calc target tile
			_targetPos = _target.TilePos;
			var offset:Vector3D = new Vector3D(_targetPos.x - _mapPos.x, _targetPos.y - _mapPos.y);
			
			// First best moves
			while (true)
			{
				if (_dir != 2 && offset.y < -Speed && !checkCollision(0))
				{ // Up
					newDir = 0;
					break;
				}
				if (_dir != 3 && offset.x > Speed && !checkCollision(1))
				{ // Right
					newDir = 1;
					break;
				}
				if (_dir != 0 && offset.y > Speed && !checkCollision(2))
				{ // Down
					newDir = 2;
					break;
				}
				if (_dir != 1 && offset.x < -Speed && !checkCollision(3))
				{ // Left
					newDir = 3;
					break;
				}
				break;
			}
			
			
			//if (newDir != _dir)
				_preferedDir = newDir;
		}
		
		protected function doScatter():void 
		{
			if (checkCollision(_dir) || _dir == -1)
			{
				var availableDir:Vector.<int> = new Vector.<int>();
				
				for (var i:int = 0; i < 4; i++ )
				{
					if (!checkCollision(i)) availableDir.push(i);
				}
				
				var rndInd:int = Math.random() * availableDir.length;
				_preferedDir = availableDir[rndInd];
			}
		}
	}

}