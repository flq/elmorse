module Main exposing (..)

import Navigation exposing (Location)
import Routes
import Models exposing (Model, initialModel)
import Messages exposing (Msg)
import Views exposing (view)
import Html exposing (Html, text, div, p)
import Html.Attributes exposing (id, src)

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = Routes.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main = Navigation.program Messages.OnLocationChange
    { 
        init = init, 
        view = view,
        update = update,
        subscriptions = subscriptions
    }
