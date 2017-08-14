module Controller exposing (update)

import Random

import Utils

import Model exposing
  ( Model
  , Msg(..)
  )

import Music

updateKey : Cmd Msg
updateKey =
  Random.generate
    SetKey
    Music.key

updateMode : Cmd Msg
updateMode =
  Random.generate
    SetMode
    Music.mode

updateChord : Cmd Msg
updateChord =
  Random.generate
    SetChord
    Music.chord

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GenerateNewOutput ->
      ( model
      , Cmd.batch
          [ updateKey
          , updateMode
          , updateChord
          ]
      )

    SetKey key ->
      ( { model | key = key }
      , Cmd.none
      )
    SetMode mode ->
      ( { model | mode = mode }
      , Cmd.none
      )
    SetChord chord ->
      ( { model | chord = chord }
      , Cmd.none
      )

    SetKeyPanelShown bool ->
      ( { model | keyPanelShown = bool }
      , Cmd.none
      )
    SetModePanelShown bool ->
      ( { model | modePanelShown = bool }
      , Cmd.none
      )
    SetChordPanelShown bool ->
      ( { model | chordPanelShown = bool }
      , Cmd.none
      )

    KeyPress keyCode ->
      if keyCode == Utils.spaceKeyCode then
        update GenerateNewOutput model
      else
        ( model
        , Cmd.none
        )
