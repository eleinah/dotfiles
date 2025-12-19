/*
This is an example startup file.
If you want to modify it, best copy it elsewhere to keep the git repository clean.

You can then load it by calling
"path/to/my/superdirt_startup.scd".load
from the supercollider startup file

The supercollider startup file is to be found in
Platform.userAppSupportDir +/+ "startup.scd",
or via the menu File > Open startup file
*/

var clockMods, clockBeats, screenW, screenH, clockW, clockH, clockX, clockY, resizable, border;

(
s.reboot { // server options are only updated on reboot
	// configure the sound server: here you could add hardware specific options
	// see http://doc.sccode.org/Classes/ServerOptions.html
	s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
	s.options.memSize = 8192 * 32; // increase this if you get "alloc failed" messages
	s.options.numWireBufs = 2048; // increase this if you get "exceeded number of interconnect buffers" messages
	s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
	s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
	s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
	// boot the server and start SuperDirt
	s.waitForBoot {
		~dirt.stop; // stop any old ones, avoid duplicate dirt (if it is nil, this won't do anything)
		~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
		~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
        ~dirt.loadSoundFiles("/home/ellie/Music/samples/tidalclub/*");
		// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
		// s.sync; // optionally: wait for samples to be read
		~dirt.start(57120, 0 ! 12);   // start listening on port 57120, create two busses each sending audio to channel 0
		SuperDirt.default = ~dirt; // make this instance available in sclang (optional)

		// optional, needed for convenient access from sclang:
		(
			~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
			~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
			~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
			~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
		);

		// directly below here, in your own copy of this file, you could add further code that you want to call on startup
		// this makes sure the server and ~dirt are running
		// you can keep this separate and make it easier to switch between setups
		// by using "path/to/my/file.scd".load and if necessary commenting out different load statements
		// ...

	


      // start superdirt first
      (
      clockMods = [4,6];
      clockBeats = 4;
      screenW = 1440;
      screenH = 900;
      clockW = 120;
      clockH = 22;
      clockX = screenW - clockW;
      clockY = screenH - 1;
      resizable = false;
      border = false;

     ~clockText = StaticText()
     .string_("[clock]")
     .font_(Font.defaultMonoFace)
     .align_(\center)
     .stringColor_(Color(1,1,1))
     .minHeight_(20);

     ~updateClock = { |cycle|
       var text, beat;
       text = clockMods.collect { |m| "" ++ (cycle.floor.asInteger.mod(m) + 1) ++ "/" ++ m; }.join(" ");
       beat = (cycle.mod(1)*clockBeats).round.asInteger + 1;
       text = text ++ " " ++ clockBeats.collect { |i| if(i < beat, ".", " "); }.join;
       ~clockText.string_(text);
     };

     ~clockWindow = Window("clock", Rect(clockX, clockY, clockW, clockH), resizable, border)
     .background_(Color(0.3,0.3,0.3))
     .layout_(
     HLayout(
         ~clockText
       ).margins_(0!4)
     );

     ~clockWindow.alwaysOnTop_(true);
     ~clockWindow.visible_(true);

     SynthDef(\tick, { |cycle|
       SendReply.kr(Impulse.kr(0), "/tick", [cycle]);
       FreeSelf.kr(Impulse.kr(0));
     }).add;

     OSCdef(\tick, { |msg|
       var cycle;
       #cycle = msg[3..];
       Routine {
         { ~updateClock.(cycle); }.defer;
       }.play(SystemClock);
     }, "/tick");
     )
  };
	  s.latency = 0.3; // increase this if you get "late" messages
};
);
