
amp = 1

define :metro do
  cue :tick
  sleep 0.2
end

define :start do
  with_fx :level, amp: amp do
    use_synth :prophet
    play :G3, release: 1.5
    play :G4, release: 1.5
    sleep 1.5
    play :G3, release: 1.5
    play :G4, release: 1.5
    sleep 1.5

    play :E3, release: 1.5
    play :E4, release: 1.5
    sleep 1.5
    play :E3, release: 1.5
    play :E4, release: 1.5
    sleep 1.5

    play :G3, release: 1.5
    play :G4, release: 1.5
    sleep 1.5
    play :G3, release: 1.5
    play :G4, release: 1.5
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
    sleep 0.60
  
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.40        
  end
end


define :haunting do
  with_fx :level, amp: 0.1 do
    use_synth :prophet
    play :Eb2, release: 0.40
    play :Eb3, release: 0.40
    sleep 0.40
    play :Gb2, release: 0.20
    play :Gb3, release: 0.20
    sleep 0.20
    play :Bb2, release: 0.20
    play :Bb3, release: 0.20
    sleep 0.20
    play :Gb3, release: 0.20
    play :Gb4, release: 0.20
    sleep 0.20
    play :Eb3, release: 0.50
    play :Eb4, release: 0.50
    sleep 0.50
    
    play :Eb3, release: 0.40
    play :Eb4, release: 0.40
    play :F4, release: 0.40
    sleep 0.40
    
    play :Eb3, release: 0.20
    play :Eb4, release: 0.20
    sleep 0.2
    
    play :Db3, release: 0.40
    play :Db4, release: 0.40
    sleep 0.4

    play :Db3, release: 0.40
    play :Db4, release: 0.40
    sleep 0.4
      
  
  end
end
  
#in_thread(name: :drums){  sync :start_beats; loop{drums}}
#in_thread() {start}
in_thread(name: :drums) {loop {drums}}
in_thread(name: :haunting) {loop {haunting}}