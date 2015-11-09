package FlxerGallery.core {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.media.Video;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	//import FLxER.comp.ButtonRett;

	public class Player extends Sprite {
		var ch;
		var w;
		var h;
		//
		var oldTipo:String;
		var fondo;
		var myVideo;
		var trgt;
		var NC:NetConnection;
		public var NS:NetStream;
		var swfSound:SoundMixer;
		var flvSound:SoundMixer;
		var mp3Sound:Sound;
		var transformSound:SoundTransform;
		var swfTrgt;
		public var myDuration:Number;
		/*var CF:Color;
		var CM:Color;
		var CFT:Object;
		var CMT:Object;
		var txtKS:TextFormat;
		var my_mcl:MovieClipLoader;
		var my_wipesl:MovieClipLoader;
		var ch:Number;
		var my_mclL:Object;
		var my_wipeslL:Object;
		var owner:Object;*/
		var myStopStatus:Boolean;
		public function Player(a, ww, hh) {
			ch = a;
			w = ww;
			h = hh;
			trace("Player"+ch)
			myStopStatus = false;
			//this.createEmptyMovieClip("effects", this.getNextHighestDepth());
			this.fondo = new Sprite();
            fondo.graphics.beginFill(0xFF00FF);
            fondo.graphics.drawRect(0, 0, w, h);
            fondo.graphics.endFill();
            //addChild(fondo);

			this.myVideo = new Video();
			myVideo.smoothing = true;
			this.NC = new NetConnection();
			NC.addEventListener(NetStatusEvent.NET_STATUS, NCHandler);
			NC.connect(null);

			this.trgt = new Loader();
			trgt.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
            trgt.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            trgt.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

			fondo.x = myVideo.x = trgt.x = -w/2;
			fondo.y = myVideo.y = trgt.y = -h/2;
			
			this.swfSound = new SoundMixer();
			/*swfChannel = swfSound.play();
			transformSound = swfChannel.soundTransform;
            transformSound.volume = 0;
            swfChannel.soundTransform = transformSound;*/
			
			this.flvSound = new SoundMixer();
			
			this.mp3Sound = new Sound();
			/*mp3Channel = mp3Sound.play();
			transformSound = mp3Channel.soundTransform;
            transformSound.volume = 0;
            mp3Channel.soundTransform = transformSound;*/
			
			mp3Sound.addEventListener(Event.COMPLETE, soundCompleteHandler);

			//
			
			/*this.txtKS = new TextFormat();
			this.txtKS.font = "myFont2";
			this.txtKS.size = 48;
			this.txtKS.color = 0x000000;
			this.txtKS.align = "center";
			_root.mdf.tdw(vid, "txt", -600, -41, 1200, 100, "");
			vid.txt.setTextFormat(this.txtKS);
			vid.txt.setNewTextFormat(this.txtKS);

			this.CM = new Color(vid);
			this.CMT = new Object();
			this.CMT.rb = 0;
			this.CMT.gb = 0;
			this.CMT.bb = 0;
			this.CM.setTransform(this.CMT);
			this.CF = new Color(this["cnt"].fondo);
			this.CFT = new Object();
			this.CFT.rb = 0;
			this.CFT.gb = 0;
			this.CFT.bb = 0;
			this.CF.setTransform(this.CFT);
			//////
			this["effects"].visible = false;
			this["effects"].channel = this;
			this["effects"].ch = ch;
			this["effects"].video = vid;
			this["effects"]["mask"] = this["mask"];
			this["effects"].channelPreview = _root.myCtrl[this.name].monitor.mon.ch_0;
			this["effects"].effectUpdate = function(trgt, param) {
				_root.monitor.mbuto((getTimer()-_root.myGlobalCtrl.myRecorder.last_time)+",effectUpdate,"+this.ch+","+trgt+","+param);
			};
			this["effects"].videoPreview = _root.myCtrl[this.name].monitor.mon.ch_0["cnt"].vid;
			this["effects"].maskPreview = _root.myCtrl[this.name].monitor.mon.ch_0["mask"];
			this["effects"].myPanel = _root.myCtrl[this.name].myEffects["effects"];*/
		}
		function soundCompleteHandler(success) {
			this.start(0, 10000);
		};
		public function connectStream() {
			NS = new NetStream(NC);
			customClient = new Object();
			customClient.onMetaData = onMetaData;
			//customClient.onCuePoint = onCuePoint;
			//customClient.onPlayStatus = onPlayStatus;
			NS.client = customClient;
			NS.addEventListener(NetStatusEvent.NET_STATUS, NSHandler);
			myVideo.attachNetStream(NS);
		}
		// FLV LOADER //
		function load_flv(myAction) {
			if (oldTipo != null) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = "flv";
			nLoadErr = 0;
			//this.NS.clip = myAction[3];
			//this.NS.clipPath = myAction[3];
			this.NS.play(myAction[3]);
			//this.attachAudio(this.NS);
			this.addChild(myVideo);
			/*flvChannel = flvSound.play();
			transformSound = flvChannel.soundTransform;
            transformSound.volume = parseInt(myAction[4]);
            flvChannel.soundTransform = transformSound;*/
		}
		public function NCHandler(event:NetStatusEvent):void {
			trace(event.info.code);
			switch (event.info.code) {
				case "NetConnection.Connect.Success" :
					connectStream();
					break;
			}
		}
		public function NSHandler(event:NetStatusEvent):void {
			trace(event.info.code);
			parent.nsOnStatus(event)
		}
		public function onMetaData(info:Object):void {
			myDuration = info.duration;
		}
		//
		function load_movie(myAction) {
			if (oldTipo != myAction[4] && oldTipo != null) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = myAction[4];
			/*
			this.my_mclL.myVolume = parseInt(myAction[5]);
			*/
			nLoadErr = 0;
			this.trgt.load(new URLRequest(myAction[3]));
		}
		function initHandler(event) {
			//var swfTrgt = MovieClip(trgt.content); 
			swfTrgt = event.target.content;
			this.addChild(this.trgt);
			parent.initHandler(event);
			parent.resizza();
			trace("initHandler "+event)
			if (myStopStatus) {
				functionSTOP();
			}
			/*swfChannel = swfSound.play();
			transformSound = swfChannel.soundTransform;
			transformSound.volume = this.myVolume;
			swfChannel.soundTransform = transformSound;
			*/
			/*if (t) {
			}
			if (parent != _level0.monitor.mon) {
				parent.parent.parent.myMovie.val.text = this.clipPath;
				parent.parent.parent.myMovie.val.textColor = 0x000000;
			}*/
		}
		function errorHandler(event) {
			trace("errorHandler "+event)
			/*if (nLoadErr<1 && FlxerStarter.myPrefSO.data.flxerPref.childNodes[0].childNodes[1].attributes.use == "true") {
				nLoadErr++;
				this.clipPath = FlxerStarter.myPrefSO.data.flxerPref.childNodes[0].childNodes[1].attributes.value+this.clip;
				my_mcl.loadClip(this.clipPath, owner["cnt"].trgt);
				if (parent != _level0.monitor.mon) {
					parent.parent.parent.myMovie.val.text = "SEARCHING ON THE NET";
					parent.parent.parent.myMovie.val.textColor = 0xFF0000;
				}
			} else if (parent != _level0.monitor.mon) {
				parent.parent.parent.myMovie.val.text = "FILE NOT FOUND";
				parent.parent.parent.myMovie.val.textColor = 0xFF0000;
			}*/
		}
		//// SEQUENCER ////
		function functionPLAY(myAction) {
			if (myStopStatus) {
				this.cacheAsBitmap = this.myStopStatus=false;
				this["functionPLAY"+oldTipo]();
			}
		}
		function functionSTOP(myAction) {
			this.cacheAsBitmap = this.myStopStatus=true;
			this["functionSTOP"+oldTipo]();
		}
		function functionREWIND(myAction) {
			this["functionREWIND"+oldTipo]();
		}
		function functionHIDE() {
			this.visible = false;
		}
		function functionSHOW() {
			this.visible = true;
		}
		function dragga(myAction) {
			this.x = myAction[3];
			this.y = myAction[4];
			vid.x = myAction[5];
			vid.y = myAction[6];
		}
		function scala(myAction) {
			vid.scaleX = myAction[3];
			vid.scaleY = myAction[4];
		}
		function ruota(myAction) {
			vid.rotation = myAction[3];
		}
		function resetta(myAction) {
			/*if (!_root["myTreDengine"].active) {
				this.x = 0;
				this.y = 0;
				this["mask"].scaleX = 100;
				this["mask"].scaleY = 100;
			}*/
			vid.x = 200;
			vid.y = 150;
			vid.rotation = 0;
			vid.scaleX = 100;
			vid.scaleY = 100;
		}
		/// LOADER //
		function preTxt() {
			if (oldTipo != null) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = "txt";
		}
		function flvReset() {
			this.NS.close();
			myVideo.video_trgt.clear();
		}
		function mp3Reset() {
			this.mp3Sound.stop();
		}
		function swfReset() {
			trgt.unloadMovie();
		}
		function txtReset() {
			vid.txt.text = "";
		}
		function load_mp3(myAction) {
			if (oldTipo != myAction[4] && oldTipo != null) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = "mp3";
			/*if (this.parent == _level0.monitor.mon) {
				this.mp3Sound.loadSound(myAction[3], false);
				//this.mp3Sound.setVolume(parseInt(myAction[5]));
			}*/
		}
		function eject() {
			if (oldTipo) {
				this[oldTipo+"Reset"]();
			}
			oldTipo = undefined;
		}
		//// MP3
		function functionREWINDmp3() {
			mp3Sound.stop();
			mp3Sound.start(0);
		}
		function scratchmp3(myAction) {
			var tmp = (((mp3Sound.duration)*(parseInt(myAction[3])/800)))/1000;
			mp3Sound.stop();
			mp3Sound.start(tmp);
		}
		function functionSTOPmp3() {
			mp3Sound.stop();
		}
		function functionPLAYmp3() {
			mp3Sound.start();
		}
		//// JPG
		function functionSTOPjpg() {
		}
		function functionPLAYjpg() {
			parent.load_foto()
		}
		//// TXT
		/*function functionREWINDtxt() {
			_root.myCtrl[this.name].myTxtEditor.currentReaderMode.myRewind(_root.myCtrl[this.name].myTxtEditor);
		}
		function functionSTOPtxt() {
			_root.myCtrl[this.name].myTxtEditor.currentReaderMode.myStop(_root.myCtrl[this.name].myTxtEditor);
		}
		function functionPLAYtxt() {
			_root.myCtrl[this.name].myTxtEditor.currentReaderMode.myPlay(_root.myCtrl[this.name].myTxtEditor);
		}*/
		//// SWF
		function functionREWINDswf() {
			//this.functionREWINDallswf(this.trgt);
			this.trgt.gotoAndPlay(1);
			var item;
			for (item in this.trgt) {
				this.trgt[item].gotoAndPlay(1);
				functionREWINDallswf(this.trgt[item]);
			}
		}
		function scratchswf(myAction) {
			//trgt.gotoAndPlay(int(((trgt.totalFrames-1)*(parseInt(myAction[3])/800))+1));
			this.trgt.gotoAndPlay(int(((this.trgt.totalFrames-1)*parseInt(myAction[3]))+1));
		}
		function functionSTOPswf() {
			this.functionSTOPPLAYswf(this.trgt, false);
		}
		function functionPLAYswf() {
			this.functionSTOPPLAYswf(this.trgt, true);
		}
		function functionREWINDallswf(trgt) {
			trgt.gotoAndPlay(1);
			var item;
			for (item in trgt) {
				trgt[item].gotoAndPlay(1);
				functionREWINDallswf(trgt[item]);
			}
		}
		function functionSTOPPLAYswf(trgt, p) {
			var act;
			if (p) {
				act = "play";
			} else {
				act = "stop";
			}
			//trgt[act]();
			var item;
					trace("bella "+trgt)
			for (item in trgt) {
					trace("bella "+item)
				if (trgt[item].totalFrames) {
					//MovieClip(trgt)[act]()
					//trgt[item][act]();
					functionSTOPPLAYswf(trgt[item], p);
				}
			}
		}
		//// FLV
		function functionREWINDflv() {
			NS.seek(0);
		}
		function scratchflv(myAction) {
			trace(myDuration+"scratchflv"+myAction[3])
			//NS.seek(int(((myDuration)*(parseInt(myAction[3])/800))));
			NS.seek(int(myDuration*parseFloat(myAction[3])));
		}
		function functionSTOPflv() {
			NS.pause();
		}
		function functionPLAYflv() {
			NS.resume();
		}
		/*function effectUpdate(myAction) {
			var tmp = "";
			for (var a = 4; a<myAction.length; a++) {
				tmp += myAction[a];
				if (a<myAction.length-1) {
					tmp += ",";
				}
			}
			eval(myAction[3]).avvia(tmp);
		}
		function changeBlend(myAction) {
			this.blendMode = myAction[3];
		}
		function placeObjectIn3D(myAction) {
			this.alpha = myAction[3];
			this.x = myAction[4];
			this.y = myAction[5];
			this.scaleX = this.scaleY=myAction[6];
			this["mask"].scaleX = this["mask"].scaleY=this["cnt"]["fondo"].scaleX=this["cnt"]["fondo"].scaleY=myAction[7];
		}
		function insertEffectMovie(myAction) {
			this["effects"].createEmptyMovieClip("e"+myAction[3], parseInt(myAction[3]));
			this["effects"]["livee"+myAction[3]] = myAction[5];
			this.my_wipeslL.errore = 0;
			this.my_wipeslL.clip = this["effects"]["e"+myAction[3]];
			this.my_wipesl.loadClip(myAction[4], this["effects"]["e"+myAction[3]]);
		}
		function removeEffectMovie(myAction) {
			this["effects"]["e"+myAction[3]].resetta();
			this["effects"]["e"+myAction[3]].removeMovieClip();
		}
		function mySwapDepth(myAction) {
			this.swapDepths(parseInt(myAction[3]));
		}
		function reset_col(myAction) {
			this.CMT.rb = 0;
			this.CMT.gb = 0;
			this.CMT.bb = 0;
			this.CFT.rb = 0;
			this.CFT.gb = 0;
			this.CFT.bb = 0;
			this.CM.setTransform(this.CMT);
			this.CF.setTransform(this.CFT);
		}
		function reset_trans(myAction) {
			trace("reset_trans");
			vid.x = 0;
			vid.y = 0;
			this.x = 0;
			this.y = 0;
			vid.scaleX = 100;
			vid.scaleY = 100;
			this.rotation = 0;
		}
		function applicaLive(myAction) {
			this[myAction[3]](["a", "b", myAction[4], myAction[5], myAction[6], myAction[7]]);
			if (!_root["myTreDengine"].active) {
				this.x = myAction[8];
				this.y = myAction[9];
				slide_wipe(["a", "b", "c", myAction[15], myAction[16]]);
			}
			vid.x = myAction[10];
			vid.y = myAction[11];
			vid.scaleX = myAction[12];
			vid.scaleY = myAction[13];
			vid.rotation = myAction[14];
			colorizing(["a", "b", "c", myAction[17], myAction[18], myAction[19], myAction[20]]);
			colorizing(["a", "b", "c", myAction[21], myAction[22], myAction[23], myAction[24]]);
			colorizing(["a", "b", "c", myAction[25], myAction[26], myAction[27], myAction[28]]);
			bkgOnOff(["a", "b", "c", myAction[29]]);
			mySwapDepth(["a", "b", "c", myAction[30]]);
			changeBlend(["a", "b", "c", myAction[31]]);
			if (myAction[32]) {
				colorizing(["a", "b", "c", myAction[32], myAction[33], myAction[34], myAction[35]]);
				colorizing(["a", "b", "c", myAction[36], myAction[37], myAction[38], myAction[39]]);
				colorizing(["a", "b", "c", myAction[40], myAction[41], myAction[42], myAction[43]]);
			}
		}
		function colorizing(myAction) {
			this[myAction[4]][myAction[5]] = myAction[6];
			this.mySetTrasform(myAction);
		}
		function mySetTrasform(myAction) {
			this[myAction[3]].setTransform(this[myAction[4]]);
		}
		function bkgOnOff(myAction) {
			if (myAction[3] == "true") {
				this["cnt"].fondo.visible = true;
			} else {
				this["cnt"].fondo.visible = false;
			}
		}
		function txtAlign(myAction) {
			this.txtKS.align = myAction[3];
			if (this.txtKS.align == "right") {
				vid.txt.x = -1000;
			} else if (this.txtKS.align == "left") {
				vid.txt.x = -200;
			} else {
				vid.txt.x = -600;
			}
			vid.txt.setTextFormat(this.txtKS);
			vid.txt.setNewTextFormat(this.txtKS);
		}
		function txtFont(myAction) {
			if (myAction[3] == "hooge 05_55") {
				this.txtKS.font = "myFont";
				vid.txt.embedFonts = true;
			} else if (myAction[3] == "standard 07_53") {
				this.txtKS.font = "myFont2";
				vid.txt.embedFonts = true;
			} else {
				this.txtKS.font = myAction[3];
				vid.txt.embedFonts = false;
			}
			vid.txt.setTextFormat(this.txtKS);
			vid.txt.setNewTextFormat(this.txtKS);
			vid.y -= 1;
		}
		function set_txt(myAction) {
			vid.txt.text = myAction[3];
			//vid.txt.setTextFormat(this.txtKS);
		}
		function set_txtArea(myAction) {
			vid.txt.width = myAction[3];
		}
		function changeWipe(myAction) {
			this["mask"].trgt2.clear();
			this.my_wipeslL.errore = 0;
			this.my_wipeslL.clip = this["mask"].trgt;
			this.my_wipesl.loadClip(myAction[3], this["mask"].trgt);
		}
		function redrawWipe(myAction) {
			this.my_wipesl.unloadClip(this["mask"].trgt);
			_root.mdf.drawer(this["mask"], "trgt2", -200, -150, 400, 300, 0xFFFF00, false, 0x000000);
		}
		function slide_wipe(myAction) {
			if (this.parent == _level0.monitor.mon) {
				this[oldTipo+"Sound"].setVolume(myAction[3]);
			}
			if (myAction[4] == "WIPE NONE (MIX)") {
				this["mask"].scaleX = 100;
				this["mask"].scaleY = 100;
				this.alpha = myAction[3];
			} else if (myAction[4] == "HORIZONTAL") {
				this["mask"].scaleX = myAction[3];
				this["mask"].scaleY = 100;
				this.alpha = 100;
			} else if (myAction[4] == "VERTICAL") {
				this["mask"].scaleX = 100;
				this["mask"].scaleY = myAction[3];
				this.alpha = 100;
			} else {
				this["mask"].scaleX = myAction[3];
				this["mask"].scaleY = myAction[3];
				this.alpha = 100;
			}
		}*/
	}
}