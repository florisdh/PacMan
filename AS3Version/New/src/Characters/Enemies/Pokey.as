package Characters.Enemies 
{
	import Characters.Player;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Pokey extends Enemy 
	{
		
		public function Pokey(mapTile:TileSystem, target:Player) 
		{
			super(mapTile, target);
			_art = new Art_Enemy_Pokey();
			_art.x = _art.y = 8;
			addChild(_art);
			
			Speed = 0.13;
			_stateTimer.delay = 8000;
		}
		
	}

}