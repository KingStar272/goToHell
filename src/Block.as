package 
{
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	
	public class Block extends FlxSprite
	{
		[Embed(source='assets/block1.png')] public var Block1PNG:Class ;
		[Embed(source='assets/block2.png')] public var Block2PNG:Class ;
		[Embed(source='assets/block3.png')] public var Block3PNG:Class ;
		[Embed(source='assets/block4.png')] public var Block4PNG:Class ;
		[Embed(source='assets/block5.png')] public var Block5PNG:Class ;
		[Embed(source='assets/block6.png')] public var Block6PNG:Class ;
		
		[Embed(source="assets/sounds/hit.mp3")]public var hitMP3:Class;
		private var _type:int 
		private var _timeoutID:int = -1
		
		
		public function Block()
		{
			super();
			this.immovable = true
			this.allowCollisions = FlxObject.UP
				
		}
		
		public static var LAST:int = 6
		public function randomReset():void
		{
			var num:int = Math.floor(Math.random()*6)+1
			while(num==LAST) //避免重复出
			{
				num = Math.floor(Math.random()*6)+1
			}
			setType(num)	
			reset(Math.random()*(FlxG.width -136)+10 ,  FlxG.height)
			LAST = num
		}
			
		public function get type():int
		{
			return _type;
		}
		public function setType(p:int):void
		{
			if(this._type == p) return;
			
			this._type = p
			switch (this._type)
			{
				case 1: 	//正常
					this.loadGraphic(Block1PNG,false,false,116,20)
					this.offset.y = 0
					break;
				
				case 2: 	//虚
					this.loadGraphic(Block2PNG,false,false,116,20)
					this.offset.y = 0
					break;
				
				case 3:     //弹簧
					this.loadGraphic(Block3PNG,false,false,116,20)
					this.offset.y = 0
					break;
				case 4:      //左
					this.loadGraphic(Block4PNG,false,false,116,20)
					this.offset.y = 0
					break;
				case 5:    //右
					this.loadGraphic(Block5PNG,false,false,116,20)
					this.offset.y = 0
					break;
				case 6:    //刺
					this.loadGraphic(Block6PNG,false,false,116,34)
					this.offset.y = 14
					break;
			}
				
		}
		
		
		public function execute(b:FlxSprite):void
		{
			switch(this.type)
			{
				case 1:
					
					break;
				case 2:
					if(_timeoutID < 0)
					{
					  _timeoutID = flash.utils.setTimeout(this.onKill,200);
					}
					break;

				case 3:
					b.velocity.y = -200
					
					break;
				case 4:
					b.x -= FlxG.elapsed*40
					
					break;
				case 5:
					b.x += FlxG.elapsed*40
					break;
				case 6:
					if(!b.flickering)
					{
						b.hurt(1)
						b.velocity.y = -200
						//					b.x = 64
						//					b.y = 150
//						b.kill()
						//					FlxG.shake(0.01,1.3,onKill)
					}
					break;
			}
		}
		
		private function onKill():void
		{
			FlxG.play(this.hitMP3);
			GameState.particles.blockP(this); 
			this.kill()
			flash.utils.clearTimeout(_timeoutID)
			_timeoutID = -1			
		}
		
		override public function preUpdate():void
		{
			super.preUpdate()
			this.y -= 60 *FlxG.elapsed
			if(this.y+this.height < FlxG.camera.scroll.y)this.kill()
			
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X,Y);
	 
		}
		
		 
		
	}
}