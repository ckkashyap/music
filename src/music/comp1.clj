(ns music.comp1
  (:use
   overtone.inst.sampled-piano
   leipzig.melody
   leipzig.scale
   leipzig.canon
   leipzig.live)
  (:require [overtone.live :as overtone]
            [overtone.inst.drum :as drum]
            [overtone.inst.synth :as snth]
            [overtone.synth.stringed :as strings]))

(defmethod play-note :thePart [{midi :pitch}] (snth/overpad midi :amp 0.2))
(defmethod play-note :theBeats1 [{midi :pitch}] (drum/kick midi))
(defmethod play-note :theBeats2 [{midi :pitch}] (drum/hat3 midi :amp 0.02))

(def g (strings/guitar))

(def updownmap {
                81 :up
                83 :down
                84 :up
                86 :down
                88 :up
                89 :down
                })
(def amgmap {
                81 :Am
                83 :Am
                84 :G
                86 :G
                88 :E
                89 :E7
                })

(defmethod play-note :theStrumming [{midi :pitch}] (strings/guitar-strum g (amgmap midi) (updownmap midi) 0.101) (println midi))

(def beatCount 20)
(def delayBeforeStart 1/4)

(def beats1
  (->>
   (phrase (take (- beatCount 2) (cycle [12/8]))
           (take (- beatCount 2) (cycle [0])))
   (where :time  (from delayBeforeStart))
   (where :part (is :theBeats1))))

(def beats2
  (->>
   (phrase (take (* beatCount 2)   (cycle [3/8 6/8 3/8 4/8 8/8]))
           (take (* beatCount  2) (cycle [0   nil  0  0    nil])))
   (where :time  (from delayBeforeStart))
   (where :part (is :theBeats2))))

(def chords
  (->>
   (phrase (take (* beatCount 2)   (cycle [3/8   6/8   3/8  4/8  8/8]))
           [
            0 nil 1 0 nil 0 nil 1 0 nil 0 nil 1 3 nil 2 nil 3 2 nil
            0 nil 1 0 nil 0 nil 1 0 nil 0 nil 1 5 nil 4 nil 5 4 nil
            ]
           )
   (where :time  (from delayBeforeStart))
   (where :part (is :theStrumming))))


(def melody
  (->>
   (phrase [  4/8  5/8   4/8  6/8  6/8  9/8  9/8  6/8   8/8  6/8 ]
           [  0    0     2    1    0    0    1    0     -1   -4  ])


   (then (phrase
           [ 4    4/8  5/8   4/8  6/8  6/8  9/8  9/8  6/8   8/8 ]
           [ nil  0    0     2    1    0    0    1    0     -1/2  ]))

   (where :time  (from delayBeforeStart))
   (where :part (is :thePart))))




(defn doit [] 
  (->>
   melody
   (with beats1)
   (with beats2)
   (with chords)
   (where :time (bpm 120))
   (where :duration (bpm 120))
   (where :pitch (comp high A  minor))
   play))
