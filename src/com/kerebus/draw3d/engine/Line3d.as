package com.kerebus.draw3d.engine
{
	import flash.geom.Point;
	

	public class Line3d  
	{
		public var lineStyle : LineStyleData;
		public var startPoint : Point3d;
		public var endPoint : Point3d;
		public var midpoint : Point3d;
		public var adjustedColor : int = -1;
		
		public function Line3d(startPoint : Point3d, endPoint : Point3d, midPoint : Point3d, lineStyle : LineStyleData) 
		{
			this.startPoint = startPoint;
			this.endPoint = endPoint;
			this.lineStyle = lineStyle;			
			this.midpoint = midPoint;
			
			this.startPoint.linesIamAnParticipantIn.push(this);
			this.endPoint.linesIamAnParticipantIn.push(this);
			this.midpoint.linesIamAnParticipantIn.push(this);
		}
		
		public function get lineWidth() : int {
			return lineStyle.thickness;
		}
	}
}
