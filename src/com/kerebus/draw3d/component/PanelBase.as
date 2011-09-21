package com.kerebus.draw3d.component
{
	import com.kerebus.draw3d.mouse.Cursor;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Box;
	import mx.effects.Fade;

	public class PanelBase extends Box
	{
		private static var alphaFrom : Number = 0.3;
		private static var alphaTo : Number = 1.0;
		
		private var fadeEffect : Fade = new Fade();
		
		private var isPanelActive : Boolean = false;
		
		public var enableAlphaFadeOnMouseOver : Boolean = true;
		
		public function PanelBase()
		{
			super();
			this.horizontalScrollPolicy = "off";
			this.verticalScrollPolicy = "off";
			this.alpha = alphaFrom;
			
			this.setStyle("backgroundColor", "#333333");
			this.setStyle("borderThickness", 0);
			this.setStyle("cornerRadius", 25);
    		this.setStyle("borderStyle", "solid"); 
    		this.setStyle("paddingTop", 10);
			this.setStyle("paddingLeft", 10);
			this.setStyle("paddingRight", 10);
			this.setStyle("paddingBottom", 10);
	
			fadeEffect.alphaFrom = alphaFrom;
			fadeEffect.alphaTo = alphaTo;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);		
		}
		
		private var mouseDownAtOffset : Point = new Point(0,0);
	
		private function onMouseOver(e:MouseEvent) : void
		{
			if (!hitTestPoint(e.stageX, e.stageY)) {
				return;
			}
			
			if (alpha < alphaTo && !isPanelActive && enableAlphaFadeOnMouseOver) {
				fadeEffect.play([this]);
			}
			
			if (!Cursor.isCustomCursorHidden()) {
				Cursor.hideCustomCursor();
			}
						
			isPanelActive = true;
		}
		
		private function onMouseOut(e:MouseEvent) : void 
		{
			if (hitTestPoint(e.stageX, e.stageY)) {
				return;
			}
			
			if (Cursor.isCustomCursorHidden()) {
				Cursor.restoreCustomCursor();
			}
						
			if (alpha > alphaFrom && isPanelActive && enableAlphaFadeOnMouseOver) {
				this.fadeEffect.play([this], true);
			}
			
			isPanelActive = false;	
		}
		
		private function onAddedToStage(e:Event) : void 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);	
		}
		
		private function stage_onMouseDown(e:MouseEvent) : void 
		{
			if (!this.hitTestPoint(e.stageX, e.stageY)) {
				return;
			}

			var clickedChildren : Boolean = false;
			
			getChildren().forEach(function(child:DisplayObject, idx:String, arr:Array) : void { 
				clickedChildren = clickedChildren || child.hitTestPoint(e.stageX, e.stageY);
			});
			
			if (clickedChildren) {
				return;
			}

			mouseDownAtOffset.x = e.stageX - x;
			mouseDownAtOffset.y = e.stageY - y;
			
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		}
		
		private function stage_onMouseUp(e:MouseEvent) : void 
		{
		
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
		}
		
		private function stage_onMouseMove(e:MouseEvent) : void 
		{
			var newX : int = e.stageX - mouseDownAtOffset.x;
			var newY : int = e.stageY - mouseDownAtOffset.y;
			
			if ((newX + width) > stage.width)
				newX = stage.width - width;
			
			if (newX < 0)
				newX = 0;
				
			if ((newY + height) > stage.height)
				newY = stage.height - height;
			
			if (newY < 0)
				newY = 0;
				 
			move(newX, newY);			
		}

		
	}
}