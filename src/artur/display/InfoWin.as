package artur.display 
{
	import artur.App;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import report.Report;
	
	public class InfoWin extends mcInfo
	{
		private var wds:Array = [70, 100, 243];
		private var delay:int = 0;
		
		private var infos:Array 
		
		public function InfoWin() 
		{
			this.mouseChildren  = false;
			this.mouseEnabled   = false;
			this.title.y = -5;
			infos = [this.hp, this.mp, this.dmg,this.f_fiz, this.f_mag, this.speed, this.inc];
			this.hideAll();
			this.filters = [new GlowFilter(0x000000,1,3,3)]
		}
		
		private function hideAll():void 
		{
			this.title.visible = false;
			this.txtInfo.visible = false;
			for (var i:int = 0; i < infos.length; i++) 
			{
				var mov:MovieClip = MovieClip(infos[i]);
				mov.visible = false;
				mov.txt1.visible = false;
				mov.txtPlus.visible = false;
				mov.txt2.visible = false;
			}
			this.price.visible = false;
		}
		
		public function init( xp:int, yp:int, data:Object):void
		{	 
			this.x = xp
			this.y = yp	
			var cur_Y:int = 0;
			this.txtInfo.textColor = 0xFFFFFF;
			if (data.title != null)
			{
				this.title.visible = true;
				this.title.txt.text = String(data.title); 
				cur_Y = 10;
			}
			switch(data.type)
			{
				case int(0):
					this.txtInfo.visible = true;
					this.txtInfo.width = data.txtInfo_w;
					this.txtInfo.htmlText = data.txtInfo_t;
					this.txtInfo.height = txtInfo.numLines * 20;
					this.txtInfo.x = this.bg.x;
					this.txtInfo.y = cur_Y;
					this.bg.width = data.txtInfo_w;
					this.bg.height = txtInfo.height + cur_Y + 5;
					break;
				case(1):
					for (var i:int = 0; i < infos.length; i++) 
					{
						var mov:MovieClip = MovieClip(infos[i]);
						mov.y = cur_Y;
						mov.visible = true;
						mov.txt1.visible = true;
						mov.txt1.text = data.chars[i];
						if (data.chars[200 + i] != null && int(data.chars[200 + i]) > 0)
						{
							mov.txt2.visible = true;
							mov.txt2.text = String(data.chars[200 + i]);
							mov.txtPlus.visible = true;
						}
						this.dmg.txt1.text = data.chars[2] + " - " + data.chars[7];
						cur_Y += 18;
					}
					this.bg.width = 236;
					this.bg.height = cur_Y + 5;
					if (data.chars[8] == 0)
					{
						this.dmg.iconRange.visible = true;
						this.dmg.iconMili.visible = false;
					}
					else
					{
						this.dmg.iconRange.visible = false;
						this.dmg.iconMili.visible = true;
					}
					break;
				case(2):
					for (var j:int = 0; j < infos.length; j++) 
					{
						if (data.chars[j] != null)
						{
							var mov1:MovieClip = this.infos[j];
							mov1.y = cur_Y;
							mov1.visible = true;
							mov1.txt1.visible = true;
							mov1.txt1.text = "+" + data.chars[j];
							this.infos[j].visible = true;
							cur_Y += 18;
							this.infos
						}
					}
					this.bg.width = 236;
					this.price.y = cur_Y;
					this.price.visible = true;
					
					if (data.bye)
					{
						this.price.txtGold.text = data.chars[101];
						this.price.txtSilver.text = data.chars[100];
					}
					else
					{
						this.price.txtGold.text = 0;
						this.price.txtSilver.text = int(data.chars[100]/2);
					}
					this.bg.height = cur_Y + price.height + 10;
					break;
			}
			  
			 /* if (dell)
			  {
				  this.delay = dell;
				  this.visible = false;
			  }*/
			  
			  
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
		public function update():void
		{
			if (delay-- < 0) 
			{
				this.visible = true;
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