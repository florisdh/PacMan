package Display 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author FDH
	 */
	public class Animation extends Sprite 
	{
		// -- Properties -- //
		
		//
		public var Play:Boolean = true;
		public var Loop:Boolean = true;
		
		// -- Vars -- //
		
		private var _sheet:SpriteSheet;
		
		// Current frame displaying
		private var _cFrame:Bitmap;
		private var _cFrameInd:int = -1;
		
		// Group of frames to play
		private var _frameGroup:Vector.<int>;
		private var _frameGroupIndex:int = -1;
		
		// 
		private var _fps:int;
		private var _frameTimer:Timer;
		
		//
		private var _playing:Boolean = false;
		
		// -- Construct -- //
		
		public function Animation(sheet:SpriteSheet, fps:int = 10) 
		{
			_sheet = sheet;
			_fps = fps;
			_frameTimer = new Timer(1000 / _fps);
			_frameTimer.addEventListener(TimerEvent.TIMER, onFrameDone);
			Start();
		}
		
		// -- PublicMethods -- //
		
		/**
		 * Begins playing or resumes the animation.
		 */
		public function Start():void 
		{
			if (!_playing)
			{
				_playing = true;
				
				// First frame
				NextFrame();
				
				_frameTimer.start();
			}
		}
		
		/**
		 * Stops the animation.
		 */
		public function Stop():void 
		{
			if (_playing)
			{
				_playing = false;
				_frameTimer.stop();
			}
		}
		
		/**
		 * Plays a group of frames
		 * @param	inds	Indexes of frames to play
		 * @param	loop	If to loop the frames
		 */
		public function PlayFrames(inds:Vector.<int>, loop:Boolean = true):void 
		{
			_frameGroup = inds;
			_frameGroupIndex = 0;
			Loop = loop;
			
			// Restart
			if (!_playing) Stop();
			Start();
		}
		
		/**
		 * Calculates the next frame to show, and displays it.
		 */
		public function NextFrame():void 
		{
			var nextFrameInd:int = -1;
			
			// Check if to play all frames or a group
			if (_frameGroup)
			{
				// Increase index
				_frameGroupIndex++;
				
				// Check if last frame was last
				if (_frameGroupIndex >= _frameGroup.length)
				{
					if (Loop) _frameGroupIndex = 0;
					else return;
				}
				
				nextFrameInd = _frameGroup[_frameGroupIndex];
			}
			// Loop all frames
			else
			{
				// Increase index
				_cFrameInd++;
				
				// Check if last frame was last
				if (_cFrameInd >= _sheet.FramesAmount)
				{
					if (Loop) _cFrameInd = 0;
					else return;
				}
				
				nextFrameInd = _cFrameInd;
			}
			
			// Show next frame
			showFrame(nextFrameInd);
		}
		
		// -- PrivateMethods -- //
		
		private function onFrameDone(e:TimerEvent):void 
		{
			NextFrame();
		}
		
		private function showFrame(ind:int):void 
		{
			// Validate
			if (ind < 0 || ind >= _sheet.FramesAmount) return;
			
			// Add new frame
			var newFrame:Bitmap = _sheet.GetFrame(ind);
			if (!newFrame || newFrame == _cFrame) return;
			addChild(newFrame);
			
			// Remove old
			if (_cFrame) removeChild(_cFrame);
			
			// Set new
			_cFrame = newFrame;
			_cFrameInd = ind;
		}
		
	}

}