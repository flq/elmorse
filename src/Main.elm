module Main exposing (..)

import Navigation exposing (Location)
import Routes
import Models exposing (Model, initialModel)
import Messages exposing (Msg)
import Views exposing (view)

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute = Routes.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Messages.OnLocationChange location ->
      let newRoute = Routes.parseLocation location
      in ( { model | route = newRoute }, Cmd.none )

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
