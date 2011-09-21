package com.kerebus.draw3d.tool
{
	import com.kerebus.draw3d.command.PenStroke;
	
	public class Pen extends ToolBase implements ITool
	{
		
		[Embed("cursor_pen.png")]
		private var _customCursor:Class;
		
		public function Pen()
		{
			super();
		}
		public function get name():String 
		{
			return "PEN";
		}
		
		public function get onMouseDownCommand():Class
		{
			return PenStroke;
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