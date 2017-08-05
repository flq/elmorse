module Main exposing (..)

import Update exposing (update)
import Navigation exposing (Location)
import Routes
import Models exposing (Model, initialModel)
import Msg exposing (Msg)  
import Views exposing (view)

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = Routes.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main = Navigation.program Msg.OnLocationChange
    { 
        init = init, 
        view = view,
        update = update,
        subscriptions = subscriptions
    }
