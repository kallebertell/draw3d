package com.kerebus.draw3d.command
{
	import com.kerebus.draw3d.engine.Graphics3d;
	import com.kerebus.draw3d.model.DrawDataModel;
	import com.kerebus.draw3d.mouse.MouseInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RotateCommand extends DrawCommandBase implements IDrawCommand
	{
		private var _g3d : Graphics3d;
		private var _mouseModel : MouseInfo;
		private var _toolModel : DrawDataModel;

		private var rotations : Array = [];
		
		private var _currentX : int = -1;
		private var _currentY : int = -1;
		
		private var _totalYMovement : int = 0;
		private var _totalXMovement : int = 0;
		
		public function RotateCommand(graphics3d : Graphics3d, mouseModel : MouseInfo, toolModel : DrawDataModel)
		{
			_g3d = graphics3d;
			_mouseModel = mouseModel;
			_toolModel = toolModel;
		}

		
		public function onMouseDown(e:MouseEvent):void
		{
			_currentX = e.stageX;
			_currentY = e.stageY;
		}
		
		public function onEnterFrame(e:Event):void
		{
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			dispatchEvent(new DrawCommandEvent(DrawCommandEvent.COMMAND_COMPLETE));
		}
		
		public function onMouseMove(e:MouseEvent) : void
		{
			var movedX : int = e.stageX - _currentX;
			var movedY : int = e.stageY - _currentY;
			
			if (_mouseModel.leftButtonDown) 
			{			
				_g3d.rotateXYZ(movedY, -movedX, 0);
			}

			_currentX = e.stageX;
			_currentY = e.stageY;
		}
		
		public function undo():void
		{
		}

		public function get isSavedInHistory() : Boolean
		{
			return false;
		}
	}
	
}
