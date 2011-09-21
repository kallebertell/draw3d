package com.kerebus.draw3d.command
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class DoNothing extends DrawCommandBase implements IDrawCommand
	{
		public static var INSTANCE : DoNothing = new DoNothing();
		
		public function DoNothing()
		{
		}

		public function onMouseDown(e:MouseEvent) : void 
		{

		}
		
		public function onEnterFrame(e:Event) : void 
		{

		}
		
		public function onMouseUp(e:MouseEvent) : void 
		{
			
		}
		
		public function onMouseMove(e:MouseEvent) : void
		{
			
		}
		
		public function undo() : void
		{
			
		}
		
		public function get isSavedInHistory() : Boolean
		{
			return false;
		}
	}
}