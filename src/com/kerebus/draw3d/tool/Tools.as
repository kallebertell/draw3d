package com.kerebus.draw3d.tool
{
	public class Tools
	{
		public static var PEN : Pen = new Pen();
		public static var LINE : Line = new Line();
		public static var ROTATOR : Rotator = new Rotator();
		public static var TUBE : Tube = new Tube();
		
		private static var _tools : Array = [];
		
		// static initalizer
		{
			_tools.push(PEN);
			_tools.push(TUBE);
			_tools.push(LINE);
			_tools.push(ROTATOR);
		}
		
		
		public static function get tools() : Array 
		{
			return _tools;
		} 
		
		
		public function Tools()
		{
			throw new Error("May not create more instances");
		}

	}
}