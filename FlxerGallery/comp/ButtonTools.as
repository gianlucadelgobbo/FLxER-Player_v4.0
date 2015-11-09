package FlxerGallery.comp {
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import StarterGallery;
	public class ButtonTools extends MovieClip {
		var txt:String;
		var fnz:Function;
		var fnzOut:Function;
		var param;
		///////
		public var lab;
		public var simb;
		public var puls:MovieClip;
		public var pulsInt:MovieClip;
		var deltaT
		var trgt;
		//
		public function ButtonTools() {
			trace("ButtonTools")
		}
		public function avvia(obj) {
			if (obj.txt != undefined) {
				/* STANDARD 
				var deltaT =  4*/
				/* NGA FONT */
				this.lab.text = obj.txt;
				deltaT = 5;
				this.lab.width = int(this.lab.textWidth+deltaT);
				this.puls.width = int(this.lab.width);
				this.pulsInt.width = int(this.puls.width-2);
			}
			fnz = obj.fnz;
			if (obj.fnzOut != undefined) {
				fnzOut = obj.fnzOut;
				this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			}
			if (obj.simb == true) {
				trgt = this.simb;
			} else {
				trgt = this.puls;
			}
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.buttonMode=true;
		}
		function mouseDownHandler(e) {
			fnz(this);
			mouseOutHandler(e);
		};
		function mouseUpHandler(e) {
			fnzOut(this);
			mouseOutHandler(e);
		};
		function mouseOverHandler(e) {
			var myCol:ColorTransform = trgt.transform.colorTransform;
			myCol.color = Preferences.pref.toolsColors.colorBkgOver;
			trgt.transform.colorTransform = myCol;
			/*
			if (this.parent.alt) {
				_root.altPlayer.avvia(this.parent.alt);
			}*/
		};
		function mouseOutHandler(e) {
			var myCol:ColorTransform = trgt.transform.colorTransform;
			myCol.color = Preferences.pref.toolsColors.colorBkg;
			trgt.transform.colorTransform = myCol;
			//_root.altPlayer.stoppa();
		};
	}
}
