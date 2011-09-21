package com.kerebus.draw3d.command
{
	import com.kerebus.draw3d.event.Draw3dEvent;

	public class DrawCommandEvent extends Draw3dEvent
	{
		public static var COMMAND_COMPLETE : String = "commandComplete";
		
		public function DrawCommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, payload:Object=null)
		{
			super(type, bubbles, cancelable, payload);
		}		
	}
}