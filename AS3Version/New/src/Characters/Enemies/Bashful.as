package Characters.Enemies 
{
	import Characters.Player;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Bashful extends Enemy 
	{
		
		public function Bashful(mapTile:TileSystem, target:Player) 
		{
			super(mapTile, target);
			_art = new Art_Enemy_Bashful();
			_art.x = _art.y = 8;
			addChild(_art);
			
			Speed = 0.1;
			_stateTimer.delay = 10000;
		}
		
	}

}