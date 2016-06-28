package artur.units {
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class U_Paladin extends PallDoll {
		public  var normScale:Number = 1;
		public var type:String = 'Paladin';
		public var free:Boolean = true;
		private var isOver:Boolean = false;
		private var parts:Array ;
		private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow());
		private static var sounds:Array = [ {id:'fow1', frame:55},{ id:'bot1_fs1', frame:40 }, { id:'bot1_fs2', frame:50 }, { id:'pall_hurt', frame:75 },{id:'blade1',frame:78},{id:'pall_death',frame:81}];
		public static var onSound:Boolean = true;
		public function U_Paladin() {
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh)
			parts = [this._head, this._body, this._sikira, this._appArmR, this._appArmL, this._hend1R, this._hend2R, this._hend2L,  this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L,_sikira2];
			itemUpdate ( [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] );
		}
		 public function onWalk():void {
			 //App.sound.playSound('bot1_init', App.sound.onVoice, 1);
		 }
		 public function out(e:MouseEvent=null):void {
			isOver = false;
		 }
		
		public function over(e:MouseEvent=null):void {
			isOver = true;
			TweenLite.to(this, 0.25, { scaleX:1.3, scaleY:1.3} );
			App.btnOverFilter.color = 0xFFFFFF;
			this.filters = [App.btnOverFilter];
		}
		
		public function init(parr:DisplayObjectContainer = null, lvl:int = 0):void {
			onSound = true
			this.scaleX = normScale;
			this.scaleY = normScale;
			this.filters = [];
			this.free = false;
			this.gotoAndPlay('idle');
			if (parr) {
				parr.addChild(this);
			}
			
		}
		
		public function update():void {
			if (!isOver && this.scaleX == 1.3) {
				TweenLite.to(this, 0.25, { scaleX:1, scaleY:1 } );
				this.filters = [];
			}
			
			if (!onSound)
			return;
			for (var i:int = 0; i < sounds.length; i++) {
				if (sounds[i].frame == currentFrame) {
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
		}
		public function frees():void {
			this.free = true;
			this.gotoAndStop(1);
			if (parent) {
				parent.removeChild(this);
			}
			for (var i:int = 0; i < parts.length; i++) {
				if (Sprite(parts[i]).numChildren > 1) {
					var item:U_PaladinItemsCash = U_PaladinItemsCash(Sprite(parts[i]).getChildAt(1));
					item.frees();
				}
			}
		}
		
		public function itemUpdate(obj:Object):void {
			for (var i:int = 0; i < parts.length; i++) {
				switch(true) {
				    case (i == 0):
						this.setItem(i, int(obj[0]));
					   break;
					case(i == 1):
						this.setItem(i, int(obj[1]));
					    break;
					case(i == 2):
						this.setItem(i, int(obj[5]));
					    break;
					case(i == 3 || i == 4):
						this.setItem(i, int(obj[3]));
					    break;
					case(i > 4 && i < 8):
						this.setItem(i, int(obj[4]));
					    break;
					case(i > 7 && i < 14):
						this.setItem(i, int(obj[2]));
					    break;
					case(i == 14):
						this.setItem(i, int(obj[6]));
						break;
			   }
			}
		}
		
		private function setItem(type:int, frame:int):void {
			if (Sprite(parts[type]).numChildren > 1) {
				var item:U_PaladinItemsCash = U_PaladinItemsCash(Sprite(parts[type]).getChildAt(1));
				if(item.getId != frame) {
					item.frees();
					Sprite(parts[type]).addChild(U_PaladinItemsCash.getItem(type, frame));
				}
				return;
			}
		   Sprite(parts[type]).addChild(U_PaladinItemsCash.getItem(type, frame));
		}
	}

}