package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author FDH
	 */
	public class Score extends EventDispatcher
	{
		// -- Events -- //
		
		public static const CHANGE:String = "CHANGE";
		
		// -- Properties -- //
		
		public var Highest:int = 0;
		
		// -- Vars -- //
		
		private var _current:int = 0;
		
		public function Score() 
		{
			
		}
		
		public function add(amount:int):void 
		{
			Current += amount;
			
			// Set highest score
			if (Current > Highest) Highest = Current;
		}
		
		public function get Current():int
		{
			return _current;
		}
		
		public function set Current(newVal:int):void 
		{
			_current = newVal;
			dispatchEvent(new Event(CHANGE));
		}
		
	}

}