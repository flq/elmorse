module Views.Navigation exposing (navigation)

import Html exposing (Html, nav, a, text)
import Html.Attributes exposing (classList, href)
import Models exposing (Route, urls)

navigation : Route -> Html msg
navigation location =
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
        active Models.Reading] [text "Test your reading skills"]
    ]

