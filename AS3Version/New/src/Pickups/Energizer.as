package Pickups 
{
	/**
	 * ...
	 * @author FDH
	 */
	public class Energizer extends Pickup 
	{
		
		public function Energizer() 
		{
			super();
			addChild(new Art_Energizer());
		}
		
	}

}