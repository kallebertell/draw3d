package com.kerebus.draw3d.mouse
{
   import mx.managers.CursorManager;
 
 	/**
 	 * Wraps CursorManager and decorates it with a 
 	 * fallback to system cursor while preserving the last set
 	 * custom cursor. 
 	 * There was no way to do this with CursorManager w/o monkey patching.
 	 */ 
	public class Cursor
	{
		private static var _isCustomCursorHidden : Boolean = true;
		
		private static var cursorEntry : CursorEntry;
		
		public static function setCursor(cursor:Class, priotity:int=2, xOffset:int=0, yOffset:int=0):void
		{
			var cursorId : int = CursorManager.setCursor(cursor, priotity, xOffset, yOffset);
			cursorEntry = new CursorEntry(cursor, priotity, xOffset, yOffset);
			_isCustomCursorHidden = false;
		}
	 
	 	public static function hideCustomCursor():void
	 	{
	 		CursorManager.removeAllCursors();
	 		_isCustomCursorHidden = true;
	 	}
	 	
		public static function restoreCustomCursor():void
		{
			if (cursorEntry != null) 
			{
				CursorManager.setCursor(cursorEntry.cursor, cursorEntry.priority, cursorEntry.xOffset, cursorEntry.yOffset);
				_isCustomCursorHidden = false;
			}
		}
		
		public static function isCustomCursorHidden():Boolean
		{
			return _isCustomCursorHidden;
		}
	}
}

class CursorEntry 
{
	public function CursorEntry(cursor:Class, priotity:int=2, xOffset:int=0, yOffset:int=0) 
	{
		this.cursor = cursor;
		this.priority = priority;
		this.xOffset = xOffset;
		this.yOffset = yOffset;
	}
	
	public var cursor : Class;
	public var priority : int;
	public var xOffset : int;
	public var yOffset : int;
}