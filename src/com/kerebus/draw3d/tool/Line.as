package com.kerebus.draw3d.tool
{
	import com.kerebus.draw3d.command.LineStroke;
	
	public class Line extends ToolBase implements ITool
	{
		
		[Embed("cursor_line.png")]
		private var _customCursor:Class;
		
		public function Line()
		{
			super();
		}
		
		public function get name():String 
		{
			return "LINE";
		}
		
		public function get onMouseDownCommand():Class
		{
			return LineStroke;
		}
		
		public function get customCursor():Class
		{
			return _customCursor;
		}		
		
		public function get cursorOffsetX() : int 
		{
			return 0;
		}
		
		public function get cursorOffsetY() : int
		{
			return -3;
		}
	}
}