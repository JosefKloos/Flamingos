s.sampleRate;

s.meter;

s.record;


//load files

(
b = Dictionary.new;
PathName("/Users/joseph/Desktop/flamingos/").entries.do{
	arg subfolder;
	b.add(
		subfolder.folderName.asSymbol ->
		Array.fill(
			subfolder.entries.size,
			{
				arg i;
				Buffer.read(s, subfolder.entries[i].fullPath);
			}
		)
	);
}
)

//Create A Synth

(
SynthDef.new(\Playah, {
	arg buf=0, speed=1, vol=1, pan=0;
	var signal;
	signal = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * speed, doneAction:2);
	signal = signal * vol;
	signal = Pan2.ar(signal, pan, vol);
	Out.ar(0, signal);

}).add;
)



//First pattern // sounds like frogs or a didgeridoo

Pbinds
(
Pdef(
	\fridgeridoo,
	Pbind(
		\instrument, \Playah,
		\dur, Pseq([1/13], inf),
		\buf, Pshuf(b[\flamingozan], inf),
		\speed, -12.midiratio,
		\vol, Pseq([0.2, Pexprand(0.05, 0.08, 0.02, 0.01,)], inf),
		\legato, Pseq([1, 0.5, 0.3], inf)
);
).play;
)

Pdef(\fridgeridoo).stop;


//Second Pattern//Ambience

Pbinds
(
Pdef(
	\ambience,
	Pbind(
		\instrument, \Playah,
		\dur, Pseq([1/200], inf),
		\stretch, 1,
		\buf, Prand(b[\flam6], inf),
		\speed, 2,
		\vol, Pseq([0.05, Pexprand(0.1, 0.2, 0.3)], inf),
		\pan, Pseq([-0.8, 0.8], inf),
	);
).play;
)

Pdef(\ambience).stop;


// Third pattern// Melody// Sounds like a flute


Pbinds
(
Pdef(
	\melody,
	Pbind(
		\instrument, \Playah,
		\dur, Pseq([1/2], inf),
		\stretch, 1,
		\buf, Pshuf(b[\flam6], inf),
		\speed, 1,
		\vol, Pseq([0.7, Pexprand(0.1, 0.2, 0.3)], inf),
		\pan, Pseq([-0.5, 0.5], inf),
	);
).play;
)

Pdef(\melody).stop;

//Fourth Pattern//Low melody

Pdef(

(
Pdef(
	\lowmelody,
	Pbind(
		\instrument, \Playah,
		\dur, Pseq([1/3], inf),
		\stretch, 1,
		\buf, Prand(b[\flam6], inf),
		\speed, 0.5,
		\vol, Pseq([0.5, Pexprand(0.1, 0.2, 0.3)], inf),
		\pan, Pseq([-0.2, 0.2], inf),
	);
).play;
)

Pdef(\lowmelody).stop;



//Fifth Pattern // Sounds like a high hat

(
Pdef(
	\highsound,
	Pbind(
		\instrument, \Playah,
		\dur, Pseq([1/7], inf),
		\stretch, 1,
		\buf, Pfunc(b[\e], inf),
		\speed,10,
		\vol, Pseq([0.5, Pexprand(0.1, 0.2, 0.3)], inf),
		\pan, Pseq([-1, 1], inf),
	);
).play;
)

Pdef(\highsound).stop;

