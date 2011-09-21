package com.kerebus.draw3d.tool
{
	public interface ITool
	{
		function get name() : String;
		function get onMouseDownCommand() : Class;
		function get customCursor() : Class;
		function get cursorOffsetX() : int 
		function get cursorOffsetY() : int
		
	}
}