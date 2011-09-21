package com.kerebus.draw3d.tool
{
	import com.kerebus.draw3d.command.RotateCommand;
	
	public class Rotator extends ToolBase implements ITool
	{
		
		[Embed("cursor_rotate.png")]
		private var _customCursor:Class;
	 
	 	public function get name():String 
		{
			return "ROTATOR";
		}
		
	 	public function get customCursor() : Class 
	 	{
	 		return _customCursor;
	 	}
	 	
		public function get onMouseDownCommand() : Class 
		{
			return RotateCommand;
		}
		
		public function get cursorOffsetX() : int 
		{
			return 0;
		}
		
		public function get cursorOffsetY() : int
		{
			return 0;
		}

	}
}