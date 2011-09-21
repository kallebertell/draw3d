package com.kerebus.draw3d.model
{
	import com.kerebus.draw3d.tool.ITool;
	import com.kerebus.draw3d.tool.Tools;
	
	
	[Bindable]
	public class DrawDataModel
	{
		private var _color : Number = 0xff0000;
		private var _lineWidth : Number = 20;
		private var _lineAlpha : Number = 1;
		
		private var _tool : ITool = Tools.PEN;
		
		public function get color () : Number {
			return _color;
		}
		
		public function set color(value : Number) : void {
			_color = value;
		}
		
		public function get lineWidth() : Number {
			return _lineWidth;
		}
		
		public function set lineWidth(value : Number) : void {
			_lineWidth = value;
		}
		
		public function get lineAlpha() : Number {
			return _lineAlpha;
		}
		
		public function set lineAlpha(value : Number) : void {
			_lineAlpha = value;
		}
		
		public function set tool(value : ITool) : void {
			_tool = value;
		}
		
		public function get tool() : ITool {
			return _tool;
		}
	}
}