module View exposing (view)

import Html exposing (Html, text, div, p, nav, a)
import Html.Attributes exposing (id, src, href)
import Models exposing (Model, Route, urls)
import Typing.View as Typing exposing (view)
import Training.View as Training exposing (view)
import Navigation.View as Navigation exposing (view)
import Msg exposing (Msg)

view : Model -> Html Msg
view model =
    div [id "root"]
    [
        Navigation.view model.route,
        page model
    ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.Home ->
          homeView
        Models.Typing ->
          Typing.view model
        Models.Reading ->
          trainingView model
        Models.Writing ->
          Training.view model
        Models.NotFoundRoute ->
          notFound

trainingView : Model -> Html msg
trainingView model = 
    div [id "training"]
    [
      p [] [text "Hello from training"]
    ]

homeView : Html msg
homeView = 
    div [id "home"]
    [
      p [] [text "This is home"]
    ]

notFound : Html msg
notFound = 
    div [id "notfound"]
    [
      p [] [text "Not found"]
    ]