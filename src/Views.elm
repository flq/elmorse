module Views exposing (..)

import Html exposing (Html, text, div, p, nav, a)
import Html.Attributes exposing (id, src, href)
import Models exposing (Model, Route, urls)
import Messages exposing (Msg)

view : Model -> Html Msg
view model =
    div [id "root"]
    [
        navigation,
        page model
    ]

navigation : Html msg
navigation =
  nav []
  [
    a [href ("#" ++ urls.typing)] [text "Type text"],
    a [href ("#" ++ urls.writing)] [text "Test your writing skills"],
    a [href ("#" ++ urls.reading)] [text "Test your reading skills"]
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