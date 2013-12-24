package
{
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class Hero extends FlxSprite
	{
		[Embed(source='assets/hero.png')]public var heroPNG:Class;
		[Embed(source="assets/sounds/hit.mp3")]public var hitMP3:Class;
		[Embed(source="assets/sounds/ooh.mp3")]public var oohMP3:Class;
		public static var USE_KEYBOARD:int = 0
		public static var USE_ACC:int = 1
		public var controlType:int 
		private var xSpeed:Number = 100;
		private var _bl:FlxEmitter
		private var _acc:Accelerometer
		public function Hero(X:Number=0, Y:Number=0)
		{
			super(X, Y);
			this.health = 5
			

			this.loadGraphic(heroPNG, true, true, 36, 52, true);
			this.addAnimation("run5",[1,0,1,2],8);
			this.addAnimation("stand5",[1]);
			this.addAnimation("jump5",[2]);
			
			this.addAnimation("run4",[4,3,6,5],8);
			this.addAnimation("stand4",[4,6],8);
			this.addAnimation("jump4",[5]);
			
			this.addAnimation("run3",[7,8],8);
			this.addAnimation("jump3",[8]);
			this.addAnimation("stand3",[7]);
			
			this.addAnimation("run2",[9,10],6);
			this.addAnimation("jump2",[10]);
			this.addAnimation("stand2",[9]);
			
			this.addAnimation("run1",[11,12],6);
			this.addAnimation("jump1",[12]);
			this.addAnimation("stand1",[11]);
			
			this.maxVelocity.y = 280
				
			if (Accelerometer.isSupported)
			{
				controlType = USE_ACC
				_acc = new Accelerometer();
				_acc.addEventListener(AccelerometerEvent.UPDATE, this.accUpdateHandler);
			}
			else
			{
				controlType = USE_KEYBOARD
			}	
		}
		
		private var _accX:Number
		private function accUpdateHandler(e:AccelerometerEvent):void
		{
			_accX = e.accelerationX
		}
		
		
		
		override public function update():void
		{
			if(!_bl && this.health<5)
			{
				_bl =  GameState.particles.bloodP
//				_bl.at(this)
				_bl.start(false,2,0.05)
			}else
			{
				
			   if(_bl)_bl.at(this)
			}
			this.velocity.x =  0
			this.acceleration.y = 200
			if(this.controlType == USE_KEYBOARD)
			{
				if(FlxG.keys.LEFT)
				{
					this.velocity.x  = -xSpeed
					this.facing = FlxObject.LEFT
						
				}else if(FlxG.keys.RIGHT)
				{
					this.velocity.x  =  xSpeed
					this.facing = FlxObject.RIGHT
				}
				
			}else if(this.controlType == USE_ACC)
			{
				if(_accX>0)
				{
					this.velocity.x  = -xSpeed
					this.facing = FlxObject.LEFT
				}else
				{
					this.velocity.x  =  xSpeed
					this.facing = FlxObject.RIGHT
					
				}
			}
			
			if(this.velocity.x!=0 )
				if(this.velocity.y == 0)
				  this.play("run"+this.health);
				else
				  this.play("jump"+this.health);
			else
				this.play("stand"+this.health)
		}
		
		
		override public function kill():void
		{
			GameState.particles.heroHurt(this);
			super.kill()
			if(this._bl)
			{
				this._bl.kill()
				this._bl = null
			}
			if(_acc)_acc.removeEventListener(AccelerometerEvent.UPDATE, this.accUpdateHandler);
		}
		
		override public function hurt(Damage:Number):void
		{
			if(this.flickering)return;
			super.hurt(Damage);
			flicker(2)
			FlxG.play(this.oohMP3,0.8);
		}
		
		
		
	}
}