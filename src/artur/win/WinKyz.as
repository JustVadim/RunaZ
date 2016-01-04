package artur.win 
{
	import artur.App;
	import artur.display.BaseButton;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Som911
	 */
	public class WinKyz 
	{
		private var bg:Bitmap = RasterClip.raster(new mc_bg_kyz(), 800, 440);
		public var bin:Boolean = true;
		private var txt_stones:Array = [];
		private var btns_add:Array = [];
		private var btnStoneCreat:BaseButton;
		private var btnCraft:BaseButton;
		private var bgPrice:Sprite =  new Sprite();
		private var btnsInBg:Array = [];
		private var btnClosePrice:BaseButton =new BaseButton(31);
		public function WinKyz() 
		{
			var i:int
			var block:Sprite = new mcBlock();
			block.x = - 200;
			block.y = - 200;
			block.alpha = 0.5;
			btnClosePrice.x = 696;
			btnClosePrice.y = -7.4;
			bgPrice.addChild(block);
			bgPrice.addChild(Sprite(PrepareGr.creatBms(new bgStonePrice(), true)[0]));
			bgPrice.addChild(btnClosePrice);
			for ( i= 0; i < 9; i++) 
			{
				
			}
			 var index:int = 0;
			for ( i = 0; i < 3; i++) 
			{
				for (var j:int = 0; j < 5; j++) 
				{
					index ++;
					 var txt:TextField = Maker.getTextField(35, 20, 0xFEEE96, false, false, false, 13);
					 var btn:BaseButton = new BaseButton(44);
					 txt.x = 30;
					 txt.text = String(index);
					 btn.addChild(txt);
				     btn.x = i * 230 + btn.width/2;
					 btn.y = j * 75 + btn.height/2;
					 btn.name = String(index);
					 bgPrice.addChild(btn);
					 
					
					 txt = Maker.getTextField(35, 20, 0x0F0F0F, false, false, false, 13);
				     txt.x = 20+ i*70;
					 txt.y = 74 + j * 40;
					 txt.alpha = 1;
					 txt_stones.push(txt);
					 txt.text = "123";
					 txt.filters = [App.btnOverFilter];
					 btn = new BaseButton(41);
					 btn.x = txt.x+30;
					 btn.y =  txt.y - 8;
					 btns_add.push(btn);
				}
			}
			
			btnStoneCreat = new BaseButton(43);
			btnCraft = new BaseButton(42);
			btnStoneCreat.x = 91.5;
			btnStoneCreat.y = 26.5;
			btnCraft.x = 410.15;
			btnCraft.y = 218.35;
			bgPrice.x = 60;
			bgPrice.y = 20;
			
			btnStoneCreat.addEventListener(MouseEvent.CLICK, onCreatStone);
			btnClosePrice.addEventListener(MouseEvent.CLICK, onClosePrice);
		}
		
		private function onClosePrice(e:MouseEvent):void 
		{
			App.spr.removeChild(bgPrice);
		}
		
		private function onCreatStone(e:MouseEvent):void 
		{
				App.spr.addChild(bgPrice);
		}
		public function init():void
		{
			App.spr.addChild(bg);
			for (var i:int = 0; i < txt_stones.length; i++) 
			{
				App.spr.addChild(txt_stones[i]);
				App.spr.addChild(btns_add[i]);
			}
			App.spr.addChild(btnStoneCreat);
			App.spr.addChild(btnCraft);
			App.topPanel.init(this);
			
		}
		public function update():void
		{
			
		}
		public function frees():void
		{
			
		}
		
	}

}