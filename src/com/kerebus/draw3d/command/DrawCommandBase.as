package com.kerebus.draw3d.command
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class DrawCommandBase extends EventDispatcher
	{
		public function DrawCommandBase(target:IEventDispatcher=null)
		{
			super(target);
		}
		
	}
}