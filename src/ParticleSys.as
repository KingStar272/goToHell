package
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;

	public class ParticleSys
	{
		[Embed(source='assets/blockParticle.png')]public var blockPNG:Class
		[Embed(source='assets/heroParticle.png')]public var heroPNG:Class
		[Embed(source='assets/blood.png')]public var bloodPNG:Class
		private var _blockParticles:FlxEmitter  
		private var _heroParticles:FlxEmitter
		private var _bloodP:FlxEmitter
		
		public function ParticleSys()
		{
			this._blockParticles = new FlxEmitter(0,0,14)
			this._blockParticles.makeParticles(blockPNG,14,4,true,0)
			this._blockParticles.setXSpeed(-200,200);
		    this._blockParticles.setYSpeed(-50,300)
				
			this._heroParticles = new FlxEmitter(0,0,10)
			this._heroParticles.makeParticles(heroPNG,10,4,true,0)
			this._heroParticles.setXSpeed(-200,200);
			this._heroParticles.setYSpeed(-50,300)
				
			_bloodP = new FlxEmitter(0,0,6)
			_bloodP.makeParticles(bloodPNG,6,4,true,0);
			_bloodP.setXSpeed(-100,100)
			_bloodP.setYSpeed(50,100)
		}

		public function get bloodP():FlxEmitter
		{
			return _bloodP;
		}

		public function get heroParticles():FlxEmitter
		{
			return _heroParticles;
		}

		public function get blockParticles():FlxEmitter
		{
			return _blockParticles;
		}

		public function attachToGroup(p:FlxGroup):void
		{
			p.add(this._blockParticles);
			p.add(_bloodP)
			p.add(this._heroParticles);
		
		}
		public function blockP(p:Block):void
		{
			this._blockParticles.at(p)
			this._blockParticles.start(true,3);
			FlxG.shake(0.02,0.3)
		}
		public function heroHurt(p:Hero):void
		{
			this._heroParticles.at(p)
			this._heroParticles.start(true,3);
			FlxG.shake(0.01,0.2)
		}
		
	}
}