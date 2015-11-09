package {
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.text.Font;
	public class Preferences {
		public static var pref;
		public function Preferences() {
		}
		public static function createPref(w,h) {
			var embeddedFontsArray:Array = Font.enumerateFonts(false);
			pref = new Object();
			pref.x = 0;
			pref.y = 0;
			pref.tw = 128;
			pref.th = 96;
			pref.standAlone = true;
			pref.thumbSaver = true;
			pref.toolbar = true;
			pref.autostop = false;
			pref.myLoop = true;
			pref.resizza_onoff = true;
			pref.centra_onoff = true;
			pref.ss_time = 3000;
			pref.info = false;
			pref.swfW = 400;
			pref.swfH = 300;
			// AUTO //
			pref.w = w;
			pref.h = h;
			pref.single = true;
			pref.noImg=true;
			pref.firstIsImg=false;

			// STILI
			pref.playerColors = new Object();
			pref.playerColors.colorBkg = 0x000000;
			pref.playerColors.colorBkg2 = 0x000000;
			pref.playerColors.colorBkgOver = 0x4C657A;
			pref.playerColors.colorBkgPlayer = 0x6D6D6D;
			pref.playerColors.colorBkgPlayerFoto = 0x4C657A;
			pref.toolsColors = new Object();
			pref.toolsColors.colorBkg = 0x000000;
			pref.toolsColors.colorBkg2 = 0x000000;
			pref.toolsColors.colorBkgOver = 0x4C657A;
			/// MENU ///
			pref.testo = new Object();
			pref.testo.colorBorder = 0xFFFFFF;
			pref.testo.colorBkg = 0x000000;
			pref.testo.colorBkgOver = 0xFF0000;
			//
			pref.styles = new StyleSheet();
			pref.styles.setStyle(".playerMenu",{fontFamily:'Verdana', fontSize:'10px', color:'#FFFFFF', marginLeft:'3px'});
			pref.styles.setStyle(".typeLabel",{fontFamily:'myFont', fontSize:'8px', color:'#FFFFFF', marginLeft:'3px'});
			pref.styles.setStyle("a:link",{color:'#FFFFFF'});
			pref.styles.setStyle("a:visited",{color:'#FFFFFF'});
			pref.styles.setStyle("a:active",{color:'#FFFFFF'});
			pref.styles.setStyle("a:hover",{color:'#FF0000'});
			pref.styles.setStyle("div",{color:'#999999'});
			pref.ts = new TextFormat();
			with (pref.ts) {
				font = embeddedFontsArray[0].fontName;
				size = 8;
				color = 0x000000;
				leading = -2;
				leftMargin = 1;
				rightMargin = 0;
			}
		}
	}
}