(
~flamingos = Array.new;
~folder = PathName.new("/Users/joseph/Desktop/flamingozan/");
~folder.entries.do({
	arg path;
	~flamingos = ~flamingos.add(Buffer.read(s,path.fullPath));
});
)
~flamingos.choose.play;

(
SynthDef.new(\Playah, {
	arg buf=0, speed=1, vol=1;
	var signal;
	signal = PlayBuf.ar(2, buf, BufRateScale.ir(buf) * speed, doneAction:2);
	signal = signal * vol;
	Out.ar(0, signal);
}).add;
)
(
SynthDef.new(\Playa, {
	arg buf=0, speed=0.5, vol=1;
	var signal;
	signal = PlayBuf.ar(2, buf, BufRateScale.ir(buf) * speed, doneAction:2);
	signal = signal * vol;
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
		\buf, Prand(~flamingos, inf),
		\speed, 0.5,
		\vol, Pseq([0.8, Pexprand(0.05, 0.3)], inf),
		\legato, Pseq([1, 0.5, 0.3], inf)
);
).fork;
)


(
Pdef(
	\melody,
	Pbind(
		\instrument, \Playa,
		\dur, Pseq([1/13], inf),
		\buf, Prand(~flamingos, inf),
		\speed, 5,
		\vol, Pseq([0.8, Pexprand(0.05, 0.3)], inf),
	);
).fork;
)
)

