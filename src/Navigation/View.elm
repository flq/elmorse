module Navigation.View exposing (view)

import Html exposing (Html, nav, a, text, div)
import Html.Attributes exposing (classList, href, id)
import Html.Events exposing (onClick)
import Models exposing (Route, urls)
import Msg exposing (Msg(SaveAppState))

view : Route -> Html Msg
view location =
  let
      active route = classList [("active", location == route)]
  in    
    nav []
    [
      a [
        href ("#" ++ urls.typing), 
        active Models.Typing] [text "Type text"],
      a [
        href ("#" ++ urls.writing),
        active Models.Writing] [text "Test your writing skills"],
      a [href ("#" ++ urls.reading),
        active Models.Reading] [text "Test your reading skills"],
      div [id "globalCommands"]
      [
        a [onClick SaveAppState] [text "Save current settings"]
      ]
    ]

