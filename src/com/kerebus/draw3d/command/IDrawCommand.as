package com.kerebus.draw3d.command
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public interface IDrawCommand extends IEventDispatcher
	{
		function onEnterFrame(e:Event) : void;
		
		function onMouseDown(e:MouseEvent) : void;
		function onMouseUp(e:MouseEvent) : void;
		function onMouseMove(e:MouseEvent) : void;
		function get isSavedInHistory() : Boolean;
		function undo() : void;
	}
}