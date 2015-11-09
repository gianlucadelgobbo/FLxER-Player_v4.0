package FlxerGallery.core {
	import flash.display.Sprite;
	import flash.utils.*;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Shape;
	/*import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.*;
	import flash.geom.*;*/
	import FlxerGallery.main.DrawerFunc;

	public class FlxerPlayer extends Sprite {
		/*var w:Number;
		var h:Number;
		//
		var owner;
		var autostop;
		var myLoop;
		var listaSS;
		//
		var myCol;
		var lista;
		var resizza_onoff:Boolean;
		var centra_onoff:Boolean;
		var ss_time:Number;
		var info:Boolean;
		//
		var play_status:Boolean;
		//
		var mcLoaded:Boolean;
		var loadedMov:String;
		var currMov:String;
		var ssInt:Number;
		var stopper:Number;
		var autostopInt:Number;
		var volInt:Number;
		//
		var l:Number;
		var n:Number;
		//
		var Preferences.pref.tipo:String;
		var myDuration:Number;
		var swf_started:Boolean;
		var firstTime;
		var firstTime2;
		var index;
		var nsclosed;*/
		var ssInt;
		public var myloaded:Boolean;
		public var h;
		//
		var fondo;
		var myPlayer;
		var myMask;
		public function FlxerPlayer(testaH,piedeH) {
			this.y = testaH;
			//this.y = 0;
			h = Preferences.pref.h-testaH-piedeH;
			w = Preferences.pref.w
			trace("Altezza Schermo: "+h);
			trace("Larghezza Schermo: "+w);
			if (Preferences.pref.playerColors.colorBkgPlayer) {
				fondo = new Sprite();
				DrawerFunc.drawer(fondo,0,0,w,h,Preferences.pref.playerColors.colorBkgPlayer,null,1);
			} else {
				fondo = new Shape();
				fondo.graphics.beginBitmapFill(new texture(w,h));
				fondo.graphics.drawRect(0,0,w,h);
			}
			this.addChild(fondo);
			this.myPlayer = new Player(1,w,h);
			this.myPlayer.x = w/2;
			this.myPlayer.y = h/2;
			this.addChild(myPlayer);
			//if (this.parent.parent == _root) {
			this.myMask = new Sprite();
			DrawerFunc.drawer(myMask,0,0,w,h,0x000000,null,1);
			this.addChild(myMask);
			this.myPlayer.mask = myMask;
			//}
			play_status = false;
		}
		public function avvia(i) {
			this.visible = true;
			index = i;
			resetta();
			firstTime = true;
			firstTime2 = true;
			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			Preferences.pref.tipo = tmp.substring(tmp.lastIndexOf(".")+1, tmp.length).toLowerCase();
			trace("flxerPlayer "+Preferences.pref.tipo);
			this.parent.myToolbar.avvia("player");
			if (Preferences.pref.autostop && Preferences.pref.tipo != "jpg") {
				this.parent.myToolbar.visualizzappBig();
			}
			this["avvia_"+Preferences.pref.tipo](index);
		}
		function resetta() {
			this.parent.myToolbar.resetta();
			myloaded = mcLoaded=swf_started=play_status=false;
			l = 0;
			n = 0;
			clearInterval(ssInt);
			/*this.myPlayer.NS.close();
			mp3player.stop();
			this.myPlayer.mov.myMcl.unloadClip(this.myPlayer.mov.trgt);
			this.myPlayer.myFlvPlayer.myVideo.vid_flv.clear();
			for (var item in this.myPlayer) {
				if (item.indexOf("foto_") != -1 || item.indexOf("mon") != -1) {
					this.myPlayer[item].removeMovieClip();
				}
			}*/
		}
		public function mbuto(azione) {
			trace("MMmbuto"+azione);
			var myAction = azione.split(",");
			this.myPlayer[myAction[1]](myAction);
		}
		/* FLV /////////////////*/
		public function avvia_flv(index) {
			trace("avvia_flv "+parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString())
			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].toString();
			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit+": Buffering...";
			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			if (tmp.lastIndexOf("cnt=") != -1) {
				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			}
			//this.parent.myToolbar.bottoni(false);     
			currMov = tmp;
			mbuto(getTimer()+",load_flv,0,"+currMov+",0");/* ultimo zero il volume */
		}
		function nsOnMetaData(ns, obj:Object) {
			trace("onMetaData");
			myDuration = obj.duration;
		}
		function nsOnStatus(event) {
			switch (event.info.code) {
				case "NetStream.Buffer.Full" :
					if (firstTime2) {
						firstTime2 = false;
						this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;
					}
					break;
				case "NetStream.Play.Start" :
					if (firstTime) {
						this.parent.myToolbar.avvia_indice();
						resizza();
						firstTime = false;
						myPlayer.myStopStatus = false;
						//loadedMov = this.currMov;
						this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
						this.parent.myToolbar.bottoni(true);
						//nsclosed = false;
					}
					resizza();
					/*if (myStopStatus) {
						this.pause(true);
						this.seek(0);
					}
					if (parent != _level0.monitor.mon) {
						parent.parent.parent.myMovie.val.text = this.clipPath;
						parent.parent.parent.myMovie.val.textColor = 0x000000;
					}*/
					break;
				case "NetStream.Play.Stop" :
					if (event.info.code == "NetStream.Play.Stop" && myLoop) {
						if (Preferences.pref.myLoop) {
							myPlayer.NS.seek(0);
						} else {
							this.parent.myToolbar.avviaSelector();
						}
					}
					break;
				case "NetStream.Play.StreamNotFound" :
					/*if (nLoadErr<1 && FlxerStarter.myPrefSO.data.flxerPref.childNodes[0].childNodes[1].attributes.use == "true") {
						nLoadErr++;
						this.clipPath = FlxerStarter.myPrefSO.data.flxerPref.childNodes[0].childNodes[1].attributes.value+this.clip;
						this.play(this.clipPath);
						if (parent != _level0.monitor.mon) {
							parent.parent.parent.myMovie.val.text = "SEARCHING ON THE NET";
							parent.parent.parent.myMovie.val.textColor = 0xFF0000;
						}
					} else if (parent != _level0.monitor.mon) {
						parent.parent.parent.myMovie.val.text = "FILE NOT FOUND";
						parent.parent.parent.myMovie.val.textColor = 0xFF0000;
					}*/
					break;
			}
		}
		/* IMMAGINI /////////////////*/
		function avvia_jpg(index) {
			listaSS = [];
			generaListaSS();
			for (var a = 0; a<listaSS.length; a++) {
				if (parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString() == parent.parent.home.childNodes[0].childNodes[listaSS[a]].childNodes[0].childNodes[0].toString()) {
					index = a;
				}
			}
			if (index != undefined || index == 0) {
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
				n = index;
				play_status = true;
			} else {
				this.parent.myToolbar.mRoot.customItems[0].enabled = true;
				play_status = false;
			}
			this.parent.myToolbar.piede.indice.curs.puls.enabled = false;
			load_foto();
		}
		function generaListaSS() {
			for (var a = 0; a<parent.parent.home.childNodes[0].childNodes.length; a++) {
				var tmp = parent.parent.home.childNodes[0].childNodes[a].childNodes[0].childNodes[0].toString();
				trace(tmp)
				tmp = tmp.substring(tmp.length-3, tmp.length);
				if (tmp == "jpg") {
					listaSS.push(a);
				}
			}
		}
		function load_foto() {
			clearInterval(ssInt);
			/*
			this.myPlayer.createEmptyMovieClip("foto_"+l,this.myPlayer.getNextHighestDepth());
			this.myPlayer["foto_"+l].alpha = 0;
			if (Preferences.pref.playerColors.colorBkgPlayerFoto != undefined) {
				DrawerFunc.drawer(this.myPlayer["foto_"+l],"fondo",0,0,w,h,Preferences.pref.playerColors.colorBkgPlayerFoto,null,100);
			}
			*/
			var tmp = parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[0].childNodes[0].toString();
			if (tmp.lastIndexOf("cnt=") != -1) {
				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			}
			currMov = tmp;
			//load_jpg_swf(tmp,this.myPlayer["foto_"+l]);
			load_jpg_swf(tmp);
			if (parent.parent.home.childNodes[0].childNodes.length>1) {
				this.parent.myToolbar.tit = (n+1)+" / "+listaSS.length+" - "+parent.parent.home.childNodes[0].childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
				//this.parent.myToolbar.tit = parent.parent.home.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
				this.parent.myToolbar.piede.indice.counter.htmlText = (n+1)+" / "+listaSS.length;
				this.parent.myToolbar.piede.indice.curs.x = (((this.parent.myToolbar.barr_width)/(listaSS.length-1))*n);
				l++;
				if (n>listaSS.length-2) {
					n = 0;
				} else {
					n++;
				}
			} else {
				this.parent.myToolbar.piede.indice.counter.htmlText = (n+1)+" / "+listaSS.length;
				this.parent.myToolbar.tit = parent.parent.home.childNodes[listaSS[n]].childNodes[1].childNodes[0].toString();
			}
		}
		function load_jpg_swf(mov) {
			//trgt.mcl = new main.mcLoader(mov, trgt, this, "MovieClipLoader_succes", "MovieClipLoader_progress");
			currMov = mov;
			mbuto(getTimer()+",load_movie,0,"+currMov+","+Preferences.pref.tipo+",0");
		}
		function loadNext() {
			if (Preferences.pref.tipo == "jpg" && listaSS.length>0 && !this.parent.mySuperPlayer.myPlayer.myStopStatus) {
				load_foto();
			}
		}
		function initHandler(e) {
			trace("loadnEXT")
			clearInterval(ssInt);
			if (Preferences.pref.tipo == "jpg" && listaSS.length>0) {
				ssInt = setInterval(loadNext, Preferences.pref.ss_time);
			}
		}
		function resizza() {
			trace("resizza");
			var tmpTrgt;
			var item;
			if (Preferences.pref.resizza_onoff) {
				if (myPlayer.oldTipo == "flv" || myPlayer.oldTipo == "jpg") {
					if (myPlayer.oldTipo == "flv") {
						tmpTrgt = this.myPlayer.myVideo;
					} else {
						tmpTrgt = this.myPlayer.trgt;
						/*
						for (item in this) {
							if (item.indexOf("foto_") != -1) {
								tmpTrgt = this.monitor[item];
								tmpTrgt.fondo.width = w;
								tmpTrgt.fondo.height = h;
								tmpTrgt.trgt.width = w;
								tmpTrgt.trgt.height = h;
								tmpTrgt.trgt.scaleX = tmpTrgt.trgt.scaleY;
								if ((tmpTrgt.trgt.scaleX/tmpTrgt.trgt.scaleY)>(w/h)) {
									tmpTrgt.trgt.scaleX = tmpTrgt.trgt.scaleY;
								} else {
									tmpTrgt.trgt.scaleY = tmpTrgt.trgt.scaleX;
								}
							}
						}
						*/
					}
					tmpTrgt.width = w;
					tmpTrgt.height = h;
				} else if (myPlayer.oldTipo == "swf") {
					tmpTrgt = this.myPlayer.trgt.content;
					tmpTrgt.scaleX = w/Preferences.pref.swfW;
					tmpTrgt.scaleY = h/Preferences.pref.swfH;
					trace(tmpTrgt.scaleY + "swffff" + tmpTrgt.scaleX)
					/*
					tmpTrgt = this.monitor.mon.trgt;
					if ((Preferences.pref.swfW/Preferences.pref.swfH)>(w/h)) {
						tmpTrgt.scaleX = tmpTrgt.scaleY=(w/Preferences.pref.swfW);
	
					} else {
						tmpTrgt.scaleY = tmpTrgt.scaleX=(h/Preferences.pref.swfH);
					}
					*/
					
				}
			} else {
				if (myPlayer.oldTipo == "flv") {
					tmpTrgt = this.myPlayer.myVideo;
					tmpTrgt.width = tmpTrgt.width;
					tmpTrgt.height = tmpTrgt.height;
				} else if (myPlayer.oldTipo == "jpg" || myPlayer.oldTipo == "swf") {
					this.myPlayer.trgt.scaleY = this.myPlayer.trgt.scaleX = 1;
					/*
					for (item in this) {
						if (item.indexOf("foto_") != -1) {
							tmpTrgt = this.monitor[item];
							tmpTrgt.fondo.width = w;
							tmpTrgt.fondo.height = h;
							tmpTrgt.trgt.scaleY = 100;
							tmpTrgt.trgt.scaleX = 100;
						}
					}
					*/
				} else if (myPlayer.oldTipo == "swf") {
					tmpTrgt = this.myPlayer.trgt.content;
					tmpTrgt.scaleX = tmpTrgt.scaleY=1;
				}
			}
			if (Preferences.pref.centra_onoff) {
				if (myPlayer.oldTipo == "flv" || myPlayer.oldTipo == "jpg") {
					if (myPlayer.oldTipo == "flv") {
						tmpTrgt = this.myPlayer.myVideo;
					} else {
						tmpTrgt = this.myPlayer.trgt;
						/*
							for (item in this.monitor) {
								if (item.indexOf("foto_") != -1) {
									tmpTrgt = this.monitor[item];
									tmpTrgt.fondo.width = w;
									tmpTrgt.fondo.height = h;
									tmpTrgt.trgt.x = tmpTrgt.trgt.width/2;
									tmpTrgt.trgt.y = tmpTrgt.trgt.height/2;
								}
							}
						*/
					}
				} else if (myPlayer.oldTipo == "swf") {
					tmpTrgt = this.myPlayer.trgt;
					//tmpTrgt.fondo.width = w;
					//tmpTrgt.fondo.height = h;
					trace(Preferences.pref.swfW*tmpTrgt.content.scaleX)
					tmpTrgt.x = (w-(Preferences.pref.swfW*tmpTrgt.content.scaleX));
					tmpTrgt.y = (h-(Preferences.pref.swfH*tmpTrgt.content.scaleY));
				}
				tmpTrgt.x = -tmpTrgt.width/2;
				tmpTrgt.y = -tmpTrgt.height/2;
			}
			tmpTrgt.visible = true;
		}
		/* SWF /////////////////*/
		function avvia_swf(index) {
			//ss = false;
			var tmp = parent.parent.home.childNodes[0].childNodes[index].childNodes[0].childNodes[0].toString();
			if (tmp.lastIndexOf("cnt=") != -1) {
				tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			}
			load_jpg_swf(tmp);
			/*mp3player = new Sound(this.myPlayer.mon);*/
			this.parent.myToolbar.tit = parent.parent.home.childNodes[0].childNodes[index].childNodes[1].childNodes[0].childNodes[0].toString();
			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;
		}
		/*function stoppa() {
		this.stop_play_flv();
		if (this.parent.myToolbar.single) {
		this.parent.myToolbar.ppBig.visible = true;
		}
		clearInterval(autostopInt);
		}
		/*
		function setPos(ww, hh) {
			w = ww;
			h = hh-(testaH+this.parent.myToolbar.piede.piedeEst.height+1);
			this.fondo.width = w;
			this.fondo.height = h;
			this.myMask.width = w;
			this.myMask.height = h;
			resizza();
		}
*/
		/* JPG / SWF /////////////////
		function fotografa(target_mc) {
			clearInterval(stopper)
			trace("fotografa"+target_mc.parent)
			var pict = new BitmapData(w, h, true, 0x00FFFF);
			//Snapshot della image caricata
			pict.draw(target_mc);
			target_mc.parent.createEmptyMovieClip("thumb",target_mc.parent.getNextHighestDepth())
			target_mc.parent.thumb.attachBitmap(pict, 100)
			//Non ho più bisogno della clip con l'image cosi la rimuovo
			target_mc.removeMovieClip()
			//this.parent.myToolbar.ppBig.visible = true;
			this.parent.myToolbar.piede.contr.playpause.gotoAndStop(1);
			//target_mc.parent.myMcl.unloadClip(target_mc)
		}
		function avviaFotografa(target_mc) {
			stopper = setInterval(this, "fotografa", 400, target_mc);
		}
		function MovieClipLoader_progress(target_mc, loadedBytes, totalBytes) {
			this.parent.myToolbar.piede.indice.barr.width = this.parent.myToolbar.barr_width*(loadedBytes/totalBytes);
			if (Preferences.pref.tipo == "swf" && target_mc.currentframe && !swf_started) {
				if (autostop && firstTime) {
					play_status = autostop = firstTime = false;
					avviaFotografa(target_mc)
					//target_mc.stop();
				} else {
					this.parent.myToolbar.avvia_indice();
					this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
					swf_started = true;
				}
				resizza(target_mc);
			}
		}
		function MovieClipLoader_succes(target_mc) {
			loadedMov = currMov;
			mcLoaded = true;
			if (Preferences.pref.tipo == "swf" && !swf_started) {
				if (autostop && firstTime) {
					firstTime = false;
					play_status = false;
					target_mc.stop();
					//this.parent.myToolbar.ppBig.visible = true;
				} else {
					target_mc.play();
					this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
					swf_started = true;
				}
				this.parent.myToolbar.avvia_indice();
			}
			resizza(target_mc);
			if (Preferences.pref.tipo == "jpg") {
				if (l>1 && target_mc.parent.parent["foto_"+(l-2)]) {
					target_mc.parent.parent["foto_"+(l-2)].myTween = new main.myTween(target_mc.parent.parent["foto_"+(l-2)], "_alpha", mx.transitions.easing.Regular.easeIn, 100, 0, 10, this, "removePrev");
				}
				var tmp = "";
				if (play_status && parent.parent.home.childNodes.length>1) {
					tmp = "loadNext";
				}
				target_mc.parent.myTween = new main.myTween(target_mc.parent, "_alpha", mx.transitions.easing.Regular.easeIn, 0, 100, 10, this, tmp);
			}
			var tmp = this.parent.myToolbar.tit;
			if (info) {
				tmp += "   (size: "+int(target_mc.getBytesTotal()/1024)+" Kb / W: "+target_mc.width+" px / H: "+target_mc.height+" px)";
			}
			this.parent.myToolbar.lab_i.htmlText = tmp;
		}
		function removePrev(target_mc) {
			target_mc.removeMovieClip();
		}*/
		/* MP3 /////////////////
		function avvia_mp3() {
			if (!mp3player) {
				mp3player = new Sound();
				mp3player.owner = this;
				mp3player.onLoad = function() {
					if (!owner.autostop) {
						this.start(0);
						owner.play_status = true;
						owner.loadedMov = owner.currMov;
						owner.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
					}
				};
				mp3player.onSoundComplete = function() {
					trace(owner.myLoop)
					if (owner.myLoop) {
						this.start(0);
					} else {
						if (owner.parent.myToolbar.piede.contr.selector.visible) {
							owner.parent.myToolbar.piede.contr.selector.puls.onPress();
						}
					}
				};
			}
			this.parent.myToolbar.tit = parent.parent.home.childNodes[index].childNodes[1].childNodes[0].toString();
			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit;
			var tmp = parent.parent.home.childNodes[index].childNodes[0].childNodes[0].toString();
			//tmp = tmp.substring(tmp.lastIndexOf("cnt=")+4, tmp.length);
			//descr = parent.parent.home.childNodes[index].childNodes[1];
			load_mp3(tmp);
		}
		function load_mp3(mov) {
			mp3player.loadSound(mov,false);
			currMov = mov;
			this.parent.myToolbar.avvia_indice();
		}*/
		/* TOOLS /////////////////
		function volume_onPress() {
			volInt = setInterval(this, "MySetVolume", 30);
		}
		function MySetVolume() {
			if (Preferences.pref.tipo == "flv") {
				this.myPlayer.myFlvPlayer.mp3player.setVolume(-(this.parent.myToolbar.piede.contr.volume_ctrl.slider.y+10+this.parent.myToolbar.piede.contr.volume_ctrl.slider.height));
			} else {
				mp3player.setVolume(-(this.parent.myToolbar.piede.contr.volume_ctrl.slider.y+10+this.parent.myToolbar.piede.contr.volume_ctrl.slider.height));
			}
		}
		function volume_onRelease() {
			clearInterval(volInt);
		}
		//
		function avanti_swf() {
			if (play_status) {
				var tmp = "gotoAndPlay";
			} else {
				var tmp = "gotoAndStop";
			}
			var tmp2 = this.myPlayer.mon.trgt.currentframe+int(this.myPlayer.mon.trgt.totalframes/10);
			if (tmp2>this.myPlayer.mon.trgt.totalframes) {
				tmp2 = this.myPlayer.mon.trgt.totalframes;
			}
			this.myPlayer.mon.trgt[tmp](tmp2);
		}
		function indietro_swf() {
			if (play_status) {
				var tmp = "gotoAndPlay";
			} else {
				var tmp = "gotoAndStop";
			}
			var tmp2 = this.myPlayer.mon.trgt.currentframe-int(this.myPlayer.mon.trgt.totalframes/10);
			if (tmp2<0) {
				tmp2 = 0;
			}
			this.myPlayer.mon.trgt[tmp](tmp2);
		}
		function avanti_mp3() {
			mp3player.stop();
			play_status = true;
			var tmp2 = int((mp3player.position/1000)+(mp3player.duration/10000));
			if (tmp2>mp3player.duration/1000) {
				tmp2 = mp3player.duration/1000;
			}
			mp3player.start(tmp2);
			this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
		}
		function indietro_mp3() {
			mp3player.stop();
			play_status = true;
			var tmp2 = int((mp3player.position/1000)-(mp3player.duration/10000));
			if (tmp2<0) {
				tmp2 = 0;
			}
			mp3player.start(tmp2);
			this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
		}
		function avanti_jpg() {
			if (this.parent.myToolbar.piede.contr.playpause.currentframe == 2) {
				this.parent.myToolbar.piede.contr.playpause.puls.onPress();
			}
			if (parent.parent.home.childNodes.length>1) {
				if (n<parent.parent.home.childNodes.length-1) {
					load_foto();
				}
			}
		}
		function indietro_jpg() {
			if (this.parent.myToolbar.piede.contr.playpause.currentframe == 2) {
				this.parent.myToolbar.piede.contr.playpause.puls.onPress();
			}
			if (parent.parent.home.childNodes.length>1) {
				if (n-2>=0) {
					n -= 2;
					load_foto();
				}
				if (n == 0) {
					n = listaSS.length-2;
					load_foto();
				}
			}
		}
		function indietro_flv() {
			var tmp2 = int((this.myPlayer.NS.time)-(this.myDuration/10));
			if (tmp2<0) {
				tmp2 = 0;
			}
			this.myPlayer.NS.seek(0);
		}
		function avanti_flv() {
			var tmp2 = int((this.myPlayer.NS.time)+(this.myDuration/10));
			if (tmp2>this.myDuration) {
				tmp2 = this.myDuration;
			}
			this.myPlayer.NS.seek(tmp2);
		}
		function stoppaInizFlv() {
			clearInterval(stopper);
			autostop = false;
			this.myPlayer.NS.close();
			this.parent.myToolbar.lab_i.htmlText = this.parent.myToolbar.tit+": Stopped";
			stop_play_flv();
			nsclosed = true;
			//if (this.parent.myToolbar.single) {
				//this.parent.myToolbar.ppBig.visible = true;
			//}
		}
		function stop_play_jpg() {
			if (play_status) {
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(1);
				clearInterval(ssInt);
				play_status = false;
			} else {
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
				load_foto();
				play_status = true;
			}
		}
		function stop_play_swf() {
			if (play_status) {
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(1);
				this.myPlayer.mon.trgt.stop();
				play_status = false;
			} else {
				trace("cazzo"+this.myPlayer.mon.thumb)
				if (this.myPlayer.mon.thumb) {
					this.myPlayer.mon.thumb.removeMovieClip()
					load_jpg_swf(currMov,this.myPlayer.mon)
				} else {
					this.myPlayer.mon.trgt.play();
				}
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
				play_status = true;
			}
		}
		function stop_play_mp3() {
			if (play_status) {
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(1);
				mp3player.stop();
				play_status = false;
			} else {
				this.parent.myToolbar.piede.contr.playpause.gotoAndStop(2);
				if (mp3player.duration != mp3player.position) {
					mp3player.start(mp3player.position/1000);
				} else {
					mp3player.start(0);
				}
				play_status = true;
			}
		}
		function resizza() {
			trace("resizza");
			if (resizza_onoff) {
				if (Preferences.pref.tipo == "flv") {
					var trgt = this.myPlayer.myFlvPlayer.myVideo.vid_flv;
					trgt.width = w;
					trgt.height = h;
					if (trgt.xscale>trgt.yscale) {
						trgt.xscale = trgt.yscale;
					} else {
						trgt.yscale = trgt.xscale;
					}
				} else if (Preferences.pref.tipo == "jpg") {
					for (var item in this.myPlayer) {
						if (item.indexOf("foto_") != -1) {
							var trgt = this.myPlayer[item];
							trgt.fondo.width = w;
							trgt.fondo.height = h;
							trgt.trgt.width = w;
							trgt.trgt.height = h;
							trgt.trgt.xscale = trgt.trgt.yscale;
							//if ((trgt.trgt.xscale/trgt.trgt.yscale)>(w/h)) {
							//trgt.trgt.xscale = trgt.trgt.yscale;
							//} else {
							//trgt.trgt.yscale = trgt.trgt.xscale;
							//}
						}
					}
				} else if (Preferences.pref.tipo == "swf") {
					var trgt = this.myPlayer.mon.trgt;
					if ((Preferences.pref.swfW/Preferences.pref.swfH)>(w/h)) {
						trgt.xscale = trgt.yscale=(w/Preferences.pref.swfW)*100;
	
					} else {
						trgt.yscale = trgt.xscale=(h/Preferences.pref.swfH)*100;
					}
				}
			} else {
				if (Preferences.pref.tipo == "flv") {
					var trgt = this.myPlayer.myFlvPlayer.myVideo.vid_flv;
					trgt.width = trgt.width;
					trgt.height = trgt.height;
				} else if (Preferences.pref.tipo == "jpg") {
					for (var item in this.myPlayer) {
						if (item.indexOf("foto_") != -1) {
							var trgt = this.myPlayer[item];
							trgt.fondo.width = w;
							trgt.fondo.height = h;
							trgt.trgt.yscale = 100;
							trgt.trgt.xscale = 100;
						}
					}
				} else if (Preferences.pref.tipo == "swf") {
					var trgt = this.myPlayer.mon;
					trgt.trgt.xscale = trgt.trgt.yscale=100;
				}
			}
			if (centra_onoff) {
				if (Preferences.pref.tipo == "flv") {
					trgt.x = (w-trgt.width)/2;
					trgt.y = (h-trgt.height)/2;
				} else if (Preferences.pref.tipo == "jpg") {
					for (var item in this.myPlayer) {
						if (item.indexOf("foto_") != -1) {
							var trgt = this.myPlayer[item];
							trgt.fondo.width = w;
							trgt.fondo.height = h;
							trgt.trgt.x = (w-trgt.trgt.width)/2;
							trgt.trgt.y = (h-trgt.trgt.height)/2;
						}
					}
				} else if (Preferences.pref.tipo == "swf") {
					var trgt = this.myPlayer.mon.trgt;
					//trgt.fondo.width = w;
					//trgt.fondo.height = h;
					trgt.x = (w-((400*trgt.xscale)/100))/2;
					trgt.y = (h-((300*trgt.yscale)/100))/2;
				}
			}
			trgt.visible = true;
		}*/
		function textureDrawer(w, h) {
			
			var myBitmapData:BitmapData = new texture(w,h);
			//myBitmapData.draw()
			var tmp = new Bitmap(myBitmapData)
			return tmp;
		}
	}
}