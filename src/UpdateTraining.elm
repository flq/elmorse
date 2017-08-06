module UpdateTraining exposing (update)

import String exposing(toInt)
import List exposing(length, partition)
import MsgTraining exposing (TrainMsg(..))
import Models exposing (Model)
import Msg exposing (Msg (TrainMsg, NoOp))
import Morse exposing (letters)

update : TrainMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SelectAllLetters -> 
      ({model | lettersInScope = letters}, Cmd.none)
    DeselectAllLetters -> 
      ({model | lettersInScope = []}, Cmd.none)
    ChangeTrainingSize input ->
      let
        newCount = case (toInt input) of
          Ok n -> n
          Err _ -> model.trainCount
      in
        ({model | trainCount = newCount}, Cmd.none)
    ToggleLetter letter ->
      let
        (foundLetter, others) = 
          partition (\l -> l == letter) model.lettersInScope
        newScope = others ++ 
          if length foundLetter == 0 then
            [letter]
          else
            []
      in
        ({model | lettersInScope = newScope}, Cmd.none)
    StartTraining ->
      ({ model | trainingStarted = True, trainingTime = -4 }, Cmd.none)
    StopTraining ->
      ({ model | trainingStarted = False, trainingTime = 0 }, Cmd.none)