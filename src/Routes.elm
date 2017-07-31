module Routes exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Models exposing (Route(..))


matchers : Parser (Route -> a) a
matchers = oneOf
    [ 
      map Home top,
      map Typing (s "typing"),
      map Reading (s "writing-morse"),
      map Writing (s "reading-morse")
    ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute

