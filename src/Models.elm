module Models exposing (..)

type Route
  = Home
  | Typing
  | Reading
  | Writing
  | NotFoundRoute

type alias Model =
    {
      route : Route
    }

initialModel : Route -> Model
initialModel route =
    { 
      route = route
    }