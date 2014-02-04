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
(defmethod play-note :theStrumming [{midi :pitch}] (snth/overpad midi :amp 0.2))
(defmethod play-note :theBeats1 [{midi :pitch}] (drum/kick midi))
(defmethod play-note :theBeats2 [{midi :pitch}] (drum/hat3 midi :amp 0.02))



(def beatCount 15)
(def delayBeforeStart 1/4)

(def beats1
  (->>
   (phrase (take (- beatCount 2) (cycle [12/8]))
           (take (- beatCount 2)  (cycle [0])))
   (where :time  (from delayBeforeStart))
   (where :part (is :theBeats1))))

(def beats2
  (->>
   (phrase (take (* beatCount 2)   (cycle [3/8 6/8 3/8 4/8 8/8]))
           (take (* beatCount  2) (cycle [0   nil  0  0    nil])))
   (where :time  (from delayBeforeStart))
   (where :part (is :theBeats2))))


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
   (where :time (bpm 120))
   (where :duration (bpm 120))
   (where :pitch (comp A flat minor))
   play))
