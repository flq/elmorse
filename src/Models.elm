module Models exposing (..)

type Route
  = Home
  | Typing
  | Reading
  | Writing
  | NotFoundRoute

urls : { reading : String, typing : String, writing : String }
urls = 
  {
    typing = "typing",
    reading = "reading-morse",
    writing = "writing-morse"
  }

type alias Model =
    {
      route : Route,
      userInput : String
    }

initialModel : Route -> Model
initialModel route =
    { 
      route = route,
      userInput = ""
    }