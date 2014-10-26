package UI.Menus 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author FDH
	 */
	public class QuitMenu extends Menu 
	{
		
		public function QuitMenu() 
		{
			super();
			
		}
		
		override protected function init(e:Event = null):void 
		{
			super.init(e);
			addLabel("Quit? Y/N", 224, 248, 3);
		}
		
	}

}