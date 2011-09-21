package com.kerebus.draw3d
{
	import com.kerebus.draw3d.engine.Graphics3d;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.Application;
	
	public class KeyboardSceneRotator
	{
		private var _g3d : Graphics3d;
		
		private var rotateY : Number = 0;
		private var rotateX : Number = 0;
		private var rotateZ : Number = 0;
		
		public function KeyboardSceneRotator(g3d : Graphics3d, eventDispatcher : EventDispatcher)
		{
			_g3d = g3d;
			eventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			eventDispatcher.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		public function onEnterFrame(e : Event) : void
		{
			_g3d.rotateXYZ(rotateX*3, rotateY*3, rotateZ*3);
		}

		public function handleKeyDown(e:KeyboardEvent) : void 
		{
			removeFocus();
			
			if (isUp(e)) { 
				rotateX = -1;
			}
			
			if (isDown(e)) {
				rotateX = 1;
			}
			
			if (isLeft(e)) {
				rotateY = 1;
			}
			
			if (isRight(e)) {
				rotateY = -1;
			}
		}

		public function handleKeyUp(e:KeyboardEvent) : void 
		{
			removeFocus();
			
			if (isUp(e)) { 
				rotateX = 0;
			}
			
			if (isDown(e)) {
				rotateX = 0;
			}
			
			if (isLeft(e)) {
				rotateY = 0;
			}
			
			if (isRight(e)) {
				rotateY = 0;
			}
		}

		private function isUp(e:KeyboardEvent) : Boolean {
			return e.keyCode == Keyboard.UP || 'w' == String.fromCharCode(e.charCode);
		}
		
		private function isDown(e:KeyboardEvent) : Boolean {
			return e.keyCode == Keyboard.DOWN || 's' == String.fromCharCode(e.charCode);
		}
		
		private function isLeft(e:KeyboardEvent) : Boolean {
			return e.keyCode == Keyboard.LEFT || 'a' == String.fromCharCode(e.charCode);
		}

		private function isRight(e:KeyboardEvent) : Boolean {
			return e.keyCode == Keyboard.RIGHT || 'd' == String.fromCharCode(e.charCode);
		}
		
		public function removeFocus() : void {
			Application.application.stage.focus = null;
		}

	}
}