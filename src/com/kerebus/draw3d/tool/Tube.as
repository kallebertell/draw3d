package com.kerebus.draw3d.tool
{
	import com.kerebus.draw3d.command.TubeStroke;
	
	public class Tube extends ToolBase implements ITool
	{
		
		[Embed("cursor_tube.png")]
		private var _customCursor:Class;
		
		public function Tube()
		{
			super();
		}
		public function get name():String 
		{
			return "TUBE";
		}
		
		public function get onMouseDownCommand():Class
		{
			return TubeStroke;
		}
		
		public function get cursorOffsetX() : int 
		{
			return 0;
		}
		
		public function get cursorOffsetY() : int
		{
			return -30;
		}
		
		public function get customCursor():Class
		{
			return _customCursor;
		}
		
	}
}