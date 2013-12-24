package
{
	import flash.display.Sprite;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	
	public class GameOverState extends FlxState
	{
		[Embed(source="assets/gameOverScreen.png")]private var gameOverPNG:Class;
		[Embed(source="assets/reStartBtn.png")]private var reStartPNG:Class;
		[Embed(source="assets/returnBtn.png")]private var returnPNG:Class;
		[Embed(source="assets/number.png")]private var numberPNG:Class;
		[Embed(source="assets/sounds/cry.mp3")]public var cryMP3:Class;
		
		private var _nextState:Class;
		private var _font:FlxBitmapFont
		public static var sec:Number
		public function GameOverState()
		{
			super();
		}
		
		
		override public function create():void
		{
			FlxG.mouse.show()
			FlxG.mouse._cursorContainer.alpha = 0
			FlxG.flash(0xffff608c,0.5);
			super.create()
			var bg:FlxSprite= new FlxSprite(0,0,gameOverPNG);
			this.add(bg);
			
			
			
			var restart:FlxButton = new FlxButton(0,346,null,onRestart);
			restart.loadGraphic(reStartPNG)
			this.add(restart);
			
			var returnBtn:FlxButton = new FlxButton(FlxG.width - restart.width,346,null,onReturn);
			returnBtn.loadGraphic(returnPNG)
			this.add(returnBtn);
			
			this._font = new FlxBitmapFont(numberPNG,16,28,"0123456789.",11)
			this._font.y = 124
			//55
//			this._font.align = FlxBitmapFont.ALIGN_RIGHT
			this._font.setText((int(sec*10)/10).toString(),false,0,0,"right") 
			this._font.x  = 120 - _font.width
            this.add(_font)		
			FlxG.play(this.cryMP3);
		}
	
		
		private function onRestart():void
		{
			this._nextState = GameState
			FlxG.fade(0xffff608c,0.5,onSwitch);
		}
		private function onReturn():void
		{
			this._nextState = MainState
			FlxG.fade(0xffff608c,0.5,onSwitch);
		}
		
		
		private function onSwitch():void
		{	
			FlxG.switchState(new _nextState());
		}
		
		override public function destroy():void
		{
			super.destroy()
			this._nextState = null
		}
	}
}