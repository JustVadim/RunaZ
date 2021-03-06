package artur.display.battle {
	
	import artur.App;
	import artur.display.battle.eff.BaseEff;
	import artur.display.battle.eff.EffManajer;
	import artur.display.battle.eff.TextEff;
	import artur.units.BotGolem;
	import artur.util.Amath;
	import artur.win.WinBattle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class MoveUnit {
		private var path:Array;
		private var step:int = 0;
		private var speedX:Number;
		private var speedY:Number;
		private var move:Boolean = false;
		public var bin:Boolean = false;
		public var unit:MovieClip;
		private var timer:Timer = new Timer(2, 1);
		public var cur_obj:Object;
		public var otherAnim:Boolean = false;
		private var arrow:mcAtackArrow = new mcAtackArrow();
		private var is_range:Boolean = true;
		private var type:int;
		private static const arrow_speed:Number = 30.0;
		private var arrow_anim:int = 0;
		private var temp_attack:Object;
		
		 
		public function MoveUnit() {
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeTime);
		}
		
		private function completeTime(e:TimerEvent):void {
			WinBattle.inst.makeStep();
		}
		
		public function init(path:Array, obj:Object, is_range:Boolean, type:int):void {
			WinBattle.bat.is_ult = false;
			this.is_range = is_range;
			this.type = type;
			this.unit = MovieClip(WinBattle.currUnit);
			this.cur_obj = obj;
			this.temp_attack = null;
			if (this.cur_obj.a != null && this.cur_obj.a.b[4] != null) {
				this.temp_attack = this.cur_obj.a.b[4];
			}
			this.bin = true;
			this.otherAnim = false;
			WinBattle.arrow.visible = false; WinBattle.arrow.stop();
			WinBattle.inst.grid.clearNodesControl();
			WinBattle.inst.removeUltEvents();
			this.path = path;
			//unit.onWalk();
			if (this.path.length >= 2) {
				unit.gotoAndPlay('run');
			}
			
		}
		
		public function update():void {
			if (this.bin) {
				if (this.otherAnim == false) {
					var is_run:Boolean = (this.unit.currentLabel == "run");
					if (step == 0 && (path.length - 1) > 0) {
						this.onStepMake(is_run);
					} else if (step > 0) {
						this.onUnitMove(is_run);
					} else {
						if (is_run) {
							this.unit.x = this.path[0].x;
							this.unit.y = this.path[0].y + 10;
							if (LifeManajer.bin) {
								LifeManajer.unpateCurrMove(cur_obj.m.u.t, cur_obj.m.u.p);
							}
						}
						if (this.cur_obj.a == null) {
							this.frees();
						} else {
							if (this.unit.currentLabel != "atack1" && this.arrow_anim == 0) {
								this.makeAttack();
							} else {
								this.attackAnim();	
							}
						}
					}
				}
			} else {
				if (!timer.running && WinBattle.anim.length > 0) {
					if (WinBattle.anim[0].m != null && WinBattle.anim[0].m.u.t == WinBattle.myTeam) {
						WinBattle.inst.makeStep();
					} else {
						if (String(WinBattle.bat.ids[1]).substr(0, 3) == "bot") {
							timer.reset();
							timer.start();
						} else {
							WinBattle.inst.makeStep();
						}
					}
				}
			}
		}
		
		private function attackAnim():void {
			if (this.arrow_anim == 0) {
				this.unit.nextFrame();
				this.magEffect();
				if (this.unit.currentFrame == 1) {
					unit.rotation = 0;
					if (this.is_range) {
						if (this.type == 2 || this.type == 103) {
							var attack_unit:Object = WinBattle.units[cur_obj.m.u.t][cur_obj.m.u.p];
							var hurt_unit1:MovieClip  = WinBattle.units[cur_obj.a.u.t][cur_obj.a.u.p];
							WinBattle.spr.addChild(this.arrow);
							this.arrow.x = unit.x + (22 * unit.scaleX);
							this.arrow.y = this.unit.y - 27;
							var unit_dist:Number = Amath.distance(arrow.x, arrow.y, hurt_unit1.x, hurt_unit1.y - 30);
							this.arrow.rotation = Amath.getAngleDeg(arrow.x, arrow.y, hurt_unit1.x, hurt_unit1.y - 30,true);
							this.arrow_anim = int(unit_dist / MoveUnit.arrow_speed);
							this.speedX = arrow_speed *  Math.cos(Amath.toRadians(arrow.rotation));
							this.speedY = arrow_speed * Math.sin(Amath.toRadians(arrow.rotation));
						} else if(this.type == 3 || this.type == 107) {
							this.arrow_anim = 2;
						}
					} else {
						if (this.cur_obj.a.b[2] != null) {
							this.cur_obj.a = this.cur_obj.a.b[2];
						} else if (this.temp_attack != null) {
							this.unit = WinBattle.units[this.cur_obj.a.u.t][this.cur_obj.a.u.p];
							this.cur_obj.a = temp_attack;
							TextEff(EffManajer.getEff('text')).init(this.unit.x, this.unit.y - 60, String("Отдача"), 0x00FF40);
							
							this.temp_attack = null;
						} else {
							this.frees();
						}
					}
				}
			} else if (this.arrow_anim > 1) {
				if (type == 2 || type == 103)
				{
					arrow.x += speedX;
					arrow.y += speedY;
				} else if (type == 3 || this.type == 107) {
					EffManajer.lgs.update();
				}
				arrow_anim--;
			} else {
				this.arrow_anim = 0;
				this.unit.dispatchEvent(new Event("ATTACK"));
				if(type == 2 || type == 103) {
					WinBattle.spr.removeChild(this.arrow);
				} else if (type == 3 || type == 107) {
					if(EffManajer.lgs.parent) {
						EffManajer.lgs.parent.removeChild(EffManajer.lgs);
					}
				}
				
				if (this.cur_obj.a.b[2] != null) {
					this.cur_obj.a = this.cur_obj.a.b[2];
					delete(this.cur_obj.a.b[2]);
				} else {
					this.frees();
				}
			}
		
		}
		
		private function magEffect():void 
		{
			if (this.type == 3 || this.type == 107)
				{
					if (this.unit.currentFrame == 59)
					{
						var hurt_unit2:MovieClip  = WinBattle.units[cur_obj.a.u.t][cur_obj.a.u.p];
						EffManajer.showLgs(30, WinBattle.spr, 0xFFFFFF, unit.x+20, unit.y - 71, hurt_unit2.x, hurt_unit2.y-40);
						EffManajer.lgs.update();
					}
					else if (this.unit.currentFrame > 59)
					{
						EffManajer.lgs.update();
					}
				}
		}
		
		private function makeAttack():void {
			var hurt_unit:MovieClip  = WinBattle.units[cur_obj.a.u.t][cur_obj.a.u.p];
			if (cur_obj.a.b[2] != null) {
				TextEff(EffManajer.getEff('text')).init(this.unit.x, this.unit.y - 60, String("Двойная Aтака"), 0x00FF40);
			}
			this.unit.gotoAndStop("atack1");
			this.unit.addEventListener("ATTACK", this.onAttack);
			this.unit.scaleX = (this.unit.x > hurt_unit.x)? -this.unit.normScale:this.unit.normScale; 	
			hurt_unit.scaleX =  this.unit.scaleX * ( -1);
			hurt_unit.scaleX = (hurt_unit.scaleX < 0) ? -hurt_unit.normScale:hurt_unit.normScale;
			
			if (this.unit.y == hurt_unit.y) {
				if (WinBattle.spr.getChildIndex(unit) < WinBattle.spr.getChildIndex(hurt_unit)) {
					WinBattle.spr.swapChildren(hurt_unit, this.unit);
				}
			} else {
				if (this.type != 3 && this.type != 107) {
					this.unit.rotation = (hurt_unit.y > this.unit.y) ? 25: -25;
					this.unit.rotation *= this.unit.scaleX;
				}
				this.unit.shawdow.visible = false;
			}
		}
		
		private function onUnitMove(is_run:Boolean):void {
			if (is_run) {
				unit.x += speedX;
				unit.y += speedY;
				if(LifeManajer.bin)
					LifeManajer.unpateCurrMove(cur_obj.m.u.t, cur_obj.m.u.p);
				WinBattle.sortSpr();
			}
			this.step--;
		}
		
		private function onStepMake(is_run:Boolean):void {
			var st:Node = path.shift();
			if (WinBattle.currUnit is BotGolem) {
				this.step = 14;
			}
			else {
				this.step = 9
			}
			if (is_run) {
				this.speedX = (path[0].x - st.x) / (this.step + 1);
				this.speedY = (path[0].y - st.y) / (this.step + 1);
				if (this.speedX < 0){
					this.unit.scaleX = -this.unit.normScale;
				} else {
					this.unit.scaleX = this.unit.normScale;;
				}
				this.unit.x += this.speedX;
				this.unit.y += this.speedY;
				if(LifeManajer.bin) {
					LifeManajer.unpateCurrMove(cur_obj.m.u.t, cur_obj.m.u.p);
				}
			}
		}
		
		private function onAttack(e:Event):void {
			unit.removeEventListener(e.type, onAttack);
			var pos:int = cur_obj.a.u.p;
			var t:int = cur_obj.a.u.t;
			var hurt_unit:MovieClip  = WinBattle.units[t][pos];
			
			if (cur_obj.a.b[1] != null) {
				TextEff(EffManajer.getEff('text')).init(hurt_unit.x, hurt_unit.y - 80, String("Промах"), 0x80FF00);
			} else {
				var hps:Object = WinBattle.bat.hps[t];
				hps[pos] = cur_obj.a.ll;
				LifeManajer.un_Data[t][pos].currLife = hps[pos];
				if (LifeManajer.bin) {
					LifeManajer.updateCurrLife(t,pos);
				}
				if (hps[pos] > 0) {
					hurt_unit.gotoAndPlay("hurt");
				} else {
					hurt_unit.gotoAndPlay("die");
					hurt_unit.addEventListener("DIE", onUnitDie);
					for (var i:int = 0; i < WinBattle.sortArr.length; i++) {
						if (WinBattle.sortArr[i] == hurt_unit) {
							WinBattle.sortArr.splice(i, 1);
							break;
						}
					}
					WinBattle.bat.map.grid[cur_obj.a.x][cur_obj.a.y].id = 0;
					Node(WinBattle.inst.grid.nodes[cur_obj.a.x][cur_obj.a.y]).walcable = 0;
					WinBattle.units[t][pos] = null;
				}
				BaseEff(EffManajer.getEff('base')).init(hurt_unit);
				if (cur_obj.a.b[0] != null) {
					TextEff(EffManajer.getEff('text')).init(hurt_unit.x, hurt_unit.y - 60, String("2хУрон"), 0xF75757);
					TextEff(EffManajer.getEff('text')).init(hurt_unit.x, hurt_unit.y - 40, String('-' + cur_obj.a.d), 0xF75757);
				} else if (cur_obj.a.b[3] != null) {
					TextEff(EffManajer.getEff('text')).init(hurt_unit.x, hurt_unit.y - 60, String("Сквозь Броню"), 0xF75757);
					TextEff(EffManajer.getEff('text')).init(hurt_unit.x, hurt_unit.y - 40, String('-' + cur_obj.a.d), 0xF75757);
				} else {
					TextEff(EffManajer.getEff('text')).init(hurt_unit.x, hurt_unit.y - 60, String('-' + cur_obj.a.d), 0xF75757);
				}
			}
		}
		
		public function onUnitDie(e:Event):void 
		{
			var mc:MovieClip = MovieClip(e.target);
			mc.removeEventListener(e.type, onUnitDie);
			mc.frees();
			/*for (var i:int = 0; i < WinBattle.sortArr.length; i++) 
			{
				if (mc == WinBattle.sortArr[i])
					WinBattle.sortArr.splice(i, 1);
			}*/
		}
		
		public function frees():void {
			bin = false;
			if(unit.currentFrameLabel!= "idle") {
				unit.gotoAndPlay('idle');
			}
			WinBattle.inst.setCurrStep();
			
		}
		
	}

}