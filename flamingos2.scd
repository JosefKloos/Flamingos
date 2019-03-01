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

b[\flamingozan][0].play;

(
SynthDef.new(\Playah, {
	arg buf=0, speed=1, vol=1, pan=0;
	var signal;
	signal = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * speed, doneAction:1);
	signal = signal * vol;
	signal = Pan2.ar(signal, pan, vol);
	Out.ar(0, signal);

}).add;
)

(
SynthDef.new(\Playa, {
	arg buf=0, speed=1, vol=1, pan=0;
	var signal;
	signal = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * speed, doneAction:1);
	signal = signal * vol;
	signal = Pan2.ar(signal, pan, vol);
	Out.ar(0, signal);

}).add;
)


(
(
Pdef(
	\rhythm,
	Pbind(
		\instrument, \Playah,
		\dur, Pseq([1/13], inf),
		\buf, Prand(b[\flamingozan], inf),
		\speed, -12.midiratio,
		\vol, Pseq([0.2, Pexprand(0.05, 0.08, 0.02, 0.01,)], inf),
		\legato, Pseq([1, 0.5, 0.3], inf)
);
).fork;
)

Pbinds
(
Pdef(
	\melody,
	Pbind(
		\instrument, \Playa,
		\dur, Pseq([1/13], inf),
		\stretch, 1,
		\buf, Prand(b[\flam6], inf),
		\speed, 1,
		\vol, Pseq([0.2, Pexprand(0.1, 0.2, 0.3)], inf),
		\pan, Pseq([-1, 1], inf),
	);
).fork;
)


playBuf

~flamingos[13].numFrames;
~flamingos[13].duration;
~flamingos[13].sampleRate;
s.sampleRate;
~flamingos[13].query;
s.meter;

PlayBuf