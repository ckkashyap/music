(ns music.core)

(import 'javax.sound.midi.MidiSystem)

(def thread-collection (atom []))

(defn add-2-thread-collection [t]
  (swap! thread-collection (fn [v] (conj v t))))


(defn stop-all []
  (doseq [t @thread-collection] (.stop t) (reset! thread-collection [])))

(def synth (. MidiSystem getSynthesizer))

(. synth open)

(def mc (. synth getChannels))

(def instr (. (. synth getDefaultSoundbank) getInstruments))


;(def yy (. synth loadInstrument (aget instr 50)))

(defn dhun [c f v] (. (aget mc c) noteOn f v))

(defn note-on [c f v] (. (aget mc c) noteOn f v))
(defn note-off [c f] (. (aget mc c) noteOff f))


(defn tune [f]
  (let [t (new Thread (fn [] (loop [] (f) (recur))))]
    (add-2-thread-collection t) (. t start)))


(def beats (fn [] (dhun 9 38 1050) (Thread/sleep 100) (dhun 9 42 1050) (Thread/sleep 100)))

(defn select-instrument [c i]
  (. (aget mc c) programChange (. (. (aget instr i) getPatch) getProgram)))

(def lead (fn [] (dhun 0 40 550) (Thread/sleep 500)))
