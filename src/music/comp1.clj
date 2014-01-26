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



(defmethod play-note :thePart [{midi :pitch}] (sampled-piano midi :amp 0.5))
(defmethod play-note :theStrumming [{midi :pitch}] (snth/overpad midi :amp 0.2))

(def strumming
  (->>
    (phrase [   1/3 1/2 1/3 1/2 1/2 3/4 3/4 1/2 3/4 1/2]
            [   [9 12 16]  nil   nil   nil   nil   [9 12 16]   nil   nil   [9 12 16]   [ 7 11 14] ])

    (then (phrase
            [1    1/3 1/2 1/3 1/2 1/2 3/4 3/4 1/2 3/4]
            [nil   [9 12 16]  nil   nil   nil   nil   [9 12 16]   nil   nil   [ 8 11 14]  ]))


    (where :part (is :theStrumming))))


(def melody
  (->>

    (phrase [   1/3 1/2 1/3 1/2 1/2 3/4 3/4 1/2 3/4 1/2]
            [   9   9   12   11   9   9   11   9   7   2])

    (then (phrase
            [1    1/3 1/2 1/3 1/2 1/2 3/4 3/4 1/2 3/4]
            [nil 9  9   12   11   9   9   11   9   8 ]))

    (where :part (is :thePart))))

(->>
  melody
  (with strumming)
    (canon (comp (simple 0)
                 (partial where :part (is :thePart))))

  (where :time (bpm 90))
  (where :duration (bpm 90))
 (where :pitch (comp C chromatic))
  play)
