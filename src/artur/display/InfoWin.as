package artur.display 
{
	import artur.App;
	import artur.win.WinCastle;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.Lang;
	import Utils.Functions;
	
	public class InfoWin extends mcInfo {
		private var wds:Array = [70, 100, 243];
		private var delay:int = 0;
		private var infos:Array;
		private var infos1:Array;
		public var titleTxtName:TextField = Functions.getTitledTextfield( -78, -9, 150, 16, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER , "", 1, Kerning.OFF, 0, true);
		public var txtInfo:TextField = Functions.getTitledTextfield( -1.5, 0.5, 237, 108.25, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, 0);
		public var txtGold:TextField = Functions.getTitledTextfield( 69, 1, 45, 18, new Art().fontName, 12, 0xFFF642, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1);
		public var txtSilver:TextField = Functions.getTitledTextfield( 159, 1, 45, 18, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1);
		
		public function InfoWin() {
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.title.y = -5;
			this.infos1 = [this.hp, this.mp, this.dmg, this.f_fiz, this.f_mag, this.speed, this.inc, this.level];
			this.infos = [addInfo(this.hp, Lang.getTitle(63)), addInfo(this.mp, Lang.getTitle(64)), addInfo(this.dmg, Lang.getTitle(65)), addInfo(this.f_fiz, Lang.getTitle(66)), addInfo(this.f_mag, Lang.getTitle(67)), addInfo(this.speed, Lang.getTitle(68)), addInfo(this.inc, Lang.getTitle(69)), addInfo(this.level, Lang.getTitle(16))];
			this.hideAll();
			this.filters = [new GlowFilter(0x000000, 1, 3, 3)]
			this.dmg.iconRange.visible = false;
			this.title.addChild(this.titleTxtName);
			this.titleTxtName.filters = [new DropShadowFilter(1, 42, 0xFFFFFF, 1, 1, 1, 0.5, 1, true), new DropShadowFilter(1, 234, 0xFFCC99, 1, 1, 1, 0.5, 1, true), new GlowFilter(0x0, 1, 3, 3, 1, 1)];
			this.txtInfo.filters = [new GlowFilter(0x0, 1, 1,1)];
			this.txtInfo.multiline = true;
			this.txtInfo.wordWrap = true;
			this.addChild(this.txtInfo);
			this.price.addChild(this.txtGold);
			this.price.addChild(this.txtSilver);
		}
		
		private function addInfo(mc:MovieClip, str:String):McInfoInfos {
			var info:McInfoInfos = new McInfoInfos(str);
			mc.addChild(info);
			return info;
		}
		
		private function hideAll():void 
		{
			this.title.visible = false;
			this.txtInfo.visible = false;
			for (var i:int = 0; i < infos.length; i++) 
			{
				MovieClip(this.infos1[i]).visible = false;
				var mov:McInfoInfos= McInfoInfos(infos[i]);
				mov.visible = false;
				mov.txt1.visible = false;
				mov.txtPlus.visible = false;
				mov.txt2.visible = false;
			}
			this.price.visible = false;
		}
		
		public function init( xp:int, yp:int, data:Object):void {	 
			this.x = xp
			this.y = yp	
			var cur_Y:int = -5;
			this.txtInfo.textColor = 0xFFFFFF;
			if (data.title != null)
			{
				this.title.visible = true;
				this.titleTxtName.text = String(data.title); 
				cur_Y = 4;
			}
			switch(data.type) {
				case int(0):
					this.txtInfo.wordWrap = true;
					this.txtInfo.visible = true;
					this.txtInfo.width = data.txtInfo_w;
					this.txtInfo.htmlText = String(data.txtInfo_t);
					this.txtInfo.height = txtInfo.numLines * 18;
					this.txtInfo.x = this.bg.x + 2;
					this.txtInfo.y = cur_Y;
					this.bg.width = data.txtInfo_w + 4;
					this.bg.height = txtInfo.height + cur_Y + 8;
					break;
				case(1):
					for (var i:int = 0; i < infos.length; i++) {
						MovieClip(infos1[i]).visible = true;
						MovieClip(infos1[i]).y = cur_Y;
						var mov:McInfoInfos = McInfoInfos(infos[i]);
						mov.visible = true;
						mov.txt1.visible = true;
						if(i!=2) {
							mov.txt1.text = data.chars[i];
						} else {
							mov.txt1.text  = data.chars[2] + " - " + data.chars[7];
						}
						if (data.chars[200 + i] != null && int(data.chars[200 + i]) > 0) {
							mov.txt2.visible = true;
							mov.txt2.text = String(data.chars[200 + i]);
							mov.txtPlus.visible = true;
						}
						cur_Y += 18;
					}
					cur_Y -= 18;
					this.level.visible = false;
					
					this.bg.width = 236;
					this.bg.height = cur_Y + 5;
					if (data.chars[8] == 1) {
						this.dmg.iconRange.visible = true;
						this.dmg.iconMili.visible = false;
					} else {
						this.dmg.iconRange.visible = false;
						this.dmg.iconMili.visible = true;
					}
					break;
				case(2):
					for (var j:int = 0; j < infos.length; j++) {
						var mov1:McInfoInfos;
						if (data.chars[j] != null || j == 7) {
							MovieClip(infos1[j]).visible = true;
							MovieClip(infos1[j]).y = cur_Y;
							mov1 = this.infos[j];
							mov1.visible = true;
							mov1.txt1.visible = true;
							if (j != 7) {
								Functions.compareAndSet(mov1.txt1, "+" + data.chars[j]);
							} else {
								var item_lvl:int = (data.chars["108"] == null)? 1:data.chars["108"];
								Functions.compareAndSet(mov1.txt1, item_lvl.toString());
								if (UserStaticData.hero.units[WinCastle.currSlotClick].lvl < item_lvl) {
									mov1.txt1.textColor = mov1.title.textColor =  0xF40000;
								} else {
									mov1.txt1.textColor = mov1.title.textColor = 0xFFFFFF;
								}
							}
							cur_Y += 18;
						}
					}
					this.bg.width = 236;
					this.price.y = cur_Y;
					this.price.visible = true;
					if (data.bye) {
						this.txtGold.text = data.chars[101];
						this.txtSilver.text = data.chars[100];
					} else {
						this.txtGold.text = "0";
						this.txtSilver.text = String(data.chars[100]/2);
					}
					this.bg.height = cur_Y + price.height + 10;
					break;
				case 3:
					this.txtInfo.visible = true;
					this.txtInfo.text = "";
					this.txtInfo.width = data.txtInfo_w;
					this.txtInfo.htmlText = Lang.getTitle(172, data.item.id);
					this.txtInfo.height = txtInfo.numLines * 18;
					this.txtInfo.x = this.bg.x + 2;
					this.txtInfo.y = cur_Y;
					this.bg.width = data.txtInfo_w + 4;
					cur_Y += this.txtInfo.height;
					if(data.bye != null) {
						this.level.visible = true;;
						this.level.y = cur_Y;
						cur_Y += this.level.height + 3;
						var mov3:McInfoInfos = McInfoInfos(infos[7]);
						var il:int = (data.item.c["108"] == null)? 1:data.item.c["108"];
						var ul:int = (data.level == null) ? 1 : data.level;
						mov3.visible = true;
						mov3.txt1.visible = true;
						mov3.txt1.text = il.toString();
						if (ul < il) {
							mov3.txt1.textColor = mov3.title.textColor =  0xF40000;
						} else {
							mov3.txt1.textColor = mov3.title.textColor = 0xFFFFFF;
						}
						this.price.y = cur_Y;
						this.price.visible = true;
						cur_Y += price.height + 10;
						this.txtGold.text = "0";
						this.txtSilver.text = String(data.item.c[100]/2);
					}
					this.bg.height = cur_Y;
					break;
			}
			  
			
			if (data.dell == null) {
				this.delay = 15;
			}
			this.scaleX = this.scaleY = 0;
			
			
			
			_1.x = bg.x; 
			_1.y = bg.y;
			_2.x = bg.width - 5; 
			_2.y = _1.y;
			_3.x = _1.x; 
			_3.y = bg.height-5;
			_4.x = _2.x; 
			_4.y = _3.y;
			topLine.width = bg.width; 
			topLine.x = bg.x; 
			topLine.y = _1.y;
			downLine.width = bg.width; 
			downLine.x = bg.x;
			downLine.y = _3.y;
			this.visible = true;
			Main.THIS.stage.addChild(this);
			this.title.x = bg.width / 2 ;
		}
		public function update():void {
			if(delay > 0) {
				delay--;
				if (delay == 0) {
					TweenLite.to(this, 0.05, {scaleX:1, scaleY: 1});
				}
			}
		}
		
		public function frees():void
		{
			if(Main.THIS.stage.contains(this))
				Main.THIS.stage.removeChild(this);
			this.hideAll();
		}
		
	}

}