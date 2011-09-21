package com.kerebus.draw3d.engine
{
	/**
	 * Responsible for knowing about all rotations done on the scene 
	 */
	public class RotationHistory
	{
		private var _history : Array = [];
		
		public function RotationHistory()
		{
		}
		
		public function addRotation(degreesX:Number, degreesY:Number, degreesZ:Number) : void 
		{
			_history.push(new Rotation(degreesX, degreesY, degreesZ) );
		}
		
		public function undoRotations(g3d : Graphics3d) : void 
		{
			for (var i:int=_history.length-1; i>=0; i--)  
			{
				var rotation : Rotation = _history[i];
				g3d.rotateZYX(0, -rotation.degreesY, -rotation.degreesX);	
			}
			
			_history = [];
		}
		
		public function get rotationCount() : int {
			return _history.length;
		}
	}
}



/**
 * Represents 1 rotation
 */
class Rotation 
{
	public function Rotation(degreesX:Number, degreesY:Number, degreesZ:Number) 
	{
		this.degreesX = degreesX;
		this.degreesY = degreesY;
		this.degreesZ = degreesZ;
	}
	
	public var degreesY : Number;
	public var degreesX : Number;
	public var degreesZ : Number;
}