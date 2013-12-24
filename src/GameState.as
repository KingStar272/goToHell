package
{
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	public class GameState extends FlxState
	{
		[Embed(source="assets/topTrap.png")]private var topTrapPNG:Class;
		[Embed(source="assets/bottomTrap.png")]private var bottomTrapPNG:Class;
		[Embed(source="assets/number.png")]private var numberPNG:Class;
		[Embed(source="assets/sounds/bg_clip.mp3")]private var bgclipMP3:Class;
		
		
		public static var particles:ParticleSys ;
		private var _hero:Hero;
		private var _blockGroup:FlxGroup
		private var _particleGroup:FlxGroup
		private var _interval:Number = 2
		private var _time:Number = 0
		private var _topTrap:FlxSprite
	    private var _bottomTrap:FlxSprite
		private var _movingDown:Boolean = true    //岩浆移动标识
		private var _gameOverTimeoutID:int = -1
		private var _startTime:Number	
		private var _nativeApplication:*
		private var _font:FlxBitmapFont
		public function GameState()
		{
			
			super();
		}
		
		override public function create():void
		{
			FlxG.mouse.hide()
			FlxG.flash(0xffff608c,0.5);
			super.create();
			FlxG.bgColor = 0xff930303
			FlxG.play(bgclipMP3,1,true);
		
/*			var b:FlxSprite =new FlxSprite(-50,-50)
				b.makeGraphic(500,500,0xff930303)
			add(b)*/
			
			this._bottomTrap = new FlxSprite(0,FlxG.height-64,bottomTrapPNG);
			this.add(_bottomTrap);
			
			_blockGroup = new FlxGroup(5)
			this.add(_blockGroup)
				
			this._topTrap = new FlxSprite(0,0,topTrapPNG)
			this.add(_topTrap);
			
			
			
			
			
			_hero = new Hero(FlxG.width/2 -18,30 )
			this.add(_hero)
			
			particles = new ParticleSys()
			this._particleGroup = new FlxGroup()
			particles.attachToGroup(_particleGroup);
			this.add(_particleGroup)
			
			var bb:Block = this._blockGroup.recycle(Block) as Block
			bb.setType(1)	
			bb.reset(FlxG.width/2 - 58 ,  FlxG.height)
				
			
			this._startTime = 0
				
				
//			this._font = new FlxBitmapFont(numberPNG,16,28,"0123456789.",11)
//			this._font.y = 30
			
//			this._font.x  = 200
//			this.add(_font)			
				
		 
			try{
				//AIR版本
				var myClass:Class = getDefinitionByName("flash.desktop.NativeApplication") as Class;
				_nativeApplication = myClass.nativeApplication;
				_nativeApplication.addEventListener(Event.DEACTIVATE, deactivateHandler);
				_nativeApplication.addEventListener(Event.ACTIVATE, activateHandler);		
				_nativeApplication.systemIdleMode = Class(getDefinitionByName("flash.desktop.SystemIdleMode")).KEEP_AWAKE
					
			}catch(e:Error){
				//浏览器版本
			}
		}
		
		private function deactivateHandler(e:Event):void
		{
			FlxG.paused = true
		}
		private function activateHandler(e:Event):void
		{
			FlxG.paused = false
		}
		override public function update():void
		{
			
			if(FlxG.paused)
			{
				
				return;
			}
			
			super.update()
			
				
			if(!this._hero.alive )
			{
				if(this._gameOverTimeoutID < 0)
				{
					GameOverState.sec =this._startTime
					_gameOverTimeoutID = flash.utils.setTimeout(onGameOver,1500)
				}
			}
			
			if(this._gameOverTimeoutID < 0)
			{
				this._startTime += FlxG.elapsed;
//		    	this._font.setText(String(int(_startTime*10)/10),false,0,0) 
			}
	 
			
		
				
			FlxG.collide(this._hero, this._blockGroup,onCollide)	
//            FlxG.collide(this._blockGroup,GameState.particles.bloodP);
			
			if(this._hero.y+ this._hero.height >=this._bottomTrap.y)
			{
				this._hero.velocity.y = -500
				this._hero.hurt(1)
			}else if(this._hero.y<this._topTrap.height)
			{
				this._hero.hurt(1)
			}
			
			if(_hero.x< -18)
			{
				
				_hero.x = -18
			}
			else if(_hero.x>FlxG.width-18)
			{
			    _hero.x = FlxG.width -18;
			}
			
			this._time += FlxG.elapsed
			if(this._time>this._interval)
			{
				this._time = 0
				var b:Block = this._blockGroup.recycle(Block) as Block
				b.randomReset()
			}
				
			updateMagma() 
		}
		
		override public function destroy():void
		{
			
			if(this._nativeApplication)
			{
				_nativeApplication.removeEventListener(Event.DEACTIVATE, deactivateHandler);
				_nativeApplication.removeEventListener(Event.ACTIVATE, activateHandler);		
			}
			flash.utils.clearTimeout(this._gameOverTimeoutID)
			super.destroy()
			 
		}
		
		private function onGameOver():void
		{
			flash.utils.clearTimeout(this._gameOverTimeoutID)
			FlxG.switchState(new GameOverState())
		}
		
		private function onCollide(a:FlxObject,b:FlxObject):void
		{
			Block(b).execute(Hero(a));
		}
		
		private function updateMagma():void
		{
			if(_movingDown)
			{
				if(this._bottomTrap.y < FlxG.height - 5  )
				{
					this._bottomTrap.y += FlxG.elapsed * 30
					this._bottomTrap.x -= FlxG.elapsed * 20
				}else
				{
					this._movingDown = false
					this._bottomTrap.x = 0
				}
			}else
			{
				if(this._bottomTrap.y > FlxG.height - 40)
				{
					
					this._bottomTrap.y -= FlxG.elapsed * 30
					this._bottomTrap.x -= FlxG.elapsed * 20
				}else
				{
					this._movingDown = true
				}
			}
		}
		
	}
}