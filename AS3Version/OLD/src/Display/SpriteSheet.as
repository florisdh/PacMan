package Display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author FDH
	 */
	public class SpriteSheet 
	{
		// -- Properties -- //
		
		// Sprite Sheet Image
		public var Sheet:Bitmap;
		
		// Size of the frames in the sheet in px
		public var FrameWidth:int = 8;
		public var FrameHeight:int = 8;
		
		// Amount of frames
		public var FramesAmount:int;
		
		// -- Vars -- //
		
		private var _frames:Vector.<Bitmap>;
		
		// -- Construct -- //
		
		/**
		 * A object to load frames from a image sheet with similar frame sizes.
		 * @param	img			The image sheet.
		 * @param	frameWidth	The width of the frames in the sheet.
		 * @param	frameHeight	The height of the frames in the sheet.
		 */
		public function SpriteSheet(img:Bitmap, frameWidth:int, frameHeight:int) 
		{
			Sheet = img;
			FrameWidth = frameWidth;
			FrameHeight = frameHeight;
		}
		
		// -- PublicMethods -- //
		
		/**
		 * Loads the frames from the image
		 */
		public function LoadFrames():void 
		{
			var sourceRect:Rectangle, frameData:BitmapData, frame:Bitmap;
			
			// Reset tile array
			_frames = new Vector.<Bitmap>();
			
			// Amount of frames in sheet
			var sheetWidth:int = Math.floor(Sheet.width / FrameWidth);
			var sheetHeight:int = Math.floor(Sheet.height / FrameHeight);
			
			for (var y:int = 0; y < sheetHeight; y++)
			for (var x:int = 0; x < sheetWidth; x++)
			{
				// Calc source rect
				sourceRect = new Rectangle
				(
					x * FrameWidth,
					y * FrameHeight,
					FrameWidth,
					FrameHeight
				);
				
				// Create new tile
				frameData = new BitmapData(FrameWidth, FrameHeight);
				frame = new Bitmap(frameData);
				
				// Copy data to tile
				frameData.copyPixels(Sheet.bitmapData, sourceRect, new Point());
				
				// Add tile to array
				_frames.push(frame);
			}
			
			FramesAmount = _frames.length;
		}
		
		/**
		 * Get's a frame from the loaded frames.
		 * @param	ind		The index of the frame to get.
		 * @return	A frame from the sheet as a bitmap format.
		 */
		public function GetFrame(ind:int):Bitmap
		{
			// Validate
			if (!_frames || ind < 0) return null;
			var tileCount:int = _frames.length;
			if (tileCount == 0 || ind >= tileCount) return null;
			
			return _frames[ind];
		}
		
		// -- PrivateMethods -- //
		
	}

}