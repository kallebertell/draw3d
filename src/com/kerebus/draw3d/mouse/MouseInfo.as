package com.kerebus.draw3d.mouse
{
	import flash.events.EventDispatcher;
	
	
	/**
	 * A mediator / info class for the mouse.
	 * Clients of this class can either just use the properties for up-to-date info about the mouse
	 * or listen to actual mouse events through it.
	 */
	[Bindable]
	public class MouseInfo extends EventDispatcher
	{	
		public var stageX : int = -1;
		public var stageY : int = -1;
		
		public var leftButtonDown : Boolean = false;
	}
}