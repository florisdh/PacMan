package Characters.Enemies 
{
	import Characters.Player;
	import flash.geom.Vector3D;
	import TileSystem.TileSystem;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Shadow extends Enemy 
	{
		
		public function Shadow(mapTile:TileSystem, target:Player) 
		{
			super(mapTile, target);
			_art = new Art_Enemy_Shadow();
			_art.x = _art.y = 8;
			addChild(_art);
			
			Speed = 0.15;
		}
		
	}

}