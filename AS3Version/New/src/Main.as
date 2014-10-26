package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import UI.Menus.Menu;
	import UI.Menus.PauseMenu;
	import UI.Menus.QuitMenu;
	import UI.Menus.StartMenu;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Main extends Sprite 
	{
		// -- Constants -- //
		
		private static const BUTTON_PAUSE:int = 80; // P
		private static const BUTTON_QUIT:int = 81 // Q
		private static const BUTTON_CONFIRM:int = 89 // Y
		private static const BUTTON_CANCEL:int = 78 // N
		
		// -- Static -- //
		
		public static var SCORE:Score;
		
		// -- Vars -- //
		
		private var _game:Game;
		private var _menu:Menu;
		
		private var _quitAttempt:Boolean = false;
		
		// -- Construct -- //
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			SCORE = new Score();
			
			// Create game
			_game = new Game();
			_game.addEventListener(Game.DIED, onDied);
			
			// Show start menu
			showStartMenu();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		// -- EventCallBacks -- //
		
		private function onDied(e:Event):void 
		{
			_game.stop();
			showStartMenu();
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == BUTTON_PAUSE && _game.Started)
			{ // Pause or resume
				if (_game.Paused) resumeGame();
				else pauseGame();
			}
			else if (e.keyCode == BUTTON_QUIT && _game.Started && !_quitAttempt)
			{ // Attempt quit
				_quitAttempt = true;
				_game.pause();
				showQuitMenu();
			}
			else if (_quitAttempt && e.keyCode == BUTTON_CONFIRM)
			{ // Accept quit
				_quitAttempt = false;
				stopGame();
				showStartMenu();
			}
			else if (_quitAttempt && e.keyCode == BUTTON_CANCEL)
			{ // Cancel quit
				_quitAttempt = false;
				_game.resume();
				hideMenu();
			}
		}
		
		// -- Methods -- //
		
		private function startGame(e:Event = null):void 
		{
			hideMenu();
			
			addChild(_game);
			_game.start();
		}
		
		private function stopGame(e:Event = null):void
		{
			_game.stop();
			removeChild(_game);
		}
		
		private function pauseGame(e:Event = null):void 
		{
			_game.pause();
			showPauseMenu();
		}
		
		private function resumeGame(e:Event = null):void 
		{
			hideMenu();
			_game.resume();
		}
		
		private function showStartMenu():void 
		{
			// Hide last menu
			hideMenu();
			
			// Create Start Menu
			_menu = new StartMenu();
			_menu.addEventListener(StartMenu.START, startGame);
			addChild(_menu);
		}
		
		private function showPauseMenu():void 
		{
			// Hide last menu
			hideMenu();
			
			// Create Start Menu
			_menu = new PauseMenu();
			addChild(_menu);
		}
		
		private function showQuitMenu():void 
		{
			// Hide last menu
			hideMenu();
			
			// Create menu
			_menu = new QuitMenu();
			addChild(_menu);
		}
		
		private function hideMenu():void 
		{
			if (_menu)
			{
				removeChild(_menu);
				_menu = null;
			}
			stage.focus = null;
		}
	}
	
}