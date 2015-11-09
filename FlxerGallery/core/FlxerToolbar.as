package FlxerGallery.core {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	import FlxerGallery.main.BitmapDataToBinaryPNG
	import FlxerGallery.main.ByteArrayUploader
	public class FlxerToolbar extends MovieClip {
		var w;
		var h;
		//
		public var testa
		public var piede
		public var lab_i
		public var tit
		public var mmSelTit
		var barr_width
		var bd
		/*var tipo
		var single
		var myKeyL;
		var noImg;
		var t*/
		public function FlxerToolbar() {
			//t = new toolbar();
			//this.addChild(t);
		}
		public function avvia2() {
			setPos(Preferences.pref.w,Preferences.pref.h);
			trace("cazzo")
			//this.visible = false;
			/*piede.createEmptyMovieClip("myMenu",piede.getNextHighestDepth());
			piede.myMenu.visible = false;
			piede.myMenu.x = w-144;
			piede.myMenu.y = -120-17;
			_root.myDrawerFunc.drawer(piede.myMenu,"fondo",-piede.myMenu.x,-piede.myMenu.y-piede.y,w,h,0xFF00FF,null,0);
			piede.myMenu.fondo.onPress = function() {
				this.parent.parent.parent.apriMenu();
			};
			piede.myMenu.fondo.useHandCursor = false;
			_root.myDrawerFunc.textDrawerSP(piede.myMenu,"myMenu","bella",0,0,140,120,false);
			piede.myMenu.myMenu.background = true;
			piede.myMenu.myMenu.border = true;
			piede.myMenu.myMenu.backgroundColor = _root.myFlxerPlayerStyles.testo.colorBkg;
			piede.myMenu.myMenu.borderColor = _root.myFlxerPlayerStyles.testo.colorBorder;
			*/
			piede.contr.selector.visible = piede.ss.visible=piede.m.visible=false;
			piede.toppa.visible = true;
			avviaPuls();
			//
			/*piede.toppa.onPress = function() {
			};
			piede.toppa.useHandCursor = false;
			piede.contr.volume_ctrl.slider.onPress = function() {
				startDrag(this, false, this.parent.path.x, this.parent.path.y+this.parent.path.height-this.height, this.parent.path.x, this.parent.path.y);
				this.parent.parent.parent.parent.parent.mySuperPlayer.volume_onPress();
			};
			piede.contr.volume_ctrl.slider.onRelease = function() {
				this.parent.prevFrame();
				stopDrag();
				this.parent.parent.parent.parent.parent.mySuperPlayer.volume_onRelease();
			};
			piede.contr.volume_ctrl.slider.onReleaseOutside = function() {
				onRelease();
			};
			myKeyL = new Object();
			myKeyL.owner = this;
			myKeyL.onKeyDown = function() {
				if (Key.getCode() == Key.LEFT) {
					if (this.owner.piede.contr.rw.puls.enabled) {
						this.owner.piede.contr.rw.puls.onPress();
					}
				}
				if (Key.getCode() == Key.RIGHT) {
					if (this.owner.piede.contr.fw.puls.enabled) {
						this.owner.piede.contr.fw.puls.onPress();
					}
				}
				if (Key.getCode() == Key.SPACE) {
					if (this.owner.piede.contr.playpause.puls.enabled) {
						this.owner.piede.contr.playpause.puls.onPress();
					}
				}
			};
			Key.addListener(myKeyL);*/
		}
		function scattaThumb(t) {
			this.parent.myThumbSaver.scattaThumb(w,this.parent.mySuperPlayer.h,this.parent.mySuperPlayer)
			this.parent.addChild(this.parent.myThumbSaver);
			trace("scattaThumbTooll")
		}
		function avviaPuls() {
			if (Preferences.pref.thumbSaver) {
				piede.m.avvia({fnz:scattaThumb,txt:"MAKE THUMB",alt:"Mostra opzioni menu"});
			} else {
				piede.m.avvia({fnz:apriMenu,txt:"menu",alt:"Mostra opzioni menu"});
			}
			piede.contr.fw.avvia({fnz:avanti,alt:"Vai avanti (arrow right)"});
			piede.contr.rw.avvia({fnz:indietro,alt:"Torna indietro (arrow left)"});
			piede.contr.playpause.avvia({fnz:myPlaypause,alt:"Stop/Play (space bar)",isSimb:true});
			piede.indice.curs.avvia({fnz:scratch,alt:"scratch",fnzOut:stopScratch});
		}
		function avvia(stat) {
			if (Preferences.pref.autostop) {
				this.ppBig = new PlayPause();
				this.ppBig.x = (Preferences.pref.w-66)/2;
				this.ppBig.x = (Preferences.pref.h-66)/2;
				this.ppBig.scaleX = this.ppBig.scaleY = 600;
				this.ppBig.avvia({fnz:myPlaypause,alt:"Stop/Play (space bar)",isSimb:true});
				this.addChild(this.ppBig)
			}

			this.visible = true;
			piede.m.visible = true;
			piede.contr.selector.visible = !Preferences.pref.single;
			//tipo = t;
			if (stat == "player") {
				piede.ss.visible = false;
				piede.toppa.visible = false;
				/*if (piede.contr.playpause.currentFrame == 2) {
				piede.contr.playpause.puls.onPress();
				}
				if (Preferences.pref.tipo == "jpg") {
					piede.contr.volume_ctrl.visible = false;
				} else {
					piede.contr.volume_ctrl.visible = true;
				}*/
			} else {
				piede.ss.visible = !Preferences.pref.noImg;
				piede.toppa.visible = true;
				this.parent.mySuperPlayer.resetta();
				this.parent.mySuperPlayer.visible = false;
				if (this.parent.mySelector) {
					this.parent.mySelector.visible = true;
				}
				this.lab_i.htmlText = mmSelTit;
				this.resetta();
			}
			//getURL("javascript:alert('"+w+","+h+"');");
			//trace("AAAAAAAAVVVVVVVVVVVVVVIIIIIIIIIIIAAAAAAAAAAAAAA")
			setPos(w,h);
		}
		function visualizzappBig() {
			this.ppBig = new PlayPause();
			ppBig.x = (w-66)/2;
			ppBig.y = (h-66)/2;
			ppBig.scaleX = scaleY = 600;
			ppBig.fnz = "myPlaypause";
			ppBig.fnzTrgt = this;
			this.addChild(ppBig);
		}
		function setPos(ww, hh) {
			w = ww;
			h = hh;
			trace("setPos "+w+" "+h+" "+piede.piedeEst.height);
			if (testa) {
				testa.width = w;
			}
			piede.piedeEst.width=w;
			lab_i.width = w-10;
			piede.y = h-piede.piedeEst.height;
			piede.piedeEst.width = w;
			piede.piedeInt.width = piede.toppa.width=w-2;
			var deltaW = 0;
			if (Preferences.pref.single) {
				deltaW = 48;
			}
			var bbb;
			if (!piede.contr.volume_ctrl.visible) {
				piede.contr.selector.x = 52;
				bbb = 1.8;
				//deltaW += 20;
			} else {
				piede.contr.selector.x = 68;
				bbb = 1;
			}
			piede.m.x = w-(piede.m.lab.textWidth+10);
			piede.contr.x = int(w-(piede.contr.selector.x+piede.contr.selector.lab.textWidth+5)-(w-piede.m.x)+deltaW-20);
			piede.indice.barr.width = int(piede.contr.x-piede.indice.x-(piede.indice.counter.width/bbb));
			piede.indice.counter.x = piede.indice.barr.width+3;
			piede.indice.barrEst.width = piede.indice.barr.width+2;
			barr_width = piede.indice.barr.width;
			piede.ss.x = w-95;
			//piede.myMenu.x = w-piede.myMenu.myMenu.width-4;
			//piede.myMenu.fondo.x = -piede.myMenu.x;
		}
		//
		function itemHandler(obj, item) {
			//piede.myMenu.visible = false;
			parent.mySelector.resizza_onoff = parent.mySuperPlayer.resizza_onoff=true;
			parent.mySuperPlayer.resizza();
		}
		function itemHandler2(obj, item) {
			//piede.myMenu.visible = false;
			parent.mySelector.resizza_onoff = parent.mySuperPlayer.resizza_onoff=false;
			parent.mySuperPlayer.resizza();
		}
		function itemHandler3(obj, item) {
			//piede.myMenu.visible = false;
			//fscommand("fullscreen", true);
			fs(obj,item);
		}
		function itemHandler4(obj, item) {
			//piede.myMenu.visible = false;
			if (piede.contr.playpause.currentFrame == 2) {
				piede.contr.playpause.puls.onPress();
			}
			/*parent.mySuperPlayer.cacheAsBitmap = true;
			var pageCount:Number = 0;
			var my_pj:PrintJob = new PrintJob();
			if (my_pj.start()) {
				if (my_pj.addPage(_root.galleryPath, {xMin:0, xMax:w, yMin:0, yMax:h}, {printAsBitmap:true})) {
					pageCount++;
				}
			}
			if (pageCount>0) {
				my_pj.send();
			}
			delete my_pj;
			this.parent.mySuperPlayer.cacheAsBitmap = false;*/
		}
		function itemHandler5(obj, item) {
			//piede.myMenu.visible = false;
			dw(obj,item);
		}
		function apriEmbed() {
			//piede.myMenu.visible = false;
			parent.myToolbar.attachMovie("myEmbed","myEmbed",getNextHighestDepth(),{_x:int(parent.myToolbar.w/2), _y:int(parent.myToolbar.h/2)});
			var tmp = this.parent.embePath+Preferences.pref.startUrl;
			myEmbed.lab_i.text = "<object type=\"application/x-shockwave-flash\" data=\""+tmp+"\" width=\""+(parent.myToolbar.w)+"\" height=\""+(parent.myToolbar.h)+"\">\n	<param name=\"movie\" value=\""+tmp+"\" />\n</object>";
			myEmbed.c.fnz = "chiudiEmbed";
			myEmbed.c.fnzTrgt = parent.myToolbar;
		}
		function dw(obj, item) {
			//var tmp = this.parent.mySuperPlayer.currMov.split(",");
			navigateToURL(new URLRequest(this.parent.downPath+StarterGallery.myReplace(this.parent.mySuperPlayer.currMov, this.parent.myPath, "")),"_self");
			trace("download "+StarterGallery.myReplace(this.parent.mySuperPlayer.currMov, this.parent.myPath, ""));
		}
		function fs(obj, item) {
			if (piede.contr.playpause.currentFrame == 2) {
				piede.contr.playpause.puls.onPress();
			}
			var tmp;
			if (Preferences.pref.single) {
				tmp = this.parent.startUrl.split(",");
				if (tmp[0].indexOf("http://") != -1) {
					trace(this.parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"&out=true");
					navigateToURL(new URLRequest(this.parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"&out=true"), "_blank");
				} else {
					trace("javascript:popupwindow('FULL','FULL','"+this.parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');");
					navigateToURL(new URLRequest("javascript:popupwindow('FULL','FULL','"+this.parent.myFsPath+tmp[0]+"&tit="+tmp[1]+"','FLXERPLAYER','no','yes');"),"_self");
				}
			} else {
				tmp = this.parent.startUrl;
				if (tmp.indexOf("http://") != -1) {
					trace(this.parent.myFsPath+tmp+"&out=true");
					navigateToURL(new URLRequest(this.parent.myFsPath+tmp+"&out=true"),"_blank");
				} else {
					trace("javascript:popupwindow('FULL','FULL','"+this.parent.myFsPath+tmp+"','FLXERPLAYER','no','yes');");
					navigateToURL(new URLRequest("javascript:popupwindow('FULL','FULL','"+this.parent.myFsPath+tmp+"','FLXERPLAYER','no','yes');"),"_self");
				}
			}
		}
		function avviaSS(t) {
			//piede.myMenu.visible = false;
			parent.mySelector.visible = false;
			piede.toppa.visible = piede.ss.visible=false;
			this.parent.mySuperPlayer.avvia(0);
		}
		function avviaSelector(a) {
			avvia("selector",Preferences.pref.single);
		}
		function chiudiEmbed() {
			//_root.alt.stoppa();
			this.myEmbed.removeMovieClip();
		}
		//
		function scratch(t) {
			avvia_scratch();
			t.startDrag(false,new Rectangle(0,t.y,piede.indice.barr.width,t.y));
		}
		function stopScratch(t) {
			trace("stopScratch"+piede.contr.playpause.currentFrame)
			if (piede.contr.playpause.currentFrame == 2 && Preferences.pref.tipo == "flv") {
				this.parent.mySuperPlayer.myPlayer.NS.resume();
			}
			this.removeEventListener(Event.ENTER_FRAME, this["scratch_"+Preferences.pref.tipo]);
			avvia_indice();
			t.stopDrag();
		}
	
		function avanti() {
			this.parent.mySuperPlayer["avanti_"+Preferences.pref.tipo]();
		}
		function indietro() {
			this.parent.mySuperPlayer["indietro_"+Preferences.pref.tipo]();
		}
		function myPlaypause(t) {
			if (this.ppBig) {
				/*
				if (this.parent.myViPath) {
					new main.xmlLoader(this.parent.myViPath+StarterGallery.myReplace(this.parent.mySuperPlayer.currMov, this.parent.myPath, ""), this, "vi", this, "", true);
					trace(this.parent.myViPath+StarterGallery.myReplace(this.parent.mySuperPlayer.currMov, this.parent.myPath, "")+"OOOOOOOOOOO")
				}
				this.ppBig.removeMovieClip();
				*/
				this.removeChild(ppBig);
			}
			if (this.parent.mySuperPlayer.myPlayer.myStopStatus) {
				piede.contr.playpause.gotoAndStop(2);
				this.parent.mySuperPlayer.mbuto(getTimer()+",functionPLAY,0")
			} else {
				piede.contr.playpause.gotoAndStop(1);
				play_status = false;
				this.parent.mySuperPlayer.mbuto(getTimer()+",functionSTOP,0")
			}
		}
		function apriMenu(t) {
			var menuTxt = "";
			if (!piede.myMenu.visible) {
				if (piede.toppa.visible) {
					if (!Preferences.pref.single) {
						if (!Preferences.pref.noImg) {
							menuTxt += "<a href=\"asfunction:"+this+".avviaSS\">Slideshow</a><br/>";
						} else {
							menuTxt += "Slideshow (no images)<br/>";
						}
					}
					menuTxt += "Scale: Fit player size<br/>";
					menuTxt += "Scale: 100%<br/>";
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
					if (this.parent.parent.pref.downPath) {
						menuTxt += "Download<br/>";
					}
					menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
				} else {
					if (!Preferences.pref.single) {
						menuTxt += "<a href=\"asfunction:"+this+".avviaSelector\">Playlist</a><br/>";
					}
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler\">Scale: Fit player size</a><br/>";
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler2\">Scale: 100%</a><br/>";
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler3\">Fullscreen</a><br/>";
					menuTxt += "<a href=\"asfunction:"+this+".itemHandler4\">Print this content</a><br/>";
					if (this.parent.parent.pref.downPath) {
						menuTxt += "<a href=\"asfunction:"+this+".itemHandler5\">Download</a><br/>";
					}
					menuTxt += "<a href=\"asfunction:"+this+".apriEmbed\">Embed</a>";
				}
				//piede.myMenu.myMenu.htmlText = "<p class=\"playerMenu\">"+menuTxt+"</p>";
				//piede.myMenu.myMenu.height = piede.myMenu.myMenu.textHeight+5;
				//piede.myMenu.y = -piede.myMenu.myMenu.height+3;
				//piede.myMenu.fondo.y = -piede.myMenu.y-piede.y;
			}
			//piede.myMenu.visible = !piede.myMenu.visible;
		}
		function avvia_indice() {
			//delete this.onEnterFrame;
			if (Preferences.pref.tipo == "mp3") {
				//this.parent.mySuperPlayer.mp3player.start(int(((piede.indice.curs.x/(barr_width))*this.parent.mySuperPlayer.mp3player.duration)/1000));
			}
			this.addEventListener(Event.ENTER_FRAME, this["indice_"+Preferences.pref.tipo]);
		}
		function myTime(mm) {
			var min;
			var tmp;
			var tmp2;
			var sec;
			if (mm>60) {
				tmp = int(mm/60);
				if (tmp.toString().length<2) {
					min = "0"+tmp;
				} else {
					min = tmp;
				}
				tmp2 = int(mm-(60*tmp));
				if (tmp2.toString().length<2) {
					sec = "0"+tmp2;
				} else {
					sec = tmp2;
				}
			} else {
				min = "00";
				if (int(mm).toString().length<2) {
					sec = "0"+int(mm);
				} else {
					sec = int(mm);
				}
			}
			return min+":"+sec;
		}
		function indice_flv(event) {
			if (this.parent.mySuperPlayer.myPlayer.myDuration != undefined) {
				if (this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded<this.parent.mySuperPlayer.myPlayer.NS.bytesTotal) {
					//this.lab_i.htmlText = this.tit+": Playing "+myTime(this.parent.mySuperPlayer.myPlayer.NS.time)+" / "+myTime(this.parent.mySuperPlayer.myPlayer.myDuration);
					this.piede.indice.counter.htmlText = myTime(this.parent.mySuperPlayer.myPlayer.NS.time)+"|"+myTime(this.parent.mySuperPlayer.myPlayer.myDuration);
					/*if (this.parent.mySuperPlayer.info) {
					this.lab_i.htmlText += " (Size: "+int(this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded/1024)+" / "+int(this.parent.mySuperPlayer.myPlayer.NS.bytesTotal/1024)+" Kb W:"+this.parent.mySuperPlayer.monitor.video.vid_flv.width+" Kb H:"+this.parent.mySuperPlayer.monitor.video.vid_flv.height+" )";
					}*/
					piede.indice.barr.width = barr_width*(this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded/this.parent.mySuperPlayer.myPlayer.NS.bytesTotal);
				} else if (this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded == this.parent.mySuperPlayer.myPlayer.NS.bytesTotal && this.parent.mySuperPlayer.myloaded == false) {
					this.parent.mySuperPlayer.myloaded = true;
					piede.indice.barr.width = barr_width;
				} else {
					//this.lab_i.htmlText = this.tit+": Playing "+myTime(this.parent.mySuperPlayer.myPlayer.NS.time)+" / "+myTime(this.parent.mySuperPlayer.myPlayer.myDuration);
					this.piede.indice.counter.htmlText = myTime(this.parent.mySuperPlayer.myPlayer.NS.time)+"|"+myTime(this.parent.mySuperPlayer.myPlayer.myDuration);
					/*if (this.parent.mySuperPlayer.info) {
					this.lab_i.htmlText += " (Size: "+int(this.parent.mySuperPlayer.myPlayer.NS.bytesTotal/1024)+" Kb W:"+this.parent.mySuperPlayer.monitor.video.vid_flv.width+" Kb H:"+this.parent.mySuperPlayer.monitor.video.vid_flv.height+" )";
					}*/
				}
				piede.indice.curs.x = (barr_width)*(this.parent.mySuperPlayer.myPlayer.NS.time/this.parent.mySuperPlayer.myPlayer.myDuration);
//				piede.indice.path.width = piede.indice.curs.x;
				//piede.indice.curs.enabled = true;
			} else {
				if (this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded<this.parent.mySuperPlayer.myPlayer.NS.bytesTotal) {
					this.piede.indice.counter.htmlText = myTime(this.parent.mySuperPlayer.myPlayer.NS.time);
					/*this.lab_i.htmlText = this.tit+": Playing "+myTime(this.parent.mySuperPlayer.myPlayer.NS.time)+" sec.";
					if (this.parent.mySuperPlayer.info) {
					this.lab_i.htmlText += " (Size: "+int(this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded/1024)+" / "+int(this.parent.mySuperPlayer.myPlayer.NS.bytesTotal/1024)+" Kb W:"+this.parent.mySuperPlayer.monitor.video.vid_flv.width+" Kb H:"+this.parent.mySuperPlayer.monitor.video.vid_flv.height+" )";
					}*/
					piede.indice.barr.width = barr_width*(this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded/this.parent.mySuperPlayer.myPlayer.NS.bytesTotal);
				} else if (this.parent.mySuperPlayer.myPlayer.NS.bytesLoaded == this.parent.mySuperPlayer.myPlayer.NS.bytesTotal && this.parent.mySuperPlayer.myloaded == false) {
					this.parent.mySuperPlayer.myloaded = true;
					piede.indice.barr.width = barr_width;
				} else {
					this.piede.indice.counter.htmlText = myTime(this.parent.mySuperPlayer.myPlayer.NS.time);
					/*this.lab_i.htmlText = this.tit+": Playing "+int(this.parent.mySuperPlayer.myPlayer.NS.time)+" sec.";
					if (this.parent.mySuperPlayer.info) {
					this.lab_i.htmlText += " (Size: "+int(this.parent.mySuperPlayer.myPlayer.NS.bytesTotal/1024)+" Kb W:"+this.parent.mySuperPlayer.monitor.video.vid_flv.width+" Kb H:"+this.parent.mySuperPlayer.monitor.video.vid_flv.height+" )";
					}*/
				}
				piede.indice.curs.x = 0;
				piede.indice.curs.enabled = false;
			}
		}
		function indice_swf(event) {
			piede.indice.curs.x = (barr_width)*(this.parent.mySuperPlayer.monitor.mon.trgt.currentFrame/this.parent.mySuperPlayer.monitor.mon.trgt.totalframes);
			this.piede.indice.counter.htmlText = myTime((this.parent.mySuperPlayer.monitor.mon.trgt.currentFrame/25)*60)+"|"+myTime((this.parent.mySuperPlayer.monitor.mon.trgt.totalframes/25)*60);
			if (!Preferences.pref.single && this.parent.mySuperPlayer.monitor.mon.trgt.currentFrame == 1 && this.parent.mySuperPlayer.monitor.mon.trgt.totalframes>1) {
				piede.contr.selector.puls.onPress();
			}
		}
		function indice_mp3(event) {
			if (this.parent.mySuperPlayer.mp3player.getBytesLoaded()<this.parent.mySuperPlayer.mp3player.getBytesTotal()) {
				trace("aaa "+this.parent.mySuperPlayer.mp3player.getBytesLoaded())
				//this.lab_i.htmlText = this.tit+": Playing "+int((this.parent.mySuperPlayer.mp3player.position/1000)/60)+"."+(int(this.parent.mySuperPlayer.mp3player.position/1000)-(int((this.parent.mySuperPlayer.mp3player.position/1000)/60)*60))+" / "+int((this.parent.mySuperPlayer.mp3player.duration/1000)/60)+"."+(int(this.parent.mySuperPlayer.mp3player.duration/1000)-(int((this.parent.mySuperPlayer.mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this.parent.mySuperPlayer.mp3player.getBytesLoaded()/1024)+" / "+int(this.parent.mySuperPlayer.mp3player.getBytesTotal()/1024)+" Kb )";
				this.piede.indice.counter.htmlText = myTime(this.parent.mySuperPlayer.mp3player.position)+"|"+myTime(this.parent.mySuperPlayer.mp3player.duration);
				piede.indice.barr.width = barr_width*(this.parent.mySuperPlayer.mp3player.getBytesLoaded()/this.parent.mySuperPlayer.mp3player.getBytesTotal());
			} else if (this.parent.mySuperPlayer.mp3player.getBytesLoaded() == this.parent.mySuperPlayer.mp3player.getBytesTotal() && this.parent.mySuperPlayer.myloaded == false) {
				this.parent.mySuperPlayer.myloaded = true;
				piede.indice.barr.width = barr_width;
			} else {
				//this.lab_i.htmlText = this.tit+": Playing "+int((this.parent.mySuperPlayer.mp3player.position/1000)/60)+"."+(int(this.parent.mySuperPlayer.mp3player.position/1000)-(int((this.parent.mySuperPlayer.mp3player.position/1000)/60)*60))+" / "+int((this.parent.mySuperPlayer.mp3player.duration/1000)/60)+"."+(int(this.parent.mySuperPlayer.mp3player.duration/1000)-(int((this.parent.mySuperPlayer.mp3player.duration/1000)/60)*60))+" min. (Size: "+int(this.parent.mySuperPlayer.mp3player.getBytesTotal()/1024)+" Kb )";
				this.piede.indice.counter.htmlText = myTime(this.parent.mySuperPlayer.mp3player.position/1000)+"|"+myTime(this.parent.mySuperPlayer.mp3player.duration/1000);
			}
			piede.indice.curs.x = (barr_width)*(this.parent.mySuperPlayer.mp3player.position/this.parent.mySuperPlayer.mp3player.duration);
		}
		function avvia_scratch() {
			this.removeEventListener(Event.ENTER_FRAME, this["indice_"+Preferences.pref.tipo]);
			this.parent.mySuperPlayer.myPlayer.NS.pause();
			if (Preferences.pref.tipo == "mp3") {
				this.parent.mySuperPlayer.mp3player.stop();
			} else {
				this.addEventListener(Event.ENTER_FRAME, this["scratch_"+Preferences.pref.tipo]);
			}
			//this.parent.mySuperPlayer.mp3player.stop();
		}
		function scratch_swf(event) {
			var tmp
			if (this.parent.mySuperPlayer.play_status) {
				tmp = "gotoAndPlay";
			} else {
				tmp = "gotoAndStop";
			}
			this.parent.mySuperPlayer.mbuto(getTimer()+",scratchswf,0,"+(piede.indice.curs.x/barr_width));
			//this.parent.mySuperPlayer.monitor.mon.trgt[tmp](int((piede.indice.curs.x/(barr_width))*this.parent.mySuperPlayer.monitor.mon.trgt.totalframes));
		}
		function scratch_flv(event) {
			this.parent.mySuperPlayer.mbuto(getTimer()+",scratchflv,0,"+(piede.indice.curs.x/barr_width));
		}
		function resetta() {
			delete this.onEnterFrame;
			piede.contr.playpause.gotoAndStop(1);
			piede.indice.curs.x = 0;
			bottoni(true);
		}
		function bottoni(val) {
			piede.indice.curs.enabled = val;
			piede.contr.playpause.puls.enabled = val;
			piede.contr.fw.puls.enabled = val;
			piede.contr.rw.puls.enabled = val;
		}
	}
}