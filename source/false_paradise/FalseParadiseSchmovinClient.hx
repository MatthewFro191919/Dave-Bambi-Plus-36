/**
 * @ Author: 4mbr0s3 2
 * @ Create Time: 2021-07-16 13:48:48
 * @ Modified by: 4mbr0s3 2
 * @ Modified time: 2022-03-21 15:19:08
 */

package false_paradise;

import false_paradise.FalseParadiseMod.FalseParadiseInstance;
import false_paradise.background.CloudFlightBackground;
import false_paradise.background.FalseParadiseBackground.FalseParadiseBackgroundSprite;
import false_paradise.note_mods.NoteModArrowShape;
import false_paradise.note_mods.NoteModCounterClockwise;
import false_paradise.note_mods.NoteModDistortWiggle;
import false_paradise.note_mods.NoteModEyeShape;
import false_paradise.note_mods.NoteModReceptorScroll;
import false_paradise.note_mods.NoteModSpiral;
import false_paradise.note_mods.NoteModVibrate;
import false_paradise.note_mods.NoteModWiggle;
import false_paradise.shaders.FalseParadiseCRT;
import false_paradise.shaders.FalseParadiseGlitchy;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import groovin.shaders.GroovinShaders.SolidColorEffect;
import lime.math.Vector2;
import lime.math.Vector4;
import openfl.filters.ShaderFilter;
import schmovin.SchmovinClient;
import schmovin.SchmovinClientWithDebugger;
import schmovin.SchmovinInstance;
import schmovin.SchmovinTimeline;
import schmovin.note_mods.ISchmovinNoteMod;
import schmovin.note_mods.NoteModPerspective;
import schmovin.note_mods.NoteModRotate;
import schmovin.note_mods.NoteModTranslate;

class FalseParadiseSchmovinClient extends SchmovinClientWithDebugger
{
	var _modInstance:FalseParadiseInstance;

	override public function new(instance:SchmovinInstance, timeline:SchmovinTimeline, state:PlayState, modInstance:FalseParadiseInstance)
	{
		super(instance, timeline, state);
		_modInstance = modInstance;
	}

	function RegisterCustomMods()
	{
		addNoteMod('counterclockwise', new NoteModCounterClockwise());
		addNoteAuxMod('arrowshapeoffset');
		addNoteMod('arrowshape', new NoteModArrowShape());
		addNoteAuxMod('eyeshapeoffset');
		addNoteMod('eyeshape', new NoteModEyeShape());
		removeNoteModFromName('centerrotate');
		addNoteMod('centerrotate', new NoteModRotate('center', new Vector4(FlxG.width / 2, FlxG.height / 2)));
		addNoteAuxMod('spiraldist');
		addNoteMod('spiral', new NoteModSpiral());
		addNoteMod('wiggle', new NoteModWiggle());
		addNoteMod('vibrate', new NoteModVibrate());
		removeNoteModFromName('translation');
		addNoteMod('translation', new NoteModTranslate());
		removeNoteModFromName('perspective');
		addNoteMod('perspective', new NoteModPerspective());
		addNoteMod('receptorscroll', new NoteModReceptorScroll());
		addNoteAuxMod('distortwiggleperiod');
		addNoteAuxMod('distortwigglescratch');
		addNoteMod('distortwiggle', new NoteModDistortWiggle());
		_timeline.initializeLists();
	}

	override function initialize()
	{
		RegisterCustomMods();
		Debug();
		IntroOverlay();
		Intro();
		Section1();
		Section2();
		Breakdown();
		Section3();
		Section4();
		Section5();
		End();
		OutroOverlay();
		Glitchy();
	}

	function Debug() {}

	function IntroOverlay()
	{
		var overlayGroup = new FlxTypedGroup<FlxSprite>();
		overlayGroup.camera = _instance.camAboveGame;
		_state.add(overlayGroup);

		var dmDokuro = new FlxSprite().loadGraphic(FalseParadiseMod.GetAssetPath('overlay/dm_dokuro.png'));
		overlayGroup.add(dmDokuro);
		dmDokuro.alpha = 0;
		dmDokuro.antialiasing = true;
		dmDokuro.x = FlxG.width / 2 - dmDokuro.width / 2;
		t([3, 1], dmDokuro, 4, FlxEase.linear, {alpha: 1});

		var path = Math.random() < 0.05 ? 'overlay/flase_praadise.png' : 'overlay/false_paradise.png';
		var falseParadise = new FlxSprite().loadGraphic(FalseParadiseMod.GetAssetPath(path));
		falseParadise.alpha = 0;
		overlayGroup.add(falseParadise);
		falseParadise.antialiasing = true;
		falseParadise.x = FlxG.width / 2 - falseParadise.width / 2;
		falseParadise.y = FlxG.height / 2 - falseParadise.height / 2;
		dmDokuro.y = falseParadise.y - dmDokuro.height;

		t([3, 6], falseParadise, 4, FlxEase.linear, {alpha: 1});
		t([3, 6], falseParadise.scale, 8, FlxEase.sineInOut, {x: 1.05, y: 1.05});
		t([3, 6], dmDokuro.scale, 8, FlxEase.sineInOut, {x: 1.05, y: 1.05});

		t([8, 1], falseParadise, 8, FlxEase.sineInOut, {y: -falseParadise.height});
		t([8, 1], dmDokuro, 8, FlxEase.sineInOut, {y: -falseParadise.height});

		f([10, 1], () ->
		{
			_state.remove(overlayGroup);
		});
	}

	function OutroOverlay()
	{
		var overlayGroup = new FlxTypedGroup<FlxSprite>();
		overlayGroup.camera = _instance.camAboveGame;
		_state.add(overlayGroup);

		var thankYou = new FlxSprite().loadGraphic(FalseParadiseMod.GetAssetPath('overlay/thank_you.png'));
		thankYou.alpha = 0;
		overlayGroup.add(thankYou);
		thankYou.antialiasing = true;
		thankYou.x = FlxG.width / 2 - thankYou.width / 2;
		thankYou.y = -FlxG.height;

		t([116, 1], thankYou, 8, FlxEase.linear, {alpha: 1});
		t([116, 1], thankYou, 8, FlxEase.sineOut, {y: FlxG.height / 2 - thankYou.height / 2});
		t([116, 1], thankYou.scale, 16, FlxEase.sineInOut, {x: 1.1, y: 1.1});
		t([122, 1], thankYou, 8, FlxEase.linear, {alpha: 0});

		var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		var schmovin_logo = new FlxSprite().loadGraphic(FalseParadiseMod.GetAssetPath('overlay/vs_bob_thank_you.png'));
		black.alpha = 0;
		black.scrollFactor.set();
		schmovin_logo.alpha = 0;
		schmovin_logo.scrollFactor.set();
		schmovin_logo.screenCenter();
		f([122, 1], () ->
		{
			_instance.layerAboveGame.add(black);
			_instance.layerAboveGame.add(schmovin_logo);
		});
		f([121, 1], () ->
		{
			t([122, 1], _state.iconP1, 8, FlxEase.linear, {alpha: 0});
			t([122, 1], _state.scoreTxt, 8, FlxEase.linear, {alpha: 0});
			t([122, 1], _state.iconP2, 8, FlxEase.linear, {alpha: 0});
			t([122, 1], _state.healthBar, 8, FlxEase.linear, {alpha: 0});
			t([122, 1], _state.healthBarBG, 8, FlxEase.linear, {alpha: 0});
		});
		t([122, 1], black, 8, FlxEase.linear, {alpha: 1}, (t) ->
		{
			_instance.layerBelowGame.clear();
		});
		t([124, 1], schmovin_logo, 8, FlxEase.linear, {alpha: 0.01});
	}

	function Intro()
	{
		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		func(4, () ->
		{
			var clouds = new CloudFlightBackground(!this._modInstance.optionDisableBGShader);
			clouds.scrollFactor.set();
			clouds.alpha = 0;
			_state.remove(_modInstance.bg);
			_state.remove(_modInstance.stageCurtains);
			_state.remove(_modInstance.stageFront);
			_instance.layerBelowGame.add(clouds);
			_instance.layerAboveHUD.add(white);
			_tween.tween(white, {alpha: 0}, 2);

			clouds.alpha = 1;
		});
		s([2, 1], 1, 'camgameoverride', 0);
		s([2, 1], -800, 'camgameoverridey', 0);
		s([2, 1], -1, 'reverse');

		e([9, 1], 4, FlxEase.sineOut, 0, 'camgameoverridey', 0);
		e([9, 1], 4, FlxEase.sineOut, 0, 'reverse');

		e([10, 1], 2, FlxEase.sineInOut, 0, 'camgameoverride', 0);

		var kickpattern = [1, 5, 9, 12, 15];
		var kickpattern2 = [1, 5, 9, 15];

		var alt = 0;
		for (bar in 10...13)
		{
			for (step in kickpattern)
			{
				s([bar, step], this.alt(alt), 'tipsy');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'tipsy');
				s([bar, step], this.alt(alt) * 30, 'x');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'x');
				alt++;
			}
		}
		for (step in kickpattern2)
		{
			s([13, step], this.alt(alt), 'tipsy');
			e([13, step], 1, FlxEase.cubeOut, 0, 'tipsy');
			s([13, step], this.alt(alt) * 30, 'x');
			e([13, step], 1, FlxEase.cubeOut, 0, 'x');
			alt++;
		}
		for (bar in 14...17)
		{
			for (step in kickpattern)
			{
				s([bar, step], this.alt(alt), 'tipsy');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'tipsy');
				s([bar, step], this.alt(alt) * 30, 'x');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'x');
				alt++;
			}
		}

		var gfPath = 'mod:mod_assets/FalseParadiseMod/weeks/gf/GF_sign_language';
		var gfASL = new FlxSprite();
		gfASL.frames = FlxAtlasFrames.fromSparrow('${gfPath}.png', '${gfPath}.xml');
		gfASL.animation.addByPrefix('asl', 'GF ASL', 24, false);
		gfASL.offset.set(-392, -139);
		gfASL.antialiasing = true;
		gfASL.visible = true;
		f([1, 1], () ->
		{
			gfASL.visible = false;
		});
		// This'll be behind the stage but since there's no background in the camGameCopy it'll still be visible lol
		_state.add(gfASL);
		f([17, 9], () ->
		{
			gfASL.visible = true;
			gfASL.animation.play('asl');
			_state.gf.visible = false;
		});
		f([18, 1], () ->
		{
			gfASL.visible = false;
			_state.gf.visible = true;
		});

		var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		black.scrollFactor.set();

		s([17, 1], 100, 'camgameoverridex');
		e([17, 1], 4, FlxEase.circInOut, 1, 'camgameoverride');
		e([17, 1], 4, FlxEase.circInOut, 1, 'camgamezoom');

		e([17, 1], 1, FlxEase.cubeOut, 1, 'tipsy');
		e([17, 1], 1, FlxEase.cubeOut, 1, 'drunk');

		s([18, 1], 0, 'camgamezoom');
		s([18, 1], 0, 'camgameoverride');

		var fillPattern = [3, 4, 6, 7, 9, 10, 12, 14, 15, 16];

		var shaderOn = false;
		for (step in fillPattern)
		{
			shaderOn = !shaderOn;
			if (shaderOn)
			{
				f([17, step], () ->
				{
					_instance.layerAboveGame.add(black);
				});
			}
			else
			{
				f([17, step], () ->
				{
					_instance.layerAboveGame.remove(black);
				});
			}
		}

		f([18, 1], () ->
		{
			_instance.layerAboveGame.remove(black);
			_instance.layerBelowGame.add(black);
		});

		f([18, 1], () ->
		{
			_instance.layerBelowGame.clear();
			white.alpha = 1;
			_tween.tween(white, {alpha: 0}, 2);
		});
	}

	function Section1()
	{
		f([18, 1], () ->
		{
			var noise = new FalseParadiseBackgroundSprite(true);
			noise.scrollFactor.set();
			_instance.layerBelowGame.add(noise);
		});

		s([18, 1], 0.2, 'tipsy');
		s([18, 1], 0.2, 'drunk');

		var p0Center = FlxG.width / 2 - 50 - Note.swagWidth * 2;
		var p1Center = -50 - Note.swagWidth * 2;
		s([18, 1], p0Center, 'x', 0);
		s([18, 1], p1Center + FlxG.width * 2, 'x', 1);

		var kickpattern4 = [[1, 3], [4, 3], [7, 3], [10, 2], [12, 1], [13, 2], [15, 2]];
		var kickpattern5 = [[1, 3], [4, 2], [6, 3], [9, 3], [12, 2], [14, 3]];
		var kickpattern6 = [[1, 3], [4, 3], [7, 3], [10, 2], [12, 2], [14, 3]];
		var kickpattern5bars = [21, 29];
		var kickpattern6bars = [25, 33];

		e([25, 9], 1, FlxEase.circInOut, p0Center - FlxG.width * 2, 'x', 0);
		e([25, 9], 1, FlxEase.circInOut, p1Center, 'x', 1);

		var alt = 0;
		for (bar in 18...34)
		{
			var player = bar >= 26 ? 1 : 0;
			e([bar, 1], 1, FlxEase.sineInOut, 0, 'drunk', player);
			e([bar, 1], 0.25, FlxEase.sineInOut, 0, 'confusionzoffset');
			if (kickpattern5bars.contains(bar))
			{
				for (entry in kickpattern5)
				{
					var step = entry[0];
					var length = entry[1] / 4.0;
					e([bar, step], 0.25, FlxEase.sineInOut, this.alt(alt) * 0.2, 'confusionzoffset', player);
					e([bar, step], length, FlxEase.circOut, this.alt(alt) * 40, 'xoffset', player);
					s([bar, step], 0.5, 'tinyy', player);
					s([bar, step], -0.5, 'tinyx', player);
					e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyy', player);
					e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyx', player);
					alt++;
				}
				continue;
			}
			else if (kickpattern6bars.contains(bar))
			{
				for (entry in kickpattern6)
				{
					var step = entry[0];
					var length = entry[1] / 4.0;
					e([bar, step], 0.25, FlxEase.sineInOut, this.alt(alt), 'confusionzoffset', player);
					e([bar, step], 0.25, FlxEase.sineInOut, this.alt(alt), 'drunk', player);
					e([bar, step], length, FlxEase.elasticOut, this.alt(alt) * 90, 'xoffset', player);
					s([bar, step], 0.5, 'tinyy', player);
					s([bar, step], -0.5, 'tinyx', player);
					e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyy', player);
					e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyx', player);
					alt++;
				}
				continue;
			}
			for (entry in kickpattern4)
			{
				var step = entry[0];
				var length = entry[1] / 4.0;
				e([bar, step], length, FlxEase.sineInOut, this.alt(alt) * 0.5, 'drunk', player);
				e([bar, step], length, FlxEase.circOut, this.alt(alt) * 40, 'xoffset', player);
				s([bar, step], 0.5, 'tinyy', player);
				s([bar, step], -0.5, 'tinyx', player);
				e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyy', player);
				e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyx', player);
				alt++;
			}
		}
		f([34, 1], () ->
		{
			_instance.layerBelowGame.clear();
		});
	}

	function Section2()
	{
		if (IsEasyModo())
		{
			s([34, 1], 0, 'drunk');
			s([34, 1], 0, 'tipsy');
			s([34, 1], 0, 'wiggle');
		}

		s([33, 13], 100, 'camgameoverridex');
		e([33, 13], 1, FlxEase.sineInOut, 1, 'camgameoverride');

		var gfSign = new FlxSprite();
		if (IsEasyModo())
		{
			var gfPath = 'mod:mod_assets/FalseParadiseMod/weeks/gf/GF_assets_easy_modo';
			gfSign.frames = FlxAtlasFrames.fromSparrow('${gfPath}.png', '${gfPath}.xml');
			gfSign.animation.addByPrefix('sign', 'GF sign easy modo instance 1', 24, false);
		}
		else
		{
			var gfPath = 'mod:mod_assets/FalseParadiseMod/weeks/gf/GF_assets_sign_ilvg';
			gfSign.frames = FlxAtlasFrames.fromSparrow('${gfPath}.png', '${gfPath}.xml');
			gfSign.animation.addByPrefix('sign', 'GF sign ILVG instance 1', 24, false);
		}
		gfSign.offset.set(-392, -139);
		gfSign.antialiasing = true;
		gfSign.visible = true;
		f([1, 1], () ->
		{
			gfSign.visible = false;
		});
		// This'll be behind the stage but since there's no background in the camGameCopy it'll still be visible lol
		_state.add(gfSign);
		f([33, 15], () ->
		{
			gfSign.visible = true;
			gfSign.animation.play('sign');
			_state.gf.visible = false;
		});
		f([34, 9], () ->
		{
			gfSign.visible = false;
			_state.gf.visible = true;
		});

		e([34, 1], 0.5, FlxEase.sineInOut, 0, 'xoffset');
		e([34, 1], 0.5, FlxEase.sineInOut, 0, 'x');
		e([34, 1], 0.5, FlxEase.sineInOut, 0, 'confusionzoffset');
		e([34, 3], 1, FlxEase.sineInOut, -0.5, 'reverse');

		s([34, 9], 0, 'reverse');

		var leftRightPatterns = [[9, 1], [10, -1], [12, 1], [13, -1], [15, 1], [17, 0]];
		for (bar in [34, 36, 38, 40])
		{
			for (pattern in leftRightPatterns)
			{
				e([bar, pattern[0]], 0.5, FlxEase.circOut, 50 * pattern[1], 'x', 0);
				s([bar, pattern[0]], -1, 'tinyx', 0);
				s([bar, pattern[0]], 1, 'tinyy', 0);
				e([bar, pattern[0]], 0.5, FlxEase.circOut, 0, 'tinyx', 0);
				e([bar, pattern[0]], 0.5, FlxEase.circOut, 0, 'tinyy', 0);
			}
		}
		for (bar in [42, 44, 46, 48])
		{
			for (pattern in leftRightPatterns)
			{
				e([bar, pattern[0]], 0.5, FlxEase.circOut, 50 * pattern[1], 'x', 1);
				s([bar, pattern[0]], -1, 'tinyx', 1);
				s([bar, pattern[0]], 1, 'tinyy', 1);
				e([bar, pattern[0]], 0.5, FlxEase.circOut, 0, 'tinyx', 1);
				e([bar, pattern[0]], 0.5, FlxEase.circOut, 0, 'tinyy', 1);
			}
		}

		e([33, 13], 1, FlxEase.sineIn, 0.3, 'camgamezoom');
		e([34, 1], 1.5, FlxEase.sineOut, 1, 'camgamezoom');
		e([34, 7], 1.5, FlxEase.sineInOut, 0, 'camgamezoom');

		e([34, 7], 1.5, FlxEase.sineInOut, 0, 'camgameoverride');

		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		f([34, 9], () ->
		{
			var clouds = new CloudFlightBackground(!this._modInstance.optionDisableBGShader);
			_instance.layerBelowGame.clear();
			_instance.layerBelowGame.add(clouds);

			_instance.layerAboveHUD.add(white);
			white.alpha = 1;
			_tween.tween(white, {alpha: 0}, 2);
		});

		var alt = 0;
		e([33, 9], 4, FlxEase.quartInOut, 1, 'wiggle');
		for (bar in 33...42)
		{
			e([bar, 9], 4, FlxEase.quartInOut, alt * Math.PI, 'rotatex', 0);
			alt++;
		}
		alt = 0;
		for (bar in 41...48)
		{
			alt++;
			e([bar, 9], 4, FlxEase.quartInOut, (alt - 1) * Math.PI, 'rotatex', 1);
		}
		e([48, 9], 2, FlxEase.quartIn, alt * Math.PI - Math.PI / 2, 'rotatex', 1);
		alt++;
		e([49, 1], 4, FlxEase.linear, alt * Math.PI + Math.PI, 'rotatex', 1);
	}

	function IsEasyModo()
	{
		return PlayState.storyDifficulty == 0;
	}

	function Breakdown()
	{
		if (!IsEasyModo())
		{
			var falseParadiseCRT = new FalseParadiseCRT();
			f([50, 1], () ->
			{
				_instance.camGameCopy.setFilters([new ShaderFilter(falseParadiseCRT.shader)]);
				_instance.camNotes.setFilters([new ShaderFilter(falseParadiseCRT.shader)]);
			});
			t([50, 1], falseParadiseCRT, 32, FlxEase.linear, {time: 20}, null, (t) ->
			{
				falseParadiseCRT.update();
			});
			t([57, 1], falseParadiseCRT, 4, FlxEase.circIn, {resolutionX: FlxG.width, resolutionY: FlxG.height}, null);
			f([58, 1], () ->
			{
				_instance.camGameCopy.setFilters(null);
				_instance.camNotes.setFilters(null);
			});
		}

		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		f([58, 1], () ->
		{
			_instance.layerAboveHUD.add(white);
			white.alpha = 1;
			_tween.tween(white, {alpha: 0}, 2);
		});

		f([50, 1], () ->
		{
			_instance.layerBelowGame.clear();
			_instance.layerAboveHUD.add(white);
			white.alpha = 1;
			_tween.tween(white, {alpha: 0}, 2);
		});

		s([50, 1], 0, 'wiggle');
		s([50, 1], 0, 'drunk');
		s([50, 1], 0, 'tipsy');
		s([50, 1], 0, 'rotatez');
		s([50, 1], 0, 'rotatex');

		s([50, 1], 1, 'receptorscroll');

		e([57, 1], 4, FlxEase.cubeInOut, 0, 'receptorscroll');

		// Vibrato

		s([50, 9], 0, 'distortwigglescratch', 0);
		e([50, 9], 4, FlxEase.sineIn, 15, 'distortwigglescratch', 0);
		e([50, 9], 2, FlxEase.sineInOut, 1, 'distortwiggle', 0);
		e([51, 9], 0.5, FlxEase.sineInOut, 0.2, 'distortwiggle', 0);
		e([51, 9], 1, FlxEase.sineIn, 0, 'distortwigglescratch', 0);

		e([52, 13], 3, FlxEase.sineIn, 15, 'distortwigglescratch', 0);
		e([52, 13], 2, FlxEase.sineInOut, 2, 'distortwiggle', 0);
		e([53, 9], 0.5, FlxEase.sineInOut, 0.2, 'distortwiggle', 0);
		e([53, 9], 1, FlxEase.sineIn, 0, 'distortwigglescratch', 0);

		s([54, 1], 0, 'distortwigglescratch', 1);
		e([54, 1], 2, FlxEase.sineIn, 5, 'distortwigglescratch', 1);
		e([54, 1], 0.5, FlxEase.sineInOut, 2, 'distortwiggle', 1);
		e([54, 9], 0.5, FlxEase.sineInOut, 0.2, 'distortwiggle', 1);
		e([54, 9], 1, FlxEase.sineIn, 0, 'distortwigglescratch', 1);

		e([54, 13], 3, FlxEase.sineIn, 5, 'distortwigglescratch', 1);
		e([54, 13], 1, FlxEase.sineInOut, 1, 'distortwiggle', 1);
		e([55, 9], 2, FlxEase.sineInOut, 0.2, 'distortwiggle', 1);
		e([55, 9], 2, FlxEase.sineIn, 0, 'distortwigglescratch', 1);

		e([56, 1], 0.25, FlxEase.sineInOut, 3, 'distortwiggle', 1);
		e([56, 1], 3, FlxEase.quadOut, 5, 'distortwigglescratch', 1);
		e([56, 2], 4, FlxEase.sineIn, 0.2, 'distortwiggle', 1);
		e([56, 12], 1, FlxEase.sineIn, 0, 'distortwigglescratch', 1);

		e([57, 1], 2, FlxEase.sineIn, 5, 'distortwigglescratch', 1);
		e([57, 1], 1, FlxEase.sineInOut, 3, 'distortwiggle', 1);
		e([57, 9], 2, FlxEase.sineInOut, 0.2, 'distortwiggle', 1);
		e([57, 1], 2, FlxEase.sineIn, 0, 'distortwigglescratch', 1);

		e([62, 1], 2, FlxEase.sineInOut, 3, 'distortwiggle');
		e([62, 13], 1, FlxEase.sineInOut, 1, 'distortwiggle');
		e([63, 1], 0.5, FlxEase.sineInOut, 0.2, 'distortwiggle');
		e([63, 1], 1, FlxEase.sineIn, 0, 'distortwigglescratch');

		// End vibrato

		var kickPattern = [
			1, 7, 13, 3 + 16, 5 + 16, 11 + 16, 15 + 16, 1 + 32, 7 + 32, 13 + 32, 3 + 48, 5 + 48, 11 + 48, 13 + 48, 1 + 64, 7 + 64, 13 + 64, 3 + 80, 7 + 80,
			11 + 80, 13 + 80, 1 + 96, 7 + 96, 13 + 96
		];

		var altKick = 0;
		for (step in kickPattern)
		{
			e([58, step], 1, FlxEase.circOut, alt(altKick + 1) * 0.5, 'rotatey');

			s([58, step], -1, 'tinyx');
			s([58, step], 1, 'tinyy');
			e([58, step], 0.75, FlxEase.sineOut, 0, 'tinyx');
			e([58, step], 0.75, FlxEase.sineOut, 0, 'tinyy');

			s([58, step], 3, 'wiggle');
			e([58, step], 0.75, FlxEase.sineOut, 1, 'wiggle');

			s([58, step], alt(altKick) * 50, 'x');
			e([58, step], 0.75, FlxEase.sineOut, 0, 'x');

			s([58, step], 1, 'drunk');
			e([58, step], 0.75, FlxEase.backInOut, 0, 'drunk');
			altKick++;
		}

		for (bar in [59, 61])
		{
			for (i in 0...4)
			{
				e([bar, 1 + 4 * (i - 1)], 1, FlxEase.elasticOut, Math.PI * 2 / 4 * (i + 1), 'confusionzoffset');
			}
		}

		e([64, 12], 1, FlxEase.sineInOut, 0, 'wiggle');
		e([64, 12], 1, FlxEase.sineInOut, 0, 'tipsy');
		e([65, 1], 0.25, FlxEase.sineInOut, 0, 'rotatey');

		e([64, 13], 0.5, FlxEase.sineOut, -0.5 * FlxG.height, 'z');
		e([64, 15], 0.5, FlxEase.sineIn, 0, 'z');
		e([65, 1], 0.1, FlxEase.sineInOut, 0.1 * FlxG.height, 'z');
		e([65, 2], 0.25, FlxEase.sineOut, 0, 'z');

		var fillPattern = [3, 4, 6, 7, 9, 10, 12, 14, 15, 16];

		var shaderOn = false;
		var black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		for (step in fillPattern)
		{
			shaderOn = !shaderOn;
			e([65, step], 0.25, FlxEase.sineOut, shaderOn ? 1 : 0, 'invert');
			if (shaderOn)
			{
				f([65, step], () ->
				{
					_instance.layerAboveGame.add(black);
				});
			}
			else
			{
				f([65, step], () ->
				{
					_instance.layerAboveGame.remove(black);
				});
			}
		}
	}

	function Section3()
	{
		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		f([66, 1], () ->
		{
			_instance.layerBelowGame.clear();
			_instance.layerAboveHUD.add(white);
			white.alpha = 1;
			_tween.tween(white, {alpha: 0}, 2);
		});

		f([66, 1], () ->
		{
			var noise = new FalseParadiseBackgroundSprite(true);
			noise.scrollFactor.set();
			_instance.layerBelowGame.add(noise);
		});

		var kickpattern = [1, 5, 9, 12, 15];
		var kickpattern2 = [1, 5, 9, 15];

		var alt = 0;
		for (bar in 66...69)
		{
			for (step in kickpattern)
			{
				s([bar, step], this.alt(alt), 'tipsy');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'tipsy');
				s([bar, step], this.alt(alt) * 30, 'x');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'x');
				alt++;
			}
		}
		for (step in kickpattern2)
		{
			s([69, step], this.alt(alt), 'tipsy');
			e([69, step], 1, FlxEase.cubeOut, 0, 'tipsy');
			s([69, step], this.alt(alt) * 30, 'x');
			e([69, step], 1, FlxEase.cubeOut, 0, 'x');
			alt++;
		}
		for (bar in 70...78)
		{
			for (step in kickpattern)
			{
				s([bar, step], this.alt(alt), 'tipsy');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'tipsy');
				s([bar, step], this.alt(alt) * 30, 'x');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'x');
				alt++;
			}
		}
		for (bar in 78...81)
		{
			for (step in [1, 5, 9, 13])
			{
				s([bar, step], this.alt(alt), 'tipsy');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'tipsy');
				s([bar, step], this.alt(alt) * 30, 'x');
				e([bar, step], 1, FlxEase.cubeOut, 0, 'x');
				alt++;
			}
		}

		// "Inspired" by UKSRT9 Stage 4a (https://www.youtube.com/watch?v=F69zEKYVLHE&t=42s)
		var solidWhite = new SolidColorEffect(FlxColor.WHITE);
		var solidWhiteShaderFilter = new ShaderFilter(solidWhite.shader);

		s([66, 1], 1, 'beat');

		var columnSwapPattern = [9, 12, 15, 17];

		function AddToggleInvert(alt:Int, barstep:Array<Float>, player:Int)
		{
			if (!IsEasyModo())
			{
				f(barstep, () ->
				{
					if ((alt + 1) % 2 == 1)
						_instance.camNotes.setFilters([solidWhiteShaderFilter]);
					else
						_instance.camNotes.setFilters(null);
				});
				e(barstep, 0.25, FlxEase.sineOut, (alt + 1) % 2, 'invert', player);
			}
			e(barstep, 0.25, FlxEase.sineOut, (alt + 1) % 2 * Math.PI / 2, 'confusionzoffset', player);
		}

		for (bar in [66, 67, 68, 70, 71, 72])
		{
			var alt = 0;
			for (step in columnSwapPattern)
			{
				AddToggleInvert(alt, [bar, step], 0);
				alt++;
			}
		}
		for (bar in [69])
		{
			var alt = 0;
			for (step in [1, 7, 15, 17])
			{
				AddToggleInvert(alt, [bar, step], 0);
				alt++;
			}
		}

		if (!IsEasyModo())
		{
			e([69, 1], 1.5, FlxEase.circOut, Math.PI, 'rotatey', 0);
			e([69, 7], 2, FlxEase.circOut, 0, 'rotatey', 0);
		}

		for (bar in [73])
		{
			var alt = 0;
			for (step in [1, 5, 7, 11, 14, 17])
			{
				AddToggleInvert(alt, [bar, step], 0);
				alt++;
			}
		}
		for (bar in [74, 75, 76])
		{
			var alt = 0;
			for (step in columnSwapPattern)
			{
				AddToggleInvert(alt, [bar, step], -1);
				alt++;
			}
		}
		for (bar in [77])
		{
			var alt = 0;
			for (step in [1, 7, 15, 17])
			{
				AddToggleInvert(alt, [bar, step], -1);
				alt++;
			}
		}

		if (!IsEasyModo())
		{
			e([77, 1], 1.5, FlxEase.circOut, Math.PI, 'rotatey');
			e([77, 7], 2, FlxEase.circOut, 0, 'rotatey');
		}

		for (bar in [78, 79, 80])
		{
			var alt = 0;
			for (step in [5, 9, 12, 16])
			{
				AddToggleInvert(alt, [bar, step], -1);
				alt++;
			}
		}
		var p1Center = -50 - Note.swagWidth * 2;

		e([81, 1], 4, FlxEase.sineIn, -FlxG.width * 2, 'x', 0);
		for (bar in [81])
		{
			var alt = 0;
			for (step in [1, 4, 7, 10])
			{
				e([bar, step], 0.25, FlxEase.backOut, p1Center * alt * 0.25, 'x', 1);
				e([bar, step], 0.25, FlxEase.backOut, 0.2 * this.alt(alt), 'rotatez', 1);
				s([bar, step], 0.5, 'tinyy', 1);
				s([bar, step], -0.5, 'tinyx', 1);
				e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyy', 1);
				e([bar, step + 1], 0.25, FlxEase.sineOut, 0, 'tinyx', 1);
				alt++;
			}
		}
		f([81, 1], () ->
		{
			_instance.layerBelowGame.clear();
		});

		s([81, 1], 0, 'beat');

		e([81, 1], 0.5, FlxEase.circOut, 0.5, 'camgamezoom');
		e([81, 4], 0.5, FlxEase.circOut, 1, 'camgamezoom');
		e([81, 7], 0.5, FlxEase.circOut, 1.5, 'camgamezoom');
		e([81, 10], 0.5, FlxEase.circOut, 2, 'camgamezoom');
		e([81, 13], 0.5, FlxEase.circOut, 2.5, 'camgamezoom');
		e([81, 13], 0.5, FlxEase.circInOut, 0, 'camgamezoom');

		e([81, 9], 2, FlxEase.circIn, Math.PI * 4, 'rotatey');

		e([81, 9], 2, FlxEase.circIn, Math.PI * 4, 'rotatey');
		s([82, 4], 0, 'rotatey');

		e([81, 13], 0.25, FlxEase.backOut, p1Center, 'x', 1);
		e([81, 13], 0.25, FlxEase.backOut, 0, 'rotatez', 1);
		s([81, 13], 0.5, 'tinyy', 1);
		s([81, 13], -0.5, 'tinyx', 1);
		e([81, 14], 0.25, FlxEase.sineOut, 0, 'tinyy', 1);
		e([81, 14], 0.25, FlxEase.sineOut, 0, 'tinyx', 1);
	}

	function Glitchy()
	{
		var falseParadiseGlitchy = new FalseParadiseGlitchy();

		f([82, 1], () ->
		{
			_instance.camGameCopy.setFilters([_instance.planeRaymarcherFilter, new ShaderFilter(falseParadiseGlitchy.shader)]);
			_instance.camNotes.setFilters([new ShaderFilter(falseParadiseGlitchy.shader)]);
		});
		t([82, 1], falseParadiseGlitchy, 128, FlxEase.linear, {time: 20}, null, (t) ->
		{
			falseParadiseGlitchy.update();
		});
		t([110, 1], falseParadiseGlitchy, 16, FlxEase.linear, {chromaticAberration: 0.03}, null);
	}

	function Section4()
	{
		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		f([82, 1], () ->
		{
			_instance.layerBelowGame.clear();
			white.alpha = 1;
			_tween.tween(white, {alpha: 0}, 2);
		});

		e([81, 15], 1, FlxEase.circInOut, 0, 'x', 1);

		e([81, 15], 1, FlxEase.circInOut, 1, 'camgameoverride');
		e([81, 15], 1, FlxEase.circInOut, 70, 'camgameoverridex');
		e([81, 15], 1, FlxEase.circInOut, 140, 'camgameoverridey');

		e([81, 13], 1, FlxEase.circInOut, 1, 'wiggle', -1);
		e([81, 15], 1, FlxEase.circInOut, -Math.PI / 2, 'centerrotatez', -1);
		e([81, 15], 1, FlxEase.backInOut, 1, 'arrowshape', 1);

		e([81, 15], 1, FlxEase.circInOut, 1, 'camgamerm');
		e([81, 15], 1, FlxEase.circInOut, 1, 'camgamermx');
		e([81, 15], 1, FlxEase.circInOut, 0, 'camgamermy');

		e([84, 1], 1, FlxEase.circInOut, 0, 'camgamermx');
		e([84, 1], 1, FlxEase.circInOut, 1, 'camgamermy');
		e([84, 1], 1, FlxEase.circInOut, 0, 'centerrotatez', -1);

		e([85, 1], 1, FlxEase.circInOut, 0, 'camgamermx');
		e([85, 1], 1, FlxEase.circInOut, -1, 'camgamermy');
		e([85, 1], 1, FlxEase.circInOut, Math.PI, 'centerrotatex', -1);

		e([86, 1], 1, FlxEase.circInOut, -1, 'camgamermx');
		e([86, 1], 1, FlxEase.circInOut, 0, 'camgamermy');
		e([86, 1], 1, FlxEase.circInOut, 0, 'centerrotatex', -1);
		e([86, 1], 1, FlxEase.circInOut, Math.PI / 2, 'centerrotatez', -1);

		e([88, 1], 1, FlxEase.circInOut, 0, 'camgamermx');
		e([88, 1], 1, FlxEase.circInOut, 1, 'camgamermy');
		e([88, 1], 1, FlxEase.circInOut, 0, 'centerrotatez', -1);

		e([89, 1], 1, FlxEase.circInOut, -1, 'camgamermy');
		e([89, 1], 1, FlxEase.circInOut, Math.PI, 'centerrotatez', -1);

		var gfPath = 'mod:mod_assets/FalseParadiseMod/weeks/gf/GF_assets_sign_fnfsrt';

		var gfSign = new FlxSprite();
		gfSign.frames = FlxAtlasFrames.fromSparrow('${gfPath}.png', '${gfPath}.xml');
		gfSign.animation.addByPrefix('sign', 'GF sign', 24, false);
		gfSign.offset.set(-392, -139);
		gfSign.antialiasing = true;
		gfSign.visible = true;
		f([1, 1], () ->
		{
			gfSign.visible = false;
		});
		_state.add(gfSign);
		f([89, 15], () ->
		{
			gfSign.visible = true;
			gfSign.animation.play('sign');
			_state.gf.visible = false;
		});
		f([90, 9], () ->
		{
			gfSign.visible = false;
			_state.gf.visible = true;
		});

		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		f([90, 9], () ->
		{
			_instance.layerAboveHUD.add(white);
			_tween.tween(white, {alpha: 0}, 2);
		});

		var camGameRmSpiralTime = {
			time: 0.0,
			amp: 0.8,
		};
		t([90, 9], camGameRmSpiralTime, 28, FlxEase.linear, {time: 28.0}, null, (t) ->
		{
			_timeline.getNoteMod('camgamermx').setLegacyPercent(Math.sin(camGameRmSpiralTime.time) * camGameRmSpiralTime.amp, 0);
			_timeline.getNoteMod('camgamermy').setLegacyPercent(Math.cos(camGameRmSpiralTime.time) * camGameRmSpiralTime.amp, 0);
		});
		t([97, 9], camGameRmSpiralTime, 2, FlxEase.sineOut, {time: 30.0, amp: 0.0}, null, (t) ->
		{
			_timeline.getNoteMod('camgamermx').setLegacyPercent(Math.sin(camGameRmSpiralTime.time) * camGameRmSpiralTime.amp, 0);
			_timeline.getNoteMod('camgamermy').setLegacyPercent(Math.cos(camGameRmSpiralTime.time) * camGameRmSpiralTime.amp, 0);
		});

		e([89, 13], 2, FlxEase.sineInOut, 100, 'camgameoverridex');
		e([89, 13], 2, FlxEase.sineInOut, 0, 'camgameoverridey');

		e([89, 13], 1, FlxEase.sineIn, 0.3, 'camgamezoom');
		e([89, 9], 2, FlxEase.circInOut, 0, 'camgamermx');
		e([89, 9], 2, FlxEase.circInOut, 0, 'camgamermy');

		e([90, 1], 1.5, FlxEase.sineOut, 1, 'camgamezoom');
		e([90, 7], 1.5, FlxEase.sineInOut, 0, 'camgamezoom');

		e([90, 7], 1, FlxEase.sineInOut, 70, 'camgameoverridex');
		e([90, 7], 1, FlxEase.sineInOut, 140, 'camgameoverridey');

		e([89, 12], 2, FlxEase.circIn, 1 * FlxG.height, 'z', 1);
		e([90, 1], 1, FlxEase.circInOut, 0, 'arrowshape', -1);
		e([90, 9], 1, FlxEase.circInOut, 0, 'z', 1);
		e([90, 9], 1, FlxEase.sineOut, 1, 'spiral', 1);

		e([94, 1], 4, FlxEase.circInOut, 160 * 0.7 * 0.3, 'spiraldist');

		e([96, 1], 4, FlxEase.circInOut, 0, 'spiraldist');

		e([97, 9], 2, FlxEase.elasticOut, 0, 'spiral');
		e([97, 9], 4, FlxEase.elasticOut, 0, 'x');
		e([97, 13], 2, FlxEase.elasticOut, 0, 'centerrotatez');
	}

	function Section5()
	{
		e([98, 1], 4, FlxEase.sineInOut, 0, 'camgameoverride');

		e([98, 1], 4, FlxEase.elasticOut, 0.25, 'counterclockwise', 1);
		e([101, 1], 4, FlxEase.elasticOut, 0, 'counterclockwise');
		e([102, 1], 4, FlxEase.elasticOut, 0.25, 'counterclockwise', 0);

		e([102, 1], 4, FlxEase.elasticOut, 0.75, 'flip', 0);
		e([102, 1], 4, FlxEase.elasticOut, 0.75, 'invert', 0);
		e([102, 1], 4, FlxEase.elasticOut, 1, 'invert', 1);

		e([104, 1], 4, FlxEase.elasticOut, 0, 'flip', 0);
		e([104, 1], 4, FlxEase.elasticOut, 0, 'invert');
		e([104, 1], 4, FlxEase.elasticOut, 0, 'counterclockwise');

		var swapPattern = [1, 4, 7, 10, 12, 15];
		for (step in swapPattern)
		{
			s([105, step], -1, 'tinyx');
			s([105, step], 1, 'tinyy');
			e([105, step], 0.75, FlxEase.sineOut, 0, 'tinyx');
			e([105, step], 0.75, FlxEase.sineOut, 0, 'tinyy');
		}

		e([105, 1], 0.75, FlxEase.circOut, 0, 'wiggle');
		e([105, 1], 0.75, FlxEase.circOut, 1, 'invert');
		e([105, 4], 0.75, FlxEase.circOut, 0.75, 'flip');
		e([105, 4], 0.75, FlxEase.circOut, 0.75, 'invert');
		e([105, 7], 0.75, FlxEase.circOut, -1, 'invert');
		e([105, 7], 0.75, FlxEase.circOut, 1, 'flip');
		e([105, 10], 0.5, FlxEase.circOut, -0.75, 'invert');
		e([105, 10], 0.5, FlxEase.circOut, 0.25, 'flip');
		e([105, 12], 0.75, FlxEase.circOut, 0, 'invert');
		e([105, 12], 0.75, FlxEase.circOut, 0.5, 'flip');
		e([105, 15], 0.5, FlxEase.circOut, 0.0, 'flip');
		e([105, 15], 0.75, FlxEase.circOut, 0.2, 'wiggle');

		s([106, 1], 1, 'arrowpath');
		e([106, 1], 4, FlxEase.elasticOut, -FlxG.width, 'x', 0);

		if (PlayState.storyDifficulty == 2)
			e([106, 1], 4, FlxEase.elasticOut, 1, 'counterclockwise');
		else
		{
			e([106, 1], 4, FlxEase.elasticOut, 0.5, 'counterclockwise');
			e([106, 1], 4, FlxEase.elasticOut, -200, 'x', 1);
		}

		e([110, 1], 4, FlxEase.elasticOut, 0, 'counterclockwise');
		e([110, 1], 4, FlxEase.elasticOut, 0, 'x');
		s([110, 1], 0, 'arrowpath');
		e([109, 9], 4, FlxEase.circInOut, 0, 'eyeshape', 1);

		e([113, 8], 8, FlxEase.sineIn, 1, 'camgameoverride');
		e([113, 8], 8, FlxEase.sineIn, -FlxG.height, 'camgameoverridey');
		e([110, 1], 16, FlxEase.circIn, 10, 'vibrate');
	}

	function End()
	{
		var white = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		f([114, 1], () ->
		{
			var clouds = new CloudFlightBackground(!this._modInstance.optionDisableBGShader);
			clouds.scrollFactor.set();
			clouds.alpha = 0;
			_instance.camGameCopy.setFilters(null);
			_instance.camNotes.setFilters(null);
			_instance.layerBelowGame.add(clouds);
			_instance.layerAboveHUD.add(white);
			_tween.tween(white, {alpha: 0}, 2);

			clouds.alpha = 1;
		});
		s([114, 1], -FlxG.height, 'y', 0);
		e([114, 1], 1, FlxEase.circOut, 0, 'vibrate');
		e([114, 1], 15, FlxEase.circIn, FlxG.height * 2, 'y', 1);
		e([114, 1], 48, FlxEase.sineInOut, -9, 'centerrotatex', 1);
		e([114, 1], 48, FlxEase.sineInOut, 9, 'centerrotatey', 1);
		s([114, 1], 1, 'arrowpath0', 1);
		e([114, 1], 4, FlxEase.elasticOut, 1, 'eyeshape', 1);
	}
}
