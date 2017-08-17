module Models exposing (..)

type Route
  = Home
  | Typing
  | Reading
  | Writing
  | NotFoundRoute

type TrainTarget
  = ReadTraining String
  | WriteTraining String
  | NoTraining

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
      morseSpeed : Float,
      lettersInScope : List String,
      trainCount : Int,
      trainingStarted : Bool,
      trainingTime : Int,
      itemsLeft : Int,
      results : List Bool,
      successRate : Maybe Int,
      currentTrainTarget : TrainTarget,
      currentTrainAim : String
    }

type alias Progress =
 {
  userInput : String,
  lettersInScope : List String,
  morseSpeed : Float,
  trainCount : Int
 }

initialModel : Route -> Model
initialModel route =
    { 
      route = route,
      userInput = "",
      morseSpeed = 1.0,
      lettersInScope = [],
      trainCount = 10,
      trainingTime = 0,
      itemsLeft = 10,
      results = [],
      successRate = Nothing,
      trainingStarted = False,
      currentTrainTarget = NoTraining,
      currentTrainAim = ""
    }