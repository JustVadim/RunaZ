package artur.units {
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinBattle;
	import com.greensock.easing.Back;
	import com.greensock.events.LoaderEvent;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class U_Warwar extends BarbDoll {
		public  var normScale:Number = 1;
		public var type:String = 'Barbarian';
		public var free:Boolean = true;
		private var isOver:Boolean = false;
		private var parts:Array ;
		private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(),true)[0];
		private static var sounds:Array = [ { id:'war_hurt', frame:85 }, { id:'blade2', frame:83 }, { id:'blade2', frame:94 }, { id:'fow2', frame:67 }, { id:'bot1_fs1', frame:47 }, { id:'bot1_fs2', frame:56 }, { id:'pall_death', frame:93 } ];
		public var buffs:Array = PrepareGr.creatBms(new mcBaff, true);
		
		public function U_Warwar() {
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.parts = [this._head, this._body, this._sikira, this._appArmR, this._hend1R, this._hend2R, this._hend3R, this._appArmL, this._hend1L, this._hend2L, this._hend3L, this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L];
			this.shawdow.addChild(sh)
			itemUpdate([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
		}
		
		public function showBuff(num:int):void {
			while (this._baff.numChildren != 1) {
				this._baff.removeChildAt(1);
			}
			this._baff.addChild(buffs[num]);
		}
		
		public function hideBuff():void {
			while (this._baff.numChildren != 1) {
				this._baff.removeChildAt(1);
			}
		}
		
		public function onWalk():void {
			///// App.sound.playSound('bot1_init', App.sound.onVoice, 1);
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
	
		public function init(parr:DisplayObjectContainer=null,lvl:int=0):void {
			scaleX = normScale;
			scaleY = normScale;
			filters = [];
			free = false;
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
					var item:U_WarwarItemsCash = U_WarwarItemsCash(Sprite(parts[i]).getChildAt(1));
					item.frees();
				}
			}
		}
		
		public function itemUpdate(obj:Object):void {
			
			for (var i:int = 0; i < parts.length; i++) {
			   switch(true) {
				   case i == 0:
					   this.setItem(i, int(obj[0]));
					   break;
					case i == 1:
						this.setItem(i, int(obj[1]));
						break;
					case i == 2:
						this.setItem(i, int(obj[5]));
						break;
					case (i == 3 || i == 7):
						this.setItem(i, int(obj[3]))
						break;
					case (i == 14 || i == 4 || i == 11 || i == 8):
						this.setItem(i, 0);
						break;
					case (i == 10 || i == 9 || i == 6 || i == 5):
						this.setItem(i, int(obj[4]))
						break;
					case(i == 12 || i == 13 || i == 15 || i == 16):
						this.setItem(i, int(obj[2]));
						break;
			   }
			}
		}
		
		private function setItem(type:int, frame:int):void {
			if (Sprite(parts[type]).numChildren > 1) {
				var item:U_WarwarItemsCash = U_WarwarItemsCash(Sprite(parts[type]).getChildAt(1));
				if(item.getId != frame) {
					item.frees();
					Sprite(parts[type]).addChild(U_WarwarItemsCash.getItem(type, frame));
				}
				return;
			}
		   Sprite(parts[type]).addChild(U_WarwarItemsCash.getItem(type, frame));
		}
		
		
	}

}