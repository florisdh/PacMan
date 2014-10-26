package UI.Menus 
{
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author FDH
	 */
	public class StartMenu extends Menu 
	{
		// -- Events -- //
		
		public static const START:String = "START";
		public static const CONTROLS:String = "CONTROLS";
		public static const ABOUT:String = "ABOUT";
		
		// -- Properties -- //
		
		// -- Vars -- // 
		
		// -- Construct & Init -- //
		
		public function StartMenu() 
		{
			super();
			BackGroundAlpha = 1;
		}
		
		override protected function init(e:Event = null):void 
		{
			super.init(e);
			addButton("Start Game", 232, 300, START);
			addButton("Controls", 232, 350, CONTROLS);
			addButton("About", 232, 400, ABOUT);
		}
		
		// -- Methods -- //
		
		override protected function draw():void 
		{
		}
	}

}