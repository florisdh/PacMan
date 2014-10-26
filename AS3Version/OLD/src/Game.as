package  
{
	import adobe.utils.CustomActions;
	import Characters.Player;
	import Display.Animation;
	import Display.SpriteSheet;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import TileSystem.*;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Game
	{
		private var _stage:Stage;
		
		// Map Sprite Sheet
		[Embed(source="../ART/PacMan_TilePack.png")]
		private var TileArt:Class;
		private var MapSheet:SpriteSheet;
		private var Map:TileSystem;
		
		[Embed(source = "../ART/PlayerSheet.png")]
		private var PlayerArt:Class;
		private var PlayerSheet:SpriteSheet;
		private var Player1:Player;
		
		public function Game(s:Stage) 
		{
			_stage = s;
			
			// Load map Sheet
			MapSheet = new SpriteSheet(new TileArt(), 8, 8);
			MapSheet.LoadFrames();
			
			// Load map
			Map = new TileSystem(MapSheet, MapTiles.Map1Tiles, MapTiles.Map1Width, MapTiles.Map1Height);
			Map.DrawMap();
			Map.Scale(2);
			_stage.addChild(Map);
			
			init();
		}
		
		private function init():void 
		{
			// Load player
			PlayerSheet = new SpriteSheet(new PlayerArt(), 16, 16);
			PlayerSheet.LoadFrames();
			Player1 = new Player(PlayerSheet, Map);
			Player1.Scale = 2;
			Player1.Position = new Vector3D(1, 1);
			_stage.addChild(Player1);
			
			// Add events
			_stage.addEventListener(Event.ENTER_FRAME, update);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function update(e:Event):void 
		{
			Player1.update(e);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			Player1.keyDown(e);
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			Player1.keyUp(e);
		}
	}

}