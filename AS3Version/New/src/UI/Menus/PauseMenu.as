package UI.Menus 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author FDH
	 */
	public class PauseMenu extends Menu 
	{
		// -- Properties -- //
		
		// -- Vars -- // 
		
		// -- Construct & Init -- //
		
		public function PauseMenu() 
		{
			super();
			BackGroundAlpha = 0.5;
		}
		
		override protected function init(e:Event = null):void 
		{
			super.init(e);
			addLabel("Paused", 224, 248, 3);
		}
		
	}

}