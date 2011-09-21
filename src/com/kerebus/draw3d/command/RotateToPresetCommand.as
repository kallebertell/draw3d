package com.kerebus.draw3d.command
{
	import com.kerebus.draw3d.engine.Graphics3d;
	import com.kerebus.draw3d.event.Draw3dEvent;

	public class RotateToPresetCommand extends DrawCommandBase
	{
		private var _g3d : Graphics3d;
		
		public function RotateToPresetCommand(graphics3d : Graphics3d)
		{
			_g3d = graphics3d;
		}

		public function execute(event:Draw3dEvent):void
		{			
			_g3d.undoAllRotations();
			
			if (event.type == "rotateToBack") {
				_g3d.rotateXYZ(0, 180, 0);
			}
			
		}	
		

		public function get isSavedInHistory() : Boolean
		{
			return false;
		}
	}
}