module Training.Update exposing (update)

import String exposing(toInt, fromChar)
import Time exposing (millisecond)
import Char exposing(fromCode)
import List exposing(length, partition, filter)
import Random
import Delay
import Utility exposing (getWithDefault, message)
import Training.Msg exposing (TrainMsg(..))
import Models exposing (Model, TrainTarget(..), Route(..))
import Msg exposing (Msg (TrainMsg, NoOp))
import Morse exposing (letters, letterScopeSize, stringToMorseCode)

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
      ({ model | 
         trainingStarted = True, 
         trainingTime = -4,
         itemsLeft = model.trainCount,
         results = [] }, Cmd.none)
    StopTraining ->
      ({ model | 
         trainingStarted = False,
         successRate = Nothing,
         trainingTime = 0, 
         currentTrainTarget = NoTraining,
         currentTrainAim = "" }, Cmd.none)
    TrainAimSuceeded ->
      trainAimMatched model True
    TrainAimFailed ->
      trainAimMatched model False
    TrainingTick _ ->
      actOnTick model
    NewTrainingStep index ->
      let
        get = getWithDefault "a"
        trainTarget = get index model.lettersInScope
        newTrainTarget = case model.route of
          Reading -> ReadTraining trainTarget
          Writing -> WriteTraining trainTarget
          _ -> NoTraining
      in
        ({ model | currentTrainTarget = newTrainTarget }, Cmd.none)
    UserKey keyCode ->
      handleUserInput model keyCode
    TrainingDone ->
      let
        successAmount = filter ((==) True) model.results |> length
        successRate = (successAmount |> toFloat) /
                      (model.trainCount |> toFloat) |> (*) 100 |> round
      in
        ({ model | successRate = Just successRate }, Cmd.none)

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
  in
    if model.trainingTime /= -1 then
      (nextModel, Cmd.none)
    else
      (nextModel, nextStep model)

handleUserInput : Model -> Char.KeyCode -> (Model, Cmd Msg)
handleUserInput model keyCode =
  let
    { currentTrainAim, currentTrainTarget } = model
    newCurrentAim = currentTrainAim ++ (fromCode >> fromChar) keyCode
    expected = case currentTrainTarget of
      WriteTraining s -> stringToMorseCode s
      ReadTraining s -> s
      _ -> ""
    isMatch = 
      if String.length newCurrentAim == String.length expected then
        Just (newCurrentAim == expected)
      else
        Nothing
    cmd = case isMatch of
      Just True -> Delay.after 300 millisecond (TrainMsg TrainAimSuceeded)
      Just False -> Delay.after 300 millisecond (TrainMsg TrainAimFailed)
      Nothing -> Cmd.none
  in
    ({ model | currentTrainAim = newCurrentAim }, cmd)

trainAimMatched : Model -> Bool -> ( Model, Cmd Msg )
trainAimMatched model success =
  ({ model | 
     results = model.results ++ [success],
     itemsLeft = model.itemsLeft - 1,
     currentTrainTarget = NoTraining,
     currentTrainAim = "" }, nextStep model)

nextStep : Model -> Cmd Msg
nextStep model =
  let
    randomNumber = (Random.int 0 (length model.lettersInScope - 1))
  in
    {- Smells weird, but this is while itemsLeft is set to 0,
       so it's the right moment to end the training -}
    if model.itemsLeft == 1 then
      message (TrainMsg TrainingDone)
    else
      Random.generate (TrainMsg << NewTrainingStep) randomNumber

