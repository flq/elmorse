module Navigation.Routes exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Models exposing (Route(..), urls)

matchers : Parser (Route -> a) a
matchers = oneOf
    [ 
      map Home top,
      map Typing (s urls.typing),
      map Reading (s urls.reading),
      map Writing (s urls.writing)
    ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute

