package com.kerebus.draw3d.engine
{

	/**
	 * A point in 3d space.
	 */
	public class Point3d 
	{
		/**
		 * Field Of Vision. 
		 * TODO: This should come from somewhere else.
		 */
		public static var fov : Number = 750; 
		public static var DEG_TO_RAD : Number = Math.PI/180; 
		
		public var x : Number ; 
		public var y : Number ; 
		public var z : Number ; 
		
		public var linesIamAnParticipantIn : Array = [];
		
		/**
		 * Gives a "size" value for distance to cam.
		 * Not the actual distance but it will compare correctly
		 * when comparing to other points
		 */
		public var relativeDistanceToCam : Number;
		
		public var x2d : Number; 
		public var y2d : Number; 
		public var scale2d : Number ; 

		/**
		 * true if this point has been updated in such a way that its precalculated values need updating
		 */		
		private var isDirty : Boolean = true;
		
		public function Point3d(x : Number, y : Number, z : Number) 
		{
			this.x = x; 
			this.y = y; 
			this.z = z; 
		}
		
		public function updateCalculatedValues() : void 
		{
			if (!isDirty) {
				return;
			}
			
			scale2d = fov / (fov + z); 
			x2d = x * scale2d; 
			y2d = y * scale2d; 
		}
		 
		public function rotateX(angle:Number) :void
		{
			if (angle == 0) {
				return;
			}
			
			isDirty = true;
			
			var cosRY:Number = Math.cos(angle * DEG_TO_RAD);
			var sinRY:Number = Math.sin(angle * DEG_TO_RAD);
	
			var tempY : Number = y;
			var tempZ : Number = z;
			
			y = (tempY * cosRY) - (tempZ * sinRY);
			z = (tempY * sinRY) + (tempZ * cosRY);			
		}	
	
		public function rotateY(angle:Number) :void
		{
			if (angle == 0) {
				return;
			}
			
			isDirty = true;
			
			var cosRY:Number = Math.cos(angle * DEG_TO_RAD);
			var sinRY:Number = Math.sin(angle * DEG_TO_RAD);
	
			var tempX : Number = x;
			var tempZ : Number = z;
	
			x = (tempX * cosRY) + (tempZ * sinRY);
			z = (tempX * -sinRY) + (tempZ * cosRY);
		}	
	
		public function rotateZ(angle:Number) :void
		{
			if (angle == 0) {
				return;
			}
			
			isDirty = true;
			
			var cosRY:Number = Math.cos(angle * DEG_TO_RAD);
			var sinRY:Number = Math.sin(angle * DEG_TO_RAD);
			 
			var tempX : Number = x;
			var tempY : Number = y;
		
			x = (tempX * cosRY) - (tempY * sinRY);
			y = (tempX * sinRY) + (tempY * cosRY);
		}	
		
		/*
		Removed used of accessors as an optimization
		public function get x () : Number { return _x; }; 
		public function get y () : Number { return _y; }; 
		public function get z () : Number { return _z; };
		*/ 
		
		public function getFirstLine() : Line3d {
			return linesIamAnParticipantIn[0];
		}
		
	}
}
