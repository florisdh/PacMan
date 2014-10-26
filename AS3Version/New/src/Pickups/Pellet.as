package Pickups 
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author FDH
	 */
	public class Pellet extends Pickup 
	{
		
		public function Pellet() 
		{
			super();
			addChild(new Art_Pellet());
		}
		
	}

}