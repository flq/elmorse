module Views exposing (..)

import Html exposing (Html, text, div, p, nav, a)
import Html.Attributes exposing (id, src, href)
import Models exposing (Model, Route, urls)
import Views.Typing exposing (typingView)
import Views.Navigation exposing (navigation)
import Messages exposing (Msg)

view : Model -> Html Msg
view model =
    div [id "root"]
    [
        navigation model.route,
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