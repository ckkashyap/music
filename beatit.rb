
amp = 200

define :metro do
  cue :tick
  sleep 0.25
end

define :start do
  with_fx :level, amp: amp do
    use_synth :saw
    play :G3
    play :G4
    sleep 1.5
    play :G3
    play :G4
    sleep 1.5

    play :E3
    play :E4
    sleep 1.5
    play :E3
    play :E4
    sleep 1.5

    play :G3
    play :G4
    sleep 1.5
    play :G3
    play :G4
    sleep 1.5
    
    cue :start_beats 
  
    play :E3, release: 3
    play :E4, release: 3
    sleep 3.0    
  end
end

define :drums do
  with_fx :level, amp: amp do
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.40
  
    sample :drum_heavy_kick
    sleep 0.40
    sample :drum_cymbal_closed
    sleep 0.40
  
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.40
  
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.40
    
    
  end
end
  
#in_thread(name: :drums){  sync :start_beats; loop{drums}}
#in_thread() {start}
in_thread(name: :drums) {loop {drums}}