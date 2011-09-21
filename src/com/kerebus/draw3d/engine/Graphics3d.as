package com.kerebus.draw3d.engine 
{

	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;


	public class Graphics3d extends Sprite 
	{

		private var points : Array; 
		private var lines : Array; 
		
		private var currentLineStyle : LineStyleData; 
		private var currentPointIndex : int;

		private var rotationHistory : RotationHistory;

		/**
		 * I imagine we'll have some sort of camera in the future. For now this point will represent it.
		 */
		public var camera : Point3d = new Point3d(0, 0, 750);
		
		public function Graphics3d(target : DisplayObjectContainer, camera : Point3d)
		{
			target.addChild(this);
			this.camera = camera;
			// auto centre this - we probably want to change this sometime soon! 
			// TODO make this independent so we can move the container around
			x =  (stage.stageWidth/2);// / stage.scaleX ;
			y =  (stage.stageHeight/2);// / stage.scaleY;
			
			
			this.addEventListener(Event.ENTER_FRAME, enterFrame); 
			
			clear(); 
		}

		public function lineStyle(thickness : Number = 10, colour : int = 0x000000, alpha : Number = 1) : void
		{
			if (	thickness != currentLineStyle.thickness 
				||	colour != currentLineStyle.colour 
				||	alpha != currentLineStyle.alpha) 
			{
				currentLineStyle = new LineStyleData(thickness, colour, alpha);		
			} 
		}

		public function moveTo(posx : Number, posy : Number, posz : Number) : void
		{
			currentPointIndex = addPoint(posx, posy, posz);
		}
		
		public function lineTo(posx : Number, posy : Number, posz : Number) : void
		{
			var pointIndex : int = addPoint(posx, posy, posz);
			
			var midpointIndex : int = addPoint(
			 			  (points[currentPointIndex].x + posx) / 2, 
						  (points[currentPointIndex].y + posy) / 2, 
						  (points[currentPointIndex].z + posz) / 2);
											
			lines.push(new Line3d(points[currentPointIndex], points[pointIndex], points[midpointIndex], currentLineStyle));
			currentPointIndex = pointIndex; 
		}


		public function moveTo2D(x2d : Number, y2d : Number, z3d : Number) : void
		{
			currentPointIndex = addPoint2D(x2d, y2d, z3d);
		}

		public function lineTo2D(x2d : Number, y2d : Number, z3d : Number) : Line3d
		{
			var pointindex : int = addPoint2D(x2d, y2d, z3d); 
			var midpointIndex : int = addPoint(
			 			  (points[currentPointIndex].x + points[pointindex].x) / 2, 
						  (points[currentPointIndex].y + points[pointindex].y) / 2, 
						  (points[currentPointIndex].z + points[pointindex].z) / 2);
	
			var newLine : Line3d = new Line3d(points[currentPointIndex], points[pointindex], points[midpointIndex], currentLineStyle);
			updateCalculatedValuesOfLine(newLine);
			lines.push(newLine);

			currentPointIndex = pointindex; 
			return newLine;
		}
	
		public function segmentedLineTo2D(x2d : Number, y2d : Number, z3d : Number) : Array
		{
			var endPointIndex : int = addPoint2D(x2d, y2d, z3d); 
			
			var distance : Number = getDistanceBetweenPoints(points[endPointIndex], currentPoint);
			
			var segments : int = distance / 30;
			
			var newLines : Array = [];
			trace("New line will be split into "+segments+" segments");
			
			var unitX : Number = (Point3d(points[endPointIndex]).x - currentPoint.x) / distance;
			var unitY : Number = (Point3d(points[endPointIndex]).y - currentPoint.y) / distance;
			var unitZ : Number = (Point3d(points[endPointIndex]).z - currentPoint.z) / distance;
			
			for (var i : int = 0; i<segments; i++) 
			{
				var pointIndex : int = addPoint(currentPoint.x + (unitX * 30), currentPoint.y + (unitY * 30), currentPoint.z + (unitZ * 30));
					
				var midpointIndex : int = addPoint(
				 			  (points[currentPointIndex].x + points[pointIndex].x) / 2, 
							  (points[currentPointIndex].y + points[pointIndex].y) / 2, 
							  (points[currentPointIndex].z + points[pointIndex].z) / 2);
		
				newLines.push(new Line3d(points[currentPointIndex], points[pointIndex], points[midpointIndex], currentLineStyle));		
				currentPointIndex = pointIndex;
			}			

			midpointIndex = addPoint(
					 			  (points[currentPointIndex].x + points[endPointIndex].x) / 2, 
								  (points[currentPointIndex].y + points[endPointIndex].y) / 2, 
								  (points[currentPointIndex].z + points[endPointIndex].z) / 2);
			
			newLines.push(new Line3d(points[currentPointIndex], points[endPointIndex], points[midpointIndex], currentLineStyle));
			lines = lines.concat(newLines);
 			currentPointIndex = endPointIndex;
 			
 			return newLines;
		}

		public function drawPlane(xpos : Number, ypos : Number, zpos : Number, width : Number, height : Number) : void
		{
			var hw : Number = width*0.5; 
			var hh : Number = height*0.5; 
			
			moveTo(xpos - hw, ypos - hh, zpos);
			lineTo(xpos + hw, ypos - hh, zpos);
			lineTo(xpos + hw, ypos + hh, zpos);
			lineTo(xpos - hw, ypos + hh, zpos);
			lineTo(xpos - hw, ypos - hh, zpos);
			moveTo(xpos - hw, ypos - hh, zpos);
			lineTo(xpos + hw, ypos + hh, zpos);
			moveTo(xpos + hw, ypos - hh, zpos);
			lineTo(xpos - hw, ypos + hh, zpos);
		}			

		private var lastSortTimestamp : Number = -1;
		
		public function enterFrame(e : Event) : void
		{
			var g : Graphics = graphics; 
			var ls : LineStyleData;
			var p1 : Point3d; 
			var p2 : Point3d; 
			
			g.clear(); 

			for each (var point : Point3d in points)
			{
				point.updateCalculatedValues(); 
			}

			var timestamp : Number = new Date().getTime();
			
			if (timestamp - lastSortTimestamp > 500) 
			{ 
				updateCalculatedValuesOfLines();
				lines.sort(sort_byDistance);
				lastSortTimestamp = timestamp;
			}

			for each (var line : Line3d in lines)
			{
				ls = line.lineStyle; 

				g.lineStyle(ls.thickness, (_shading ? line.adjustedColor : ls.colour), ls.alpha);	
				p1 = line.startPoint;
				p2 = line.endPoint;
				g.moveTo(p1.x2d, p1.y2d);
				g.lineTo(p2.x2d, p2.y2d);
			}
		}


		public function clear() : void
		{
			points = new Array(); 
			addPoint(0, 0, 0);
			lines = new Array(); 
			currentLineStyle = new LineStyleData(); 
			currentPointIndex = 0; 
			rotationHistory = new RotationHistory();
		}

		private function addPoint(posx : Number, posy : Number, posz : Number) : int
		{
			// TODO add check for whether point already exists
			
			points.push(new Point3d(posx, posy, posz)); 
			return points.length - 1; 
		}
		
		private function addPoint2D(x2d : Number, y2d : Number, z3d : Number) : int
		{
			x2d -= x; 
			y2d -= y;
		
			var fov : Number = Point3d.fov; 
			return addPoint(x2d/(fov/(fov + z3d)), y2d/(fov/(fov + z3d)), z3d);
		}
		
		public function rotateXYZ(rotX : Number, rotY : Number, rotZ : Number) : void
		{
			for each(var point : Point3d in points)
			{
				if (rotX != 0) point.rotateX(rotX); 
				if (rotY != 0) point.rotateY(rotY);
				if (rotZ != 0) point.rotateZ(rotZ);
			}
			
			if (rotX != 0 || rotY != 0 || rotZ != 0)
				rotationHistory.addRotation(rotX, rotY, rotZ);
		}
		
		public function rotateZYX(rotZ : Number, rotY : Number, rotX : Number) : void
		{
			for each(var point : Point3d in points)
			{
				if (rotZ != 0) point.rotateZ(rotZ);
				if (rotY != 0) point.rotateY(rotY);
				if (rotX != 0) point.rotateX(rotX); 
			}			
		}
		
		/**
		 * Resets rotation history so the current scene will be considered
		 * the "FRONT"
		 */
		public function markRotationBaseline() : void 
		{
			rotationHistory = new RotationHistory();
		}
		
		public function undoAllRotations() : void 
		{
			rotationHistory.undoRotations(this);			
		}
		
		private function updateCalculatedValuesOfLines() : void 
		{
			for each (var line:Line3d in lines) {				
				line.midpoint.relativeDistanceToCam = getRelativeDistanceBetweenPoints(line.midpoint, camera);
				line.adjustedColor = ColorTool.adjustColor(line.lineStyle.colour, line.midpoint.relativeDistanceToCam / 700000); 
			}
		}
		
		private function updateCalculatedValuesOfLine(line:Line3d) : void
		{
			line.midpoint.relativeDistanceToCam = getRelativeDistanceBetweenPoints(line.midpoint, camera);
			
			if (_shading) {
				line.adjustedColor = ColorTool.adjustColor(line.lineStyle.colour, line.midpoint.relativeDistanceToCam / 700000);	
			} 
		}
		
		private function sort_byDistance(first:Line3d, second:Line3d):Number 
		{				 
			if (first.midpoint.relativeDistanceToCam > second.midpoint.relativeDistanceToCam)
				return 1;
			else if (first.midpoint.relativeDistanceToCam < second.midpoint.relativeDistanceToCam)
				return -1;
			else 
			    return 0;
		}
		
		private function getRelativeDistanceBetweenPoints(first:Point3d, second:Point3d) : Number 
		{
			var xd : Number = second.x - first.x;
			var yd : Number = second.y - first.y;
			var zd : Number = second.z - first.z;
			
			return xd*xd + yd*yd + zd*zd; 
		}
		
		private function getDistanceBetweenPoints(first:Point3d, second:Point3d) : Number 
		{
			var xd : Number = second.x - first.x;
			var yd : Number = second.y - first.y;
			var zd : Number = second.z - first.z;
			
			return Math.sqrt(xd*xd) + Math.sqrt(yd*yd) + Math.sqrt(zd*zd); 
		}
		
		
		public function get currentPoint() : Point3d 
		{
			return points[ currentPointIndex ];
		}
		

		public function removeLine(line : Line3d) : void
		{
			//removePoint(line.startPoint);
			removePoint(line.endPoint);
			removePoint(line.midpoint);
			lines.splice(lines.indexOf(line), 1);
		}
		
		public function removeLines(linesToRemove : Array) : void
		{
			for each (var line : Line3d in linesToRemove) {
				removeLine(line);
			}
		}
		
		public function removePoint(point : Point3d) : void 
		{
			points.splice(points.indexOf(point), 1);
		}
		
		public function get pointCount() : int
		{
			return points.length;
		}
		
		public function get lineCount() : int 
		{
			return lines.length;
		}
		
		public function get rotationCount() : int 
		{
			return rotationHistory.rotationCount;
		}
		
		/**
		 * If given 2d point hits within anothers points 2d projection this
		 * should return that point. It starts the search for a point 
		 * from those closest to the camera.
		 */ 
		public function getHitPoint(x2d : Number, y2d : Number) : Point3d 
		{
			x2d -= x; 
			y2d -= y;
		
			var foundPoint : Point3d = null;
			
			for each (var point : Point3d in points) {
				if (point.x2d < (x2d+15) && point.x2d > (x2d-15)
					&& point.y2d < (y2d+15) && point.y2d > (y2d-15)) {
						
						if (foundPoint == null)
							foundPoint = point;
							
						if (point.z < foundPoint.z)
							foundPoint = point; 
					}
			}
			
			return foundPoint;
		}
		
		public function get startPoint () : Point3d {
			return points[0];
		}
		
		private var _shading : Boolean = true;
		public function set shading (value : Boolean) : void {
			_shading = value;
		}
		public function get shading () : Boolean {
			return _shading;
		}
	}
}
