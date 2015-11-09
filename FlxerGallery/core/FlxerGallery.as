package FlxerGallery.core {
	import flash.display.Sprite;
	import flash.ui.ContextMenu;
	import flash.events.*;
	import flash.net.navigateToURL;

	import FlxerGallery.core.FlxerPlayer;
	import FlxerGallery.main.DrawerFunc;
	import FlxerGallery.core.ThumbSaver;
	import Preferences;
	public class FlxerGallery extends Sprite {
		// pref
		/*var w:Number;
		var h:Number;
		var tw:Number;
		var th:Number;
		var toolbar:Boolean;
		var autostop:Boolean;
		var myLoop:Boolean;
		var resizza_onoff:Boolean;
		var centra_onoff:Boolean;
		var ss_time:Number;
		var info:Boolean;
		//
		var lista:XML;
		var single;
		var trgt;
		var resizer;
		var flv;
		var img;
		var mp3;
		var swf;
		var owner:FlxerGallery;
		var noImg;
		var firstIsImg;
		var txt;
		var mRoot:ContextMenu;
		var mPlay:ContextMenu;
		var startUrl;*/
		//
		public var myToolbar;
		public var mySuperPlayer;
		public var mySelector;
		public var myThumbSaver;
		var testaH;
		var piedeH;
		public function FlxerGallery() {
			if (Preferences.pref.toolbar) {
				this.myToolbar = new Toolbar()
				myToolbar.avvia2();
				this.addChild(myToolbar);
				testaH = myToolbar.testa.height+1;	
				piedeH = myToolbar.piede.piedeEst.height+1
			} else {
				testaH = piedeH = 0;				
			}
			if (Preferences.pref.standAlone) {
				w = Preferences.pref.w;
				h = Preferences.pref.h;
			}
			this.mySuperPlayer = new FlxerPlayer(testaH,piedeH);
			this.addChild(mySuperPlayer);
			this.myThumbSaver = new ThumbSaver(20,20);
		}
		public function galleryResizer(w,h) {
			this.mySuperPlayer.setPos(w,h);
			this.myToolbar.setPos(w,h);
			if (!Preferences.pref.single) {
				this.mySelector.setPos(w,h);
			}
		}
		public function vaiUserURL(t) {
			navigateToURL(new URLRequest(Preferences.pref.myUserPath+parent.home.childNodes[0].attributes.page_url),"_self")
		}
		public function avvia() {
			if (!Preferences.pref.single) {
				this.removeChild(mySelector);
			}
			if (parent.home.childNodes[0].attributes.page_url) {
				this.mySuperPlayer.myPlayer.addEventListener(MouseEvent.MOUSE_DOWN, vaiUserURL);
			}
			/*if (_root.myFlxerGallery.myToolbar.ppBig) {
				this.myToolbar.ppBig.removeMovieClip();
			}*/
			trace("bella "+parent.home)
			if (parent.home.childNodes[0].childNodes.length == 1) {
				Preferences.pref.single = true;
				this.mySuperPlayer.avvia(0);
			} else {
				Preferences.pref.single = false;
				parseXml();
				this.myToolbar.avvia("selector");
				this.mySuperPlayer.resetta();
				avviaSelector();
			}
			creaContextMenu();
		}
		function parseXml() {
			var flv=0;
			var img=0;
			var mp3=0;
			var swf=0;
			var str="";
			var txt="";
			this.mySuperPlayer.visible=false;
			for (var a=0; a < parent.home.childNodes[0].childNodes.length; a++) {
				txt+= parent.home.childNodes[0].childNodes[a].childNodes[1].childNodes[0] + "\n";
				var tmp=parent.home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();
				tmp=tmp.substring(tmp.length - 3,tmp.length).toLowerCase();
				if (tmp == "flv") {
					flv++;
				} else if (tmp == "mp3") {
					mp3++;
				} else if (tmp == "swf") {
					swf++;
				} else if (tmp == "jpg" || tmp == "png" || tmp == "gif") {
					if (a == 0) {
						firstIsImg=true;
					}
					img++;
				}
			}
			if (flv > 0) {
				str+= "VIDEO[" + flv + "] ";
			}
			if (mp3 > 0) {
				str+= "AUDIO[" + mp3 + "] ";
			}
			if (swf > 0) {
				str+= "SWF[" + swf + "] ";
			}
			if (img > 0) {
				str+= "IMAGES[" + img + "] ";
			}
			this.myToolbar.mmSelTit = str
			if (img > 1) {
				Preferences.pref.noImg=false;
			}
		}
		function avviaSelector() {
			this.mySelector = new FlxerSelector(testaH, piedeH, parent.home);
			this.addChild(mySelector);
			//_root.myClassedMC(flxerGallery.mmSelector,this,"mySelector",{lista:parent.home.childNodes[0],x:0,y:0,w:w,h:h,tw:tw,th:th,noImg:noImg});
			/**/
			if (parent.home.childNodes[0].childNodes.length) {
				if (!Preferences.pref.autostop) {
					if (Preferences.pref.firstIsImg) {
						this.myToolbar.slideshow();
					} else {
						//this.mySelector.puls0.puls.onPress();
					}
				}
			}
		}
		function creaContextMenu() {
			/*mRoot=new ContextMenu  ;
			mRoot.hideBuiltInItems();
			mPlay=new ContextMenu  ;
			mPlay.hideBuiltInItems();
			if (! single) {
				mRoot.customItems.push(new ContextMenuItem("Slideshow",this.myToolbar.avviaSS));
				mPlay.customItems.push(new ContextMenuItem("Playlist",this.myToolbar.avviaSelector));
				if (noImg) {
					mRoot.customItems[0].enabled=false;
					mRoot.customItems[0].caption="Slideshow (no images)";
				}
			}
			mRoot.customItems.push(new ContextMenuItem("Scale: Fit player size",this.myToolbar.itemHandler,false,false));
			mRoot.customItems.push(new ContextMenuItem("Scale: 100%",this.myToolbar.itemHandler2,false,false));
			mRoot.customItems.push(new ContextMenuItem("Fullscreen",this.myToolbar.itemHandler3));
			mRoot.customItems.push(new ContextMenuItem("Print this content",this.myToolbar.itemHandler4));
			if (Preferences.pref.downPath) {
				mRoot.customItems.push(new ContextMenuItem("Download", this.myToolbar.itemHandler5, false, false));
			}
			mRoot.customItems.push(new ContextMenuItem("Embed",this.myToolbar.apriEmbed));
			this.parent.menu=mRoot;
			mPlay.customItems.push(new ContextMenuItem("Scale: Fit player size",this.myToolbar.itemHandler));
			mPlay.customItems.push(new ContextMenuItem("Scale: 100%",this.myToolbar.itemHandler2));
			mPlay.customItems.push(new ContextMenuItem("Fullscreen",this.myToolbar.itemHandler3));
			mPlay.customItems.push(new ContextMenuItem("Print this content",this.myToolbar.itemHandler4));
			if (Preferences.pref.downPath) {
				mPlay.customItems.push(new ContextMenuItem("Download", this.myToolbar.itemHandler5));
			}
			mPlay.customItems.push(new ContextMenuItem("Embed",this.myToolbar.apriEmbed));
			this.mySuperPlayer.menu=mPlay;
			if (toolbar) {
				this.myToolbar.swapDepths(this.getNextHighestDepth());
			}
			*/
		}
	}
}