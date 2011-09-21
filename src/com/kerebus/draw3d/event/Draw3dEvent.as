package com.kerebus.draw3d.event
{
	import flash.events.Event;

	public class Draw3dEvent extends Event
	{
		public function Draw3dEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, payload : Object=null)
		{			
			super(type, bubbles, cancelable);
			this.payload = payload;
		}

		public var payload : Object;		
	}
}