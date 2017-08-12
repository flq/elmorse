module Main exposing (..)

import Update exposing (update, subscriptions)
import Navigation exposing (Location)
import Navigation.Routes as Route
import Models exposing (Model, initialModel)
import Msg exposing (Msg)  
import View exposing (view)

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = Route.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )

main : Program Never Model Msg
main = Navigation.program Msg.OnLocationChange
    { 
        init = init, 
        view = view,
        update = update,
        subscriptions = subscriptions
    }
