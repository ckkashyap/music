
amp = 0.5

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
  
    cue :beat1
  
    sample :drum_bass_soft
    sleep 0.20
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.40

    sample :drum_bass_soft
    sleep 0.40
    sample :drum_cymbal_closed
    sleep 0.40

    sample :drum_bass_soft
    sleep 0.20
    sample :drum_heavy_kick
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.60

    sample :drum_bass_soft
    sleep 0.20
    sample :drum_cymbal_closed
    sleep 0.40
  end
end

def haunting_part1
  sample :drum_bass_soft, amp:1
  sample :drum_cymbal_soft, amp:2

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
  play :Eb3, release: 0.60
  play :Eb4, release: 0.60
  sleep 0.60

  play :Db3, release: 0.40
  play :Eb4, release: 0.40
  play :F4, release: 0.40
  sleep 0.40

  play :Eb3, release: 0.20
  play :Eb4, release: 0.20
  sleep 0.2

  play :Db3, release: 0.40
  play :Db4, release: 0.40
  sleep 0.4

end


define :haunting do
  with_fx :level, amp: 0.2 do
    use_synth :fm
    
    sync :beat1

    haunting_part1

    play :Db3, release: 0.60
    play :Db4, release: 0.60
    sleep 0.6

    haunting_part1

    sleep 0.4
  end
end

in_thread(name: :drums){  sync :start_beats; 4.times {drums}; cue :haunt; loop{drums}}
in_thread(name: :haunting){  sync :haunt; loop{haunting}}
in_thread() {start}
