package FlxerGallery.comp {
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;

	import FlxerGallery.main.DrawerFunc;
	
	public class ButtonSelector extends Sprite {
		var w:Number;
		var h:Number;
		var fnz:Function;
		var param;
		var src:String;
		var tipo:String;
		///////
		var puls:Sprite;
		var imm:Sprite;
		var myMask;
		var col;
		//
		public function ButtonSelector(xx, yy, f, p, t, s) {
			fnz = f;
			param = p;
			tipo = t;
			src = s;
			w = Preferences.pref.tw;
			h = Preferences.pref.th;
			x = xx;
			y = yy;
			col = Preferences.pref.playerColors.colorBkgOver;
			this.puls = new Sprite();
			DrawerFunc.drawer(this.puls, 0, 0, w, h, col, null, 1);
			this.addChild(puls);
			this.myMask = new Sprite();
			this.imm = new Sprite();
			imm.x = myMask.x = w/2;
			imm.y = myMask.y = h/2;
			this.addChild(imm);
			this.addChild(myMask);
			var rett = new Sprite();
			DrawerFunc.drawer(rett, -w/2, -h/2, w, h, col, null, 1);
			this.myMask.addChild(rett);
			//
			var immLoader = new Loader();
			immLoader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			immLoader.load(new URLRequest(src));
			
			immLoader.x = -w/2
			immLoader.y = -h/2
			this.imm.addChild(immLoader);
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.mouseChildren = false;
			this.buttonMode=true;
			if (tipo == "flv" || tipo == "mp3" || tipo == "swf") {
				var tmp;
				if (tipo == "flv") {
					tmp = "VIDEO";
				} else if (tipo == "swf") {
					tmp = "FLASH MOVIE";
				} else {
					tmp = "AUDIO";
				}
				//_root.myDrawerFunc.drawer(this, "fondino", 5, h-24, w-10, 19, 0xFFFFFF, null, 50);
				//_root.myDrawerFunc.textDrawerSP(this, "tipoTxt", "<p class=\"typeLabel\">"+tmp+"</p>", 10, h-25, w-20, 19, true);
				//this.tipoTxt.alpha = 100;
			}
		}
		function mouseDownHandler(e) {
			fnz(param);
			//_root.bip.play();
			mouseOutHandler(e);
		}
		function mouseOverHandler(e) {
			imm.scaleX = myMask.scaleX = .92;
			imm.scaleY = myMask.scaleY = .892;
			/*_root.bip.play();
			if (parent.parent.home.childNodes[0].childNodes[param+parent.thumbPage].childNodes[1] != undefined) {
				var tmp = {x:this.x+(w/2), y:this.y+(h/2)};
				this.localToGlobal(tmp);
				trace(parent.parent.home.childNodes[0].childNodes[param+parent.thumbPage].childNodes[1])
				_root.altPlayer.avvia(parent.parent.home.childNodes[0].childNodes[param+parent.thumbPage].childNodes[1], tmp);
			}*/
		}
		function mouseOutHandler(e) {
			//_root.altPlayer.stoppa()
			imm.scaleX = myMask.scaleX = imm.scaleY = myMask.scaleY = 1;
		}
		function resizza(tt) {
			tt.width = w;
			tt.height = h;
			if ((tt.scaleX/tt.scaleY)>(w/h)) {
				tt.scaleX = tt.scaleY;
			} else {
				tt.scaleY = tt.scaleX;
			}
		}
		function initHandler(t) {
			resizza(imm.getChildAt(0));
			this.addChild(myMask);
			this.imm.mask =this.myMask;
		}
	}
}
