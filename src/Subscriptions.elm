module Subscriptions exposing (subscriptions)

import Keyboard

import Model exposing (Model, Msg)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.presses Model.KeyPress
    ]
