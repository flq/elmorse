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
      userInput : String,
      lettersInScope : List String,
      trainCount : Int,
      trainingStarted : Bool,
      trainingTime : Int,
      itemsLeft : Int,
      results : List Bool,
      successRate : Maybe Int,
      currentTrainTarget : String,
      currentTrainAim : String
    }

initialModel : Route -> Model
initialModel route =
    { 
      route = route,
      userInput = "",
      lettersInScope = [],
      trainCount = 10,
      trainingTime = 0,
      itemsLeft = 10,
      results = [],
      successRate = Nothing,
      trainingStarted = False,
      currentTrainTarget = "",
      currentTrainAim = ""
    }