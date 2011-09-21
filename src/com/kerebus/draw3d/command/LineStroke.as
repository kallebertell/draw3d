package com.kerebus.draw3d.command
{
	import com.kerebus.draw3d.engine.Graphics3d;
	import com.kerebus.draw3d.engine.Line3d;
	import com.kerebus.draw3d.engine.Point3d;
	import com.kerebus.draw3d.model.DrawDataModel;
	import com.kerebus.draw3d.mouse.MouseInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class LineStroke extends DrawCommandBase implements IDrawCommand
	{
		private var _g3d : Graphics3d;
		private var _mouseModel : MouseInfo;
		private var _toolModel : DrawDataModel;
		
		private var _lines : Array = [];
		private var _previewLine : Line3d;
		
		private var _startX : int = -1;
		private var _startY : int = -1;
		private var _startZ : int = -1;
		
		public function LineStroke(graphics3d : Graphics3d, mouseModel : MouseInfo, toolModel : DrawDataModel)
		{
			_g3d = graphics3d;
			_mouseModel = mouseModel;
			_toolModel = toolModel;
		}

		public function onMouseDown(e:MouseEvent) : void 
		{
			_startX = e.stageX;
			_startY = e.stageY;
			
			var hitPoint : Point3d = _g3d.getHitPoint(e.stageX, e.stageY);
			
			if (hitPoint != null) {
				_startZ = hitPoint.z;
			} else {
				_startZ = 0;
			}
			
			
			_g3d.moveTo2D(_startX, _startY, _startZ);
			_g3d.lineStyle(_toolModel.lineWidth, _toolModel.color, _toolModel.lineAlpha);
		} 

		public function onEnterFrame(e:Event):void
		{
			if (_previewLine != null) 
			{
				_g3d.removeLine(_previewLine);
			}
		
			_g3d.moveTo2D(_startX, _startY, _startZ);
			_previewLine = _g3d.lineTo2D(_mouseModel.stageX, _mouseModel.stageY, 0);
		}
		
		public function onMouseUp(e:MouseEvent) : void 
		{
			if (_previewLine != null) 
			{
				_g3d.removeLine(_previewLine);
			}
			
			_g3d.moveTo2D(_startX, _startY, _startZ);
			_lines = _g3d.segmentedLineTo2D(e.stageX, e.stageY, 0);
			dispatchEvent(new DrawCommandEvent(DrawCommandEvent.COMMAND_COMPLETE));
		}

		public function onMouseMove(e:MouseEvent) : void
		{
			
		}
		
		public function undo() : void
		{
			_g3d.removeLines(_lines);
		}
		
		public function get isSavedInHistory() : Boolean
		{
			return true;
		}
	}
}