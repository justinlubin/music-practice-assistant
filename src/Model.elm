module Model exposing
  ( Model
  , Msg(..)
  , init
  )

import Task
import Keyboard

import Music

type Msg
  = GenerateNewOutput

  | SetKey Music.Key
  | SetMode Music.Mode
  | SetChord Music.Chord

  | SetKeyPanelShown Bool
  | SetModePanelShown Bool
  | SetChordPanelShown Bool

  | KeyPress Keyboard.KeyCode

type alias Model =
  { key : Music.Key
  , mode : Music.Mode
  , chord : Music.Chord

  , keyPanelShown : Bool
  , modePanelShown : Bool
  , chordPanelShown : Bool
  }

init : (Model, Cmd Msg)
init =
  ( { key =
        Music.A
    , mode =
        Music.MajorMode
    , chord =
        Music.MajorChord
    , keyPanelShown =
        True
    , modePanelShown =
        True
    , chordPanelShown =
        True
    }
  , Task.perform (always GenerateNewOutput) (Task.succeed ())
  )
