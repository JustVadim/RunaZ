package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	
	public class Bot2 extends PallDoll
	{
		private var heads         :Array ;
		private var bodys         :Array ;
		private var sikirs          :Array;
		private var appArmsR   :Array;
		private var hends1R     :Array;
		private var hends2R     :Array;
		private var hends1L     :Array;
		private var hends2L     :Array;
		private var legs1R       :Array;
		private var legs2R       :Array;
		private var legs3R       :Array;
		private var legs1L       :Array;
		private var legs2L       :Array;
		private var legs3L       :Array;
		private var sikirs2       :Array;
		public var type:String = 'Bot2';
		public var free:Boolean = true;
		private var isOver:Boolean = false;
		private var parts:Array ;
		private var parts_of_parts:Array;
		private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(),true)[0];
		private static var sounds:Array = [ {id:'fow1', frame:55},{ id:'bot1_fs1', frame:40 }, { id:'bot1_fs2', frame:50 }, { id:'pall_hurt', frame:78 },{id:'blade1',frame:75}];
		
		 
		public function Bot2() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh)
			heads = PrepareGr.creatBms(new ItemHeadBot2());
			bodys = PrepareGr.creatBms(new ItemBodyBot2());
			sikirs = PrepareGr.creatBms(new ItemGun1Bot2());
			appArmsR = PrepareGr.creatBms(new ItemUpArmBot2());
			hends1R  = PrepareGr.creatBms(new ItemHand1RBot2());
			hends2R  = PrepareGr.creatBms(new ItemHand2RBot2());
			hends1L  = PrepareGr.creatBms(new ItemHand1LBot2());
			hends2L  = PrepareGr.creatBms(new ItemHand2LBot2());
			legs1R =  PrepareGr.creatBms(new ItemLeg1RBot2());
			legs2R =  PrepareGr.creatBms(new ItemLeg2RBot2());
			legs3R =  PrepareGr.creatBms(new ItemLeg3RBot2());
			legs1L =  PrepareGr.creatBms(new ItemLeg1LBot2());
			legs2L =  PrepareGr.creatBms(new ItemLeg2LBot2());
			legs3L =  PrepareGr.creatBms(new ItemLeg3LBot2());
			sikirs2 =  PrepareGr.creatBms(new ItemShildBot2());
			parts = [this._head, this._body, this._sikira, this._appArmR, this._appArmL, this._hend1R, this._hend2R, this._hend2L,  this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L,_sikira2];
			parts_of_parts = [heads, bodys, sikirs, appArmsR, hends1L, hends1R, hends2R,  hends2L, legs1R, legs2R, legs3R, legs1L, legs2L, legs3L,sikirs2];
			//parts = [heads,bodys,sikirs,appArmsR,hends1R,hends2R,hends3R,appArmsL,hends1L,hends2L,hends3L];
			this._head.addChild(heads[0]);
			this._body.addChild(bodys[0]);
		    this._sikira.addChild(sikirs[0]);
			this._appArmR.addChild(appArmsR[0]);
			this._appArmL.addChild(hends1L[0]);
			
			this._hend1R.addChild(hends1R[0]);
			this._hend2R.addChild(hends2R[0]);
			this._hend2L.addChild(hends2L[0]);
			
			this._leg1R.addChild(legs1R[0]);
			this._leg2R.addChild(legs2R[0]);
			this._leg3R.addChild(legs3R[0]);
			this._leg1L.addChild(legs1L[0]);
			this._leg2L.addChild(legs2L[0]);
			this._leg3L.addChild(legs3L[0]);
			this._sikira2.addChild(sikirs2[0]);
			itemUpdate ( [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] );
		}
		 public function onWalk():void
		 {
			 //App.sound.playSound('bot1_init', App.sound.onVoice, 1);
		 }
		 public function out(e:MouseEvent=null):void 
		 {
			isOver = false;
		 }
		
		public function over(e:MouseEvent=null):void 
		{
			isOver = true;
			TweenLite.to(this, 0.25, { scaleX:1.3, scaleY:1.3} );
			App.btnOverFilter.color = 0xFFFFFF;
			this.filters = [App.btnOverFilter];
		}
		
		public function init(parr:DisplayObjectContainer=null):void
		{
			scaleX = 1;
			scaleY = 1;
			filters = [];
			free = false;
			this.gotoAndPlay('idle');
			if (parr) 
			{
				parr.addChild(this);
			}
			
		}
		public function update():void
		{
			if (!isOver && this.scaleX == 1.3)
			{
				TweenLite.to(this, 0.25, { scaleX:1, scaleY:1 } );
				this.filters = [];
			}
			for (var i:int = 0; i < sounds.length; i++) 
			{
				if (sounds[i].frame == currentFrame) 
				{
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
		}
		public function frees():void
		{
			free = true;
			gotoAndStop(1);
			if (parent) 
			{
				parent.removeChild(this);
			}
			
		}
		
		public function itemUpdate(obj:Object):void
		{
			
			for (var i:int = 0; i < parts.length; i++) 
			{
				Sprite(parts[i]).removeChildAt(1);
				switch(true)
			    {
				    case (i == 0):
					   Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[0])]);
					   break;
					case(i == 1):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[1])]);
					    break;
					case(i == 2):
					    Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[5])]);
					    break;
					case(i == 3 || i == 4):
						 Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[3])]);
					    break;
					case(i > 4 && i < 8):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[4])]);
					    break;
					case(i > 7 && i < 14):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[2])]);
					    break;
					case(i == 14):
					     Sprite(parts[14]).addChild(this.parts_of_parts[i][int(obj[6])]);
						 break;
			   }
			}
		}
		
		
	}

}