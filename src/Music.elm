module Music exposing
  ( Key(..), key
  , Mode(..), mode
  , Chord(..), chord
  )

import Random

import Utils

--------------------------------------------------------------------------------
-- Keys
--------------------------------------------------------------------------------

type Key
  = A
  | As
  | B
  | C
  | Cs
  | D
  | Ds
  | E
  | F
  | Fs
  | G
  | Gs

keys : List Key
keys =
  [ A
  , As
  , B
  , C
  , Cs
  , D
  , Ds
  , E
  , F
  , Fs
  , G
  , Gs
  ]

key : Random.Generator Key
key =
  Utils.selectWithDefault A keys

--------------------------------------------------------------------------------
-- Modes
--------------------------------------------------------------------------------

type Mode
  = MajorMode
  | NaturalMinorMode
  | HarmonicMinorMode
  | MelodicMinorMode

modes : List Mode
modes =
  [ MajorMode
  , NaturalMinorMode
  , HarmonicMinorMode
  , MelodicMinorMode
  ]

mode : Random.Generator Mode
mode =
  Utils.selectWithDefault MajorMode modes

--------------------------------------------------------------------------------
-- Chords
--------------------------------------------------------------------------------

type Chord
  = MajorChord
  | MinorChord

chords : List Chord
chords =
  [ MajorChord
  , MinorChord
  ]

chord : Random.Generator Chord
chord =
  Utils.selectWithDefault MajorChord chords
