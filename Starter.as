package {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	

	import FlxerGallery.core.FlxerGallery;
	
	public class Starter extends MovieClip {
		var myFlxerGallery;
		var cnt
		var myLoader
		public var home;
		public function Starter() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE,galleryResizer);
			
			Preferences.createPref(stage.stageWidth,stage.stageHeight)

			this.myFlxerGallery  = new FlxerGallery();
			this.addChild(myFlxerGallery)
			this.avviaJs();
		}
		public function galleryResizer(w,h) {
			/*this["mySuperPlayer"].setPos(w,h);
			this["myToolbar"].setPos(w,h);
			if (! single) {
				this["mySelector"].setPos(w,h);
			}*/
		}
		public function avviaJs() {
			// TEST LOCALE
			cnt = root.loaderInfo.parameters.cnt
			if (!cnt) {
				// solo video
				cnt = "http://dev.flxer.net/_fp/fpGallery.php?id=p6150";
				// multifoto
				cnt = "http://dev.gentecult.it/_fp/fpGallery.php?id=p140";
				// multifoto + video
				cnt = "http://dev.flxer.net/_fp/fpGallery.php?id=p6090";
			}
			updatePref(cnt)
			//getURL("javascript:alert('"+cnt+"');")
			var tmp = cnt.split(",");
			var tmp2 = tmp[0].substring(tmp[0].length-3, tmp[0].length).toLowerCase();
			if (tmp2 == "flv" || tmp2 == "mp3" || tmp2 == "swf" || tmp2 == "jpg" || tmp2 == "png" || tmp2 == "gif") {
				var tmpXml = new XMLDocument("<ul><li><a>"+tmp[0]+"</a><tit>"+tmp[1]+"</tit></li></ul>");
				if (tmp[2]) {
					this.myFlxerGallery.mySuperPlayer.myPlayer.addEventListener(MouseEvent.MOUSE_DOWN, navigateToURL(new URLRequest(Preferences.pref.myPath+Preferences.pref.myUserPath+tmp[2]),"_self"));
				}
				this.myFlxerGallery.avvia(tmpXml);
			} else {
				/*if (tmp.indexOf("http://") != -1) {
					_root.myPath = _root.mySitePath;
				}
				var tmp = myReplace(cnt, ",", "&");
				if (tmp.indexOf("http://") == -1) {
					tmp = _root.myPath+tmp;
				}*/
				myLoader = new URLLoader(new URLRequest(cnt));
				myLoader.addEventListener("complete", avviaMyFlxerGallery);
				myLoader.addEventListener("ioError", avviaMyFlxerGallery);
				home = new XMLDocument();
				home.ignoreWhite = true;
			}
		}
		// PREFERENZE
		function updatePref(cnt) {
			Preferences.pref.startUrl = cnt;
			var myPath = cnt.substring(0, cnt.indexOf("/", 7))
			Preferences.pref.myPath = myPath;
			Preferences.pref.myUserPath = myPath+"/abusers/?id=";
			Preferences.pref.myFsPath = myPath+"/_fp/fpFullscreen.php?cnt=";
			Preferences.pref.downPath = myPath+"/_fp/fpDownload.php?file=";
			Preferences.pref.myViPath = myPath+"/_fp/fpSetViewed.php?file=";
			Preferences.pref.embePath = myPath+"/_fp/flxerPlayer4.swf?cnt=";
		}
		function avviaMyFlxerGallery(event) {
			home.parseXML(myLoader.data);
			if (event.type == "complete") {
				for (var a = 0; a<home.childNodes[0].childNodes.length; a++) {
					home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].nodeValue = Preferences.pref.myPath+home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();
					home.childNodes[0].childNodes[a].childNodes[2].childNodes[0].nodeValue = Preferences.pref.myPath+home.childNodes[0].childNodes[a].childNodes[2].childNodes[0].toString();
				}
				this.myFlxerGallery.avvia();
			} else {
				trace("xmlLoadError");
			}
		}
		public function myReplace(str, search, replace) {
			var temparray = str.split(search);
			str = temparray.join(replace);
			return str;
		}
	}
}