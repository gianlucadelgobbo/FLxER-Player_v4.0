package FlxerGallery.core {
	import flash.display.Sprite;
	
	import FlxerGallery.comp.ButtonSelector;
	public class FlxerSelector extends Sprite {
		var w:Number;
		var h:Number;
		var tw:Number;
		var th:Number;
		/*
		var lista:XML;
		var thumbNx;
		var thumbNy;
		var resizza_onoff;
		var noImg
		*/
		var puls0;
		var puls1;
		var puls2;
		var puls3;
		var puls4;
		var puls5;
		var puls6;
		var puls7;
		var puls8;
		var puls9;
//
		var testaH;
		var piedeH;
		var thumbPage;
		var pageDn;
		var pageUp;
		function setPos(ww, hh) {
			w = ww;
			h = hh;
			thumbPage = 0;
			for (var a = 0; a<thumbNx*thumbNy; a++) {
				this["puls"+a].removeSprite();
			}
			thumbDrawer(w, h, Preferences.pref.tw, Preferences.pref.th);
		}
		function FlxerSelector(t, p, h) {
			thumbPage = 0
			home = h
			testaH = t;
			piedeH = p;
			this.y = testaH;
			thumbDrawer(Preferences.pref.w, Preferences.pref.h, Preferences.pref.tw, Preferences.pref.th);
		}
		function thumbDrawer(w, h, tw, th) {
			h = h-(testaH+piedeH);
			var contaX = 0;
			var contaY = 0;
			thumbNx = int(w/tw);
			thumbNy = int(h/th);
			var marginX = (w-(thumbNx*tw))/(thumbNx-1);
			var marginY = (h-(thumbNy*th))/(thumbNy-1);
			for (var a=0; a<thumbNx*thumbNy; a++) {
				trace("FlxerSelector "+home.childNodes[0].childNodes.length);
				if (a<home.childNodes[0].childNodes.length) {
					trace("FlxerSelector "+a);
					var myX = (tw+marginX)*contaX;
					var myY = (th+marginY)*contaY;
						var tmp = home.childNodes[0].childNodes[a+thumbPage].childNodes[0].childNodes[0].toString();
						var tipo = tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();
						this["puls"+a] = new ButtonSelector(myX, myY, myOnPress, a, tipo, home.childNodes[0].childNodes[a+thumbPage].childNodes[2].childNodes[0].toString());
						this.addChild(this["puls"+a]);
						//_root.myClassedMC(flxerGallery.ButtonSelector, this, "puls"+a, {x:myX, y:myY, w:tw, h:th, fnzTrgt:this, fnz:"myOnPress", fnzOver:"myOnOver", param:a, src:parent.home.childNodes[a+thumbPage].childNodes[2].childNodes[0].toString(), tipo:tipo});
					contaX++;
					if (contaX == thumbNx) {
						contaX = 0;
						contaY++;
					}
					if (contaY == thumbNy+1) {
						contaY = 0;
					}
				}
			}
			/*if (thumbPage>0) {
				if (this["pageDn"]) {
					this["pageDn"].x = 45;
					this["pageDn"].y = int((h-33)/2)+33;
				} else {
					this.attachMovie("fw_rw", "pageDn", this.getNextHighestDepth(), {_x:45, _y:int((h-33)/2)+33, _xscale:300, _yscale:300, _rotation:180, _alpha:70});
					this["pageDn"].onPress = function() {
						this.parent.pager(-1);
					};
				}
			} else {
				this["pageDn"].removeSprite();
			}
			if (thumbPage+(thumbNx*thumbNy)<parent.home.childNodes.length) {
				if (this["pageUp"]) {
					this["pageUp"].x = w-45;
					this["pageUp"].y = int((h-33)/2);
				} else {
					this.attachMovie("fw_rw", "pageUp", this.getNextHighestDepth(), {_x:w-45, _y:int((h-33)/2), _xscale:300, _yscale:300, _rotation:0, _alpha:70});
					this["pageUp"].onPress = function() {
						this.parent.pager(1);
					};
				}
			} else {
				this["pageUp"].removeSprite();
			}
			this["pageDn"].swapDepths(this.getNextHighestDepth());
			this["pageUp"].swapDepths(this.getNextHighestDepth());
			*/
			for (var b = a; this["puls"+b]; b++) {
				//this.removeChild(this["puls"+b]);
			}
		}
		function pager(a) {
			thumbPage += a*(thumbNx*thumbNy);
			for (var a = 0; a<thumbNx*thumbNy; a++) {
				this["puls"+a].removeSprite();
			}
			thumbDrawer(w, h);
		}
		function myOnPress(a) {
			trace("myOnPress")
			Preferences.pref.autostop = false;
			this.visible = false;
			this.parent.mySuperPlayer.avvia(a+thumbPage);
		}
	}
}