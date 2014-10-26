package  
{
	import Characters.Enemies.Bashful;
	import Characters.Enemies.Enemy;
	import Characters.Enemies.Pokey;
	import Characters.Enemies.Shadow;
	import Characters.Enemies.Speedy;
	import Characters.Player;
	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import Maps.MapTiles;
	import Pickups.Pickup;
	import TileSystem.PickupSystem;
	import TileSystem.TileSystem;
	import UI.Controls.Label;
	/**
	 * ...
	 * @author FDH
	 */
	public class Game extends Sprite
	{
		// -- Events -- //
		
		public static const DIED:String = "DIED";
		
		// -- Properties -- //
		
		// -- Vars -- //
		
		private var _tileSystem:TileSystem;
		private var _pickups:PickupSystem;
		
		private var _bg:Sprite;
		private var _player:Player;
		
		private var _enemies:Vector.<Enemy>;
		
		private var _started:Boolean = false;
		private var _paused:Boolean = false;
		
		private var _startTimer:Timer;
		
		private var _lifes:int = 3;
		
		private var _energized:Boolean = false;
		private var _energizeTimer:Timer;
		
		// UI
		private var _levelLabel:Label;
		private var _scoreLabel:Label;
		private var _lifeLabel:Label;
		
		// -- Construct&init -- //
		
		public function Game() 
		{
			_bg = new LevelBG();
			addChild(_bg);
			
		}
		
		private function init():void
		{
			// Tiles
			_tileSystem = new TileSystem();
			_tileSystem.LoadMap(MapTiles.Map1, MapTiles.Map1Width, MapTiles.Map1Height);
			_tileSystem.TileWidth = _tileSystem.TileHeigth = 16;
			
			// Pickups
			_pickups = new PickupSystem(_tileSystem, stage);
			_pickups.loadPickups();
			
			// Player
			_player = new Player(_tileSystem);
			_player.Freeze = true;
			addChild(_player);
			
			// Enemies
			_enemies = new Vector.<Enemy>();
			addEnemy(1, 13, 11);
			addEnemy(2, 14, 11);
			addEnemy(3, 15, 11);
			
			// UI
			_levelLabel = new Label();
			_levelLabel.TextSize = 3;
			_levelLabel.x = 224;
			_levelLabel.y = 248;
			addChild(_levelLabel);
			_scoreLabel = new Label("Score: 0");
			_scoreLabel.TextSize = 2;
			_scoreLabel.x = 64;
			_scoreLabel.y = 510;
			addChild(_scoreLabel);
			_lifeLabel = new Label("Lifes: 3");
			_lifeLabel.TextSize = 2;
			_lifeLabel.x = 300;
			_lifeLabel.y = 510;
			addChild(_lifeLabel);
			
			// Timers
			_startTimer = new Timer(2000);
			_startTimer.addEventListener(TimerEvent.TIMER, begin);
			_energizeTimer = new Timer(4000);
			_energizeTimer.addEventListener(TimerEvent.TIMER, stopEnergizing);
			
			// Events
			Main.SCORE.addEventListener(Score.CHANGE, onScoreChange);
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			//for (var mapY:int = 0; mapY < _tileSystem.MapHeight; mapY++)
			//for (var mapX:int = 0; mapX < _tileSystem.MapWidth; mapX++)
			//{
				//graphics.lineStyle(1, _tileSystem.GetTile(mapX, mapY) == 1 ? 0x0000FF : 0x00FF00);
				//graphics.drawRect(mapX * 16, mapY * 16, 16, 16);
			//}
		}
		
		public function destruct():void 
		{
			_pickups.removePickups();
			removeChild(_player);
			removeChild(_scoreLabel);
			removeChild(_levelLabel);
			removeChild(_lifeLabel);
			for (var i:int = 0; i < _enemies.length; i++ )
			{
				removeChild(_enemies[i]);
			}
			_enemies.splice(0, _enemies.length);
			
			Main.SCORE.removeEventListener(Score.CHANGE, onScoreChange);
			removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_startTimer.removeEventListener(TimerEvent.TIMER, begin)
		}
		
		// -- EventCallBacks -- //
		
		private function update(e:Event):void 
		{
			if (_paused) return;
			
			// Update player
			_player.update(e);
			
			// Check for pickup eating
			var facingPos:Vector3D = _player.TilePos;
			var tile:int = _tileSystem.GetTile(facingPos.x, facingPos.y);
			if (MapTiles.IsPickup(tile))
			{
				switch (tile)
				{
					case MapTiles.TILE_PELLET:
						_pickups.removePickup(facingPos.x, facingPos.y);
						_tileSystem.SetTile(facingPos.x, facingPos.y, 0);
						Main.SCORE.add(10);
					break;
					case MapTiles.TILE_ENERGIZER:
						_pickups.removePickup(facingPos.x, facingPos.y);
						_tileSystem.SetTile(facingPos.x, facingPos.y, 0);
						
						_energized = true;
						_energizeTimer.start();
					break;
					default:
				}
			}
			
			// Update enemies
			for each (var c:Enemy in _enemies)
			{
				c.update(e);
				
				// Check if on the same tile as player
				if (c.TilePos.x == _player.TilePos.x && c.TilePos.y == _player.TilePos.y)
				{
					if (_energized)
					{
						c.TilePos = c.SpawnPos;
						trace("eat");
					}
					else
					{
						resetPlayer();
					}
				}
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			_player.onKeyDown(e);
		}
		
		private function onScoreChange(e:Event):void 
		{
			_scoreLabel.Text = "Score: " + Main.SCORE.Current;
		}
		
		private function stopEnergizing(e:Event):void 
		{
			_energized = false;
		}
		
		// -- Methods -- //
		
		public function start():void 
		{
			if (_started) return;
			_started = true;
			_paused = false;
			
			Main.SCORE.Current = 0;
			
			// Load
			init();
			
			// Show UI
			_levelLabel.Text = "Level 1";
			_levelLabel.fadeOut(200, 0.1);
			
			_startTimer.start();
		}
		
		public function begin(e:Event = null):void 
		{
			_startTimer.stop();
			
			_player.Freeze = false;
			for each (var c:Enemy in _enemies)
			{
				c.Freeze = false;
			}
		}
		
		public function resetPlayer():void 
		{
			_lifes--;
			if (_lifes <= 0)
			{
				dispatchEvent(new Event(DIED));
			}
			_lifeLabel.Text = "Lifes: " + _lifes;
			
			_player.TilePos = new Vector3D(14, 23);
			_player.Freeze = true;
			
			for each (var c:Enemy in _enemies)
			{
				c.TilePos = c.SpawnPos;
				c.Freeze = true;
			}
			
			_startTimer.start();
		}
		
		public function stop():void 
		{
			if (!_started) return;
			_started = false;
			
			destruct();
		}
		
		public function pause():void 
		{
			if (_paused || !_started) return;
			_paused = true;
			
			_player.pause();
		}
		
		public function resume():void 
		{
			if (!_paused || !_started) return;
			_paused = false;
			
			_player.resume();
		}
		
		private function addEnemy(type:int, mapX:int, mapY:int):void 
		{
			var newEnemy:Enemy;
			
			switch (type) 
			{
				case 0:
					newEnemy = new Shadow(_tileSystem, _player);
				break;
				case 1:
					newEnemy = new Speedy(_tileSystem, _player);
				break;
				case 2:
					newEnemy = new Pokey(_tileSystem, _player);
				break;
				case 3:
					newEnemy = new Bashful(_tileSystem, _player);
				break;
				default:
			}
			
			newEnemy.Freeze = true;
			newEnemy.SpawnPos = new Vector3D(mapX, mapY);
			newEnemy.TilePos = new Vector3D(mapX, mapY);
			
			_enemies.push(newEnemy);
			addChild(newEnemy);
		}
		
		// -- Get&Set -- //
		
		public function get Started():Boolean
		{
			return _started;
		}
		
		public function get Paused():Boolean
		{
			return _paused;
		}
		
		public function set Paused(newVal:Boolean):void 
		{
			_paused = newVal;
		}
	}

}