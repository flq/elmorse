module Views exposing (..)

import Html exposing (Html, text, div, p)
import Html.Attributes exposing (id, src)
import Models exposing (Model, Route)
import Messages exposing (Msg)

view : Model -> Html Msg
view model =
    div [id "root"]
    [
        p [] [text "Navigation"],
        page model
    ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.Home ->
          homeView
        Models.Typing ->
          typingView model
        Models.Reading ->
          trainingView model
        Models.Writing ->
          trainingView model
        Models.NotFoundRoute ->
          notFound

typingView : Model -> Html msg
typingView model = 
    div [id "typing"]
    [
      p [] [text "Hello from typing"]
    ]

trainingView : Model -> Html msg
trainingView model = 
    div [id "training"]
    [
      p [] [text "Hello from training"]
    ]
homeView : Html Msg
homeView = 
    div [id "home"]
    [
      p [] [text "This is home"]
    ]

notFound : Html Msg
notFound = 
    div [id "notfound"]
    [
      p [] [text "Not found"]
    ]