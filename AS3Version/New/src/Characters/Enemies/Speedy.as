package Characters.Enemies 
{
	import Characters.Player;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Speedy extends Enemy 
	{
		
		public function Speedy(mapTile:TileSystem, target:Player) 
		{
			super(mapTile, target);
			_art = new Art_Enemy_Speedy();
			_art.x = _art.y = 8;
			addChild(_art);
			
			Speed = 0.19;
			_stateTimer.delay = 3000;
		}
		
	}

}