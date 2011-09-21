package com.kerebus.draw3d.engine
{
	public class ColorTool
	{
		
		public static function adjustColor(color : int, factor : Number) : int {
			var red : int = (color >> 16);
			var green : int = (color >> 8) & 0x00FF;
			var blue : int = color & 0x0000FF;
			
			red = adjustColorPart(red, factor); 
			green = adjustColorPart(green, factor);
			blue = adjustColorPart(blue, factor);
			
			return (red << 16) | (green << 8) | blue; 
		}

		public static function adjustColorPart(color : uint, factor : Number) : int {			
			var colorDiff : int = (255 - color) == 0 ? 1 : 255 - color;
			var relativeSize : Number = color / colorDiff;
			var inverse : Number = 255 * relativeSize / (1 + relativeSize);
			
			return Math.min((int)(inverse * factor), 255);
		}


	}
}