module Training.View exposing (view)

import Html exposing (
  Html, section, text, div, h2, p, span, a, button, input)
import Html.Attributes as Att exposing (
  id, class, classList, disabled, type_, min, max, step, value)
import Html.Events exposing (onClick, onInput)
import Models exposing (Model, TrainTarget(..))
import Morse exposing (letters, stringToMorseCode)
import Msg exposing (..)
import Training.Msg exposing (TrainMsg(..))

view : Model -> Html Msg
view model = 
  let
    { trainingStarted } = model
    tCView = trainingConfig model
    tView = trainingView model
  in
    section []
    [
      if not trainingStarted then tCView else none,
      if trainingStarted then tView else none
    ]

trainingConfig : Model -> Html Msg
trainingConfig model = 
  let
    theTrainCount = toString model.trainCount  
  in
    div [class "flex-column"]
    [
      div [class "flex-row toolBox"]
      [
        h2 [] [text "What do you want to train?"],
        button [onClick (TrainMsg SelectAllLetters)] [text "All"],
        button [onClick (TrainMsg DeselectAllLetters)] [text "None"]             
      ],
      letterScope model.lettersInScope,
      div [class "flex-row toolBox"]
      [
        h2 [] [text "Train "],
        input [
          type_ "range", 
          Att.min "10", 
          Att.max "100", 
          step "10", 
          value theTrainCount,
          onInput (TrainMsg << ChangeTrainingSize)] [],
        h2 [] [text (String.concat [theTrainCount, " times."])],
        button [
          onClick (TrainMsg StartTraining), 
          disabled (List.length model.lettersInScope < 2)]
        [text "Start!"]
      ]
    ]
  
trainingView: Model -> Html Msg
trainingView model =
  let
      {trainingTime, itemsLeft, results} = model
  in
    div [id "training"]
    [
      div [class "toolBox"]
      [
        button [disabled False, onClick (TrainMsg StopTraining)] [text "Stop the Training"],
        numberWithUnit trainingTime "seconds",
        numberWithUnit itemsLeft "items left",
        showPreparation trainingTime
      ],
      showResults results,
      case model.successRate of
        Just rate -> wellDone rate
        Nothing -> none,
      div []
      [
        showCurrentTrainTarget model.currentTrainTarget,
        if model.currentTrainAim /= "" then
          p [] [text model.currentTrainAim]
        else none
      ]
    ]

numberWithUnit : Int -> String -> Html msg
numberWithUnit value unit = 
    div [class "numberWithUnit"]
    [
      span [] [text <| toString value],
      span [] [text unit]
    ]
    
showResults : List Bool -> Html msg
showResults results =
  let
    boolAsSpan b = span [classList [("success", b),("fail", not b)]] []
    children = List.map boolAsSpan results
  in
    div [id "results"] children

showPreparation : Int -> Html msg
showPreparation trainingTime =
  let 
    help = "Use keys '-' and '.' for write and letters for read exercise"
    txt = 
      case trainingTime of
        (-4) -> help
        (-3) -> help
        (-2) -> "Ready..."
        (-1) -> "Steady..."
        0 -> "Go!"
        _ -> ""
  in
    h2 [] [text txt]

wellDone : Int -> Html msg
wellDone rate =
  h2 []
  [
    text ("Well done, you got " ++ toString rate ++ " % right!")
  ]

letterScope : List String -> Html Msg
letterScope lettersInScope =
  let
    isInScope l = List.member l lettersInScope
    letterUI letter = letterSelector letter (isInScope letter)
    lettersUI = List.map letterUI letters
  in 
    section [class "learningScope"]
    lettersUI

letterSelector : String -> Bool -> Html Msg
letterSelector letter isInScope =
  a [classList [ ("inScope", isInScope) ], 
     onClick (TrainMsg (ToggleLetter letter))]
  [
    text letter
  ]

showCurrentTrainTarget : TrainTarget -> Html msg
showCurrentTrainTarget trainTarget =
  let 
    display = case trainTarget of
      ReadTraining s -> stringToMorseCode s
      WriteTraining s -> s
      _ -> ""
  in
    if trainTarget /= NoTraining then
      p [] [text display]
    else none

none : Html msg
none = text ""
