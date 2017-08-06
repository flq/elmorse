module UpdateTraining exposing (update)

import String exposing(toInt)
import List exposing(length, partition)
import Random
import MsgTraining exposing (TrainMsg(..))
import Models exposing (Model)
import Msg exposing (Msg (TrainMsg, NoOp))
import Morse exposing (letters, letterScopeSize)

update : TrainMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SelectAllLetters -> 
      ({model | lettersInScope = letters}, Cmd.none)
    DeselectAllLetters -> 
      ({model | lettersInScope = []}, Cmd.none)
    ChangeTrainingSize input -> 
      changeTrainingSize model input
    ToggleLetter letter ->
      toggleLetter model letter
    StartTraining ->
      ({ model | trainingStarted = True, trainingTime = -4 }, Cmd.none)
    StopTraining ->
      ({ model | 
         trainingStarted = False, 
         trainingTime = 0, 
         currentTrainTarget = "" }, Cmd.none)
    TrainingTick _ ->
      actOnTick model
    NewTrainingStep index ->
      let
        newTrainTarget = get index model.lettersInScope
      in
        ({ model | currentTrainTarget = newTrainTarget }, Cmd.none)

changeTrainingSize : Model -> String -> (Model, Cmd msg)
changeTrainingSize model input =
  let
    newCount = case (toInt input) of
      Ok n -> n
      Err _ -> model.trainCount
  in
    ({model | trainCount = newCount}, Cmd.none)

toggleLetter : Model -> String -> (Model, Cmd msg)
toggleLetter model letter =
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

actOnTick : Model -> (Model, Cmd Msg )
actOnTick model =
  let
    nextModel = { model | trainingTime = model.trainingTime + 1 }
    randomNumber = (Random.int 0 (length model.lettersInScope - 1))
  in
    if model.trainingTime /= -1 then
      (nextModel, Cmd.none)
    else
      (nextModel, Random.generate (TrainMsg << NewTrainingStep) randomNumber)


get : Int -> List String -> String
get n xs = 
  case List.head (List.drop n xs) of
  Just s -> s
  Nothing -> "a"