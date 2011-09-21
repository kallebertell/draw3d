package com.kerebus.draw3d.command
{
	import com.kerebus.draw3d.engine.Graphics3d;
	import com.kerebus.draw3d.engine.Point3d;
	import com.kerebus.draw3d.model.DrawDataModel;
	import com.kerebus.draw3d.mouse.MouseInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TubeStroke extends DrawCommandBase implements IDrawCommand
	{
		private var _g3d : Graphics3d;
		private var _mouseInfo : MouseInfo;
		private var _toolModel : DrawDataModel;
		
		private var _lines : Array = [];
		
		private var z3d : Number = 0;
		
		
		public function TubeStroke(graphics3d : Graphics3d, mouseModel : MouseInfo, toolModel : DrawDataModel)
		{
			_g3d = graphics3d;
			_mouseInfo = mouseModel;
			_toolModel = toolModel;
		}

		public function onMouseDown(e:MouseEvent) : void 
		{	
			var hitPoint : Point3d = _g3d.getHitPoint(_mouseInfo.stageX, _mouseInfo.stageY);
			
			if (hitPoint != null) {
				z3d = hitPoint.z - hitPoint.getFirstLine().lineWidth / 2;
			} else {
				z3d = 0;
			}
			
			_g3d.moveTo2D(_mouseInfo.stageX, _mouseInfo.stageY, z3d);
			_g3d.lineStyle(_toolModel.lineWidth, _toolModel.color, _toolModel.lineAlpha);
		} 

		public function onEnterFrame(e:Event) : void 
		{
			if (_mouseInfo.leftButtonDown)
			{
				_lines.push( _g3d.lineTo2D(_mouseInfo.stageX, _mouseInfo.stageY, z3d) );
			}
		}


		public function onMouseUp(e:MouseEvent) : void 
		{
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
