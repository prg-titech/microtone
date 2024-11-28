module harmonics where

open import Data.Nat
open import Data.Integer
open import Data.Bool
open import Data.Product
open import Data.List
open import Relation.Nullary

-- Accidental of Note
data Accidental : Set where
  ♯ : Accidental
  ♭ : Accidental
  ♮ : Accidental
  𝄪 : Accidental
  𝄫 : Accidental

-- Natural Notes
data NatNote : Set where
  C : Note
  D : Note
  E : Note
  F : Note
  G : Note
  A : Note
  B : Note


record Note : Set where
  constructor note
  field
    accidental : Accidental
    natnote : NatNote
    octave : ℕ

toSemitoneNat : NatNote -> ℕ
toSemitoneNat C = 0
toSemitoneNat D = 2
toSemitoneNat E = 4
toSemitoneNat F = 5
toSemitoneNat G = 7
toSemitoneNat A = 9
toSemitoneNat B = 11


toSemitone : Note -> ℕ
toSemitone (record {accidental = 𝄫 ; NatNote = n ; octave = k}) = 12 * k + toSemitoneNat(n) - 2
toSemitone (record {accidental = ♭ ; NatNote = n ; octave = k}) = 12 * k + toSemitoneNat(n) - 1
toSemitone (record {accidental = ♮ ; NatNote = n ; octave = k}) = 12 * k + toSemitoneNat(n)
toSemitone (record {accidental = ♯ ; NatNote = n ; octave = k}) = 12 * k + toSemitoneNat(n) + 1
toSemitone (record {accidental = 𝄪 ; NatNote = n ; octave = k}) = 12 * k + toSemitoneNat(n) + 2


-- m denotes the "minor", M denotes the "major", P denotes the "perfect", D denotes the "diminishied", A denotes the "augmented"
data Interval : Set where
  P1 : Interval -- Base
  m2 : Interval
  M2 : Interval
  m3 : Interval
  M3 : Interval
  P4 : Interval
  D5 : Interval
  P5 : Interval
  A5 : Interval
  M6 : Interval
  m7 : Interval
  M7 : Interval


IntervalToInt : Interval -> ℕ
IntervalToInt P1 = 0
IntervalToInt m2 = 1
IntervalToInt M2 = 2
IntervalToInt m3 = 3
IntervalToInt M3 = 4
IntervalToInt P4 = 5
IntervalToInt D5 = 6
IntervalToInt P5 = 7
IntervalToInt A5 = 8
IntervalToInt M6 = 9
IntervalToInt m7 = 10
IntervalToInt M7 = 11

IntToInterval : ℕ -> Interval
IntToInterval n with n mod 12
... | 0 = P1
... | 1 = m2
... | 2 = M2
... | 3 = m3
... | 4 = M3
... | 5 = P4
... | 6 = D5
... | 7 = P5
... | 8 = A5
... | 9 = M6
... | 10 = m7
... | 11 = M7

record tInterval : Set where
  constructor tinterval
  field
    interval : Interval
    octave : ℕ


GetInterval : Note -> Note -> tInterval
GetInterval (record {}) = {} -- todo : find interval of two notes


GetPureInterval : tInterval -> Note -> Note -- todo : find the note with interval and the base note




-- chord structure

-- II min maj7 sus4
-- chord (II Min major-seventh sus4)


-- chord types
-- Scale Degree

-- data ChordClass : Set where

data ChordDegreeClass : Set where
  I : ChordDegreeClass
  II : ChordDegreeClass
  III : ChordDegreeClass
  IV : ChordDegreeClass
  V : ChordDegreeClass
  VI : ChordDegreeClass
  VII : ChordDegreeClass

data ChordBaseClass : Set where
  Maj : ChordClass      -- P1, M3, P5
  Min : ChordClass      -- P1, m3, P5
  Aug : ChordClass      -- P1, M3, A5
  Dim : ChordClass      -- P1, m3, d5
  -- and some more if needed...

data ChordElevateClass : Set where
  fifth : ChordElevateClass -- Normal
  sixth : ChordElevateClass -- sixth chord (II6)
  seventh : ChordElevateClass -- seventh chord (I7)
  major-seventh : ChordElevateClass -- Major seventh chord (III+7)
  ninth : ChordElevateClass -- ninth chord (IV9) - added 7th, 9th note
  eleventh : ChordElevateClass -- eleventh class - added 7th, 9th, 11th note and so on...
  -- and some more if needed...

data ChordSustainClass : Set where
  sus3 : ChordSustainClass -- Normal state
  sus2 : ChordSustainClass -- change second note to 2nd
  sus4 : ChordSustainClass -- change second note to 4th
  -- and some more if needed...




-- Diatonic chord
record Chord : Set where
  constructor chord
  field
    chordDegree : ChordDegreeClass
    chordBase : ChordBaseClass
    chordElevate : ChordElevateClass
    chordSustain : ChordSustainClass


data Modal : Set where -- necessary?
  Ionian : Modal
  Dorian : Modal
  Phrygian : Modal
  Lydian : Modal
  Mixolydian : Modal
  Aeolian : Modal
  Locrian : Modal

record Key : Set where
  constructor key
  field
    chord : Chord
    modal : Modal


-- Tonic Subtonic Dom Subdom ...
-- 