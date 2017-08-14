module Main exposing (main)

import Html

import Model exposing (Model, Msg)

import Controller
import Subscriptions
import View

main :  Program Never Model Msg
main =
  Html.program
    { init =
        Model.init
    , view =
        View.view
    , update =
        Controller.update
    , subscriptions =
        Subscriptions.subscriptions
    }
