module View exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as JsonD

import Model exposing
  ( Model
  , Msg(..)
  )

import Music
import Utils
import Config

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

onClickSP : msg -> Html.Attribute msg
onClickSP handler =
  Events.onWithOptions
    "click"
    { stopPropagation = True
    , preventDefault = False
    }
    (JsonD.succeed handler)

option : Bool -> Html Msg -> Msg -> Html Msg
option active label onClick =
  Html.span
    [ Attr.classList
        [ ("option", True)
        , ("active", active)
        ]
    , onClickSP
        onClick
    ]
    [ label
    ]

--------------------------------------------------------------------------------
-- Key
--------------------------------------------------------------------------------

key : Music.Key -> Html Msg
key k =
  let
    keyString =
      case k of
        Music.A ->
          "A"
        Music.As ->
          Utils.flatString "B"
        Music.B ->
          "B"
        Music.C ->
          "C"
        Music.Cs ->
          Utils.sharpString "C"
        Music.D ->
          "D"
        Music.Ds ->
          Utils.flatString "E"
        Music.E ->
          "E"
        Music.F ->
          "F"
        Music.Fs ->
          Utils.sharpString "F"
        Music.G ->
          "G"
        Music.Gs ->
          Utils.sharpString "G"
  in
    Html.span
      [ Attr.class "key info"
      ]
      [ Html.text keyString
      ]

keyOption : Bool -> Html Msg
keyOption keyPanelShown =
  option
    keyPanelShown
    (Html.text "Show Key")
    (SetKeyPanelShown <| not keyPanelShown)

keyPanel : Model -> Html Msg
keyPanel model =
  Html.div
    [ Attr.id "key-panel"
    , Attr.class "panel"
    ]
    [ keyOption model.keyPanelShown
    , key model.key
    ]

--------------------------------------------------------------------------------
-- Mode
--------------------------------------------------------------------------------

mode : Music.Mode -> Html Msg
mode m =
  let
    modeString =
      case m of
        Music.MajorMode ->
          "Major"
        Music.NaturalMinorMode ->
          "Natural Minor"
        Music.HarmonicMinorMode ->
          "Harmonic Minor"
        Music.MelodicMinorMode ->
          "Melodic Minor"
  in
    Html.span
      [ Attr.class "mode info"
      ]
      [ Html.text modeString
      ]

modeOption : Bool -> Html Msg
modeOption modePanelShown =
  option
    modePanelShown
    (Html.text "Show Mode")
    (SetModePanelShown <| not modePanelShown)

modePanel : Model -> Html Msg
modePanel model =
  Html.div
    [ Attr.id "mode-panel"
    , Attr.class "panel"
    ]
    [ modeOption model.modePanelShown
    , mode model.mode
    ]

--------------------------------------------------------------------------------
-- Chord
--------------------------------------------------------------------------------

chord : Music.Chord -> Html Msg
chord c =
  let
    chordString =
      case c of
        Music.MajorChord ->
          "Major"
        Music.MinorChord ->
          "Minor"
  in
    Html.span
      [ Attr.class "chord info"
      ]
      [ Html.text chordString
      ]

chordOption : Bool -> Html Msg
chordOption chordPanelShown =
  option
    chordPanelShown
    (Html.text "Show Chord")
    (SetChordPanelShown <| not chordPanelShown)

chordPanel : Model -> Html Msg
chordPanel model =
  Html.div
    [ Attr.id "chord-panel"
    , Attr.class "panel"
    ]
    [ chordOption model.chordPanelShown
    , chord model.chord
    ]

--------------------------------------------------------------------------------
-- Main View
--------------------------------------------------------------------------------

output : Model -> Html Msg
output model =
  Html.div
    [ Attr.classList
      [ ("output", True)
      , ("simple", Config.simple)
      ]
    ] <|
    if Config.simple then
      [ key model.key
      ]
    else
      [ keyPanel model
      , modePanel model
      , chordPanel model
      ]

view : Model -> Html Msg
view model =
  Html.div
    [ Attr.id "main"
    , Events.onClick GenerateNewOutput
    ]
    [ output model
    ]
