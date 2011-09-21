package com.kerebus.draw3d.mouse
{
	import com.kerebus.draw3d.mouse.MouseInfo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.Application;
	
	/**
	 * Responsible for observing the mouse and updating the MouseInfo instance 
	 * with the most recent observations
	 */
	public class MouseObserver
	{
		private var _application : Application;
		private var _mouseInfo : MouseInfo;
		
		public function MouseObserver(application : Application, mouseInfo : MouseInfo)
		{
			_application = application;
			_mouseInfo = mouseInfo;
			
			if (_application.stage == null) {
				throw new Error("Given application has not been added to stage yet.");
			}
			
			if (_mouseInfo == null) {
				throw new Error("Received MouseInfo was null");
			}
			
			_application.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_application.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_application.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_application.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			_mouseInfo.stageX = _application.stage.mouseX;
			_mouseInfo.stageY = _application.stage.mouseY;
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_mouseInfo.stageX = e.stageX;
			_mouseInfo.stageY = e.stageY;
			_mouseInfo.leftButtonDown = true;
			
			_mouseInfo.dispatchEvent(e);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			_mouseInfo.stageX = e.stageX;
			_mouseInfo.stageY = e.stageY;
			_mouseInfo.leftButtonDown = false;
			
			_mouseInfo.dispatchEvent(e);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			_mouseInfo.stageX = e.stageX;
			_mouseInfo.stageY = e.stageY;
			
			_mouseInfo.dispatchEvent(e);
		}

	}
}