define :metro do
  cue :tick
  sleep 0.75
end

define :drums do
  sync :tick
  sample :drum_heavy_kick, rate: 0.75
  sleep 0.5
  sample :drum_heavy_kick
end

define :synths do
  sync :tick
  use_synth :fm
  use_synth_defaults amp: 1, mod_range: 15, cutoff: 80, pulse_width: 0.2, attack: 0.03, release: 0.6,   mod_phase: 0.25
  play :A4
  sleep 0.25
  play :C5
  sleep 0.25
  play :E5
end

define :synths1 do
  sync :tick
  use_synth :tb303
  use_synth_defaults amp: 1, mod_range: 15, cutoff: 80, pulse_width: 0.2, attack: 0.03, release: 0.6,   mod_phase: 0.25
  play :G4
  sleep 0.25
  play :B4
  sleep 0.25
  play :D5
end


in_thread(name: :drums){loop{drums}}
in_thread(name: :synths) {loop {
  4.times  {synths} 
  4.times  {synths1}
  
}}
in_thread(name: :metro){loop{metro}}