module Update exposing(..)

import Time exposing (second)
import Keyboard exposing (presses)
import Msg exposing (Msg(..))
import Training.Msg exposing (TrainMsg(TrainingTick, UserKey))
import Models exposing (Model, initialModel)
import StateStorage exposing (saveAppState,appStateLoaded, injectProgress)
import Navigation.Routes as Route
import Typing.MorseAudio as Audio
import Training.Update as Training


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    OnLocationChange location ->
      let newRoute = Route.parseLocation location
      in ( { model | route = newRoute }, Cmd.none )
    OnAppStateLoaded progress ->
      (injectProgress model progress, Cmd.none)
    OnUserInput input ->
      ({ model | userInput = input }, Cmd.none)
    OnChangeMorseSpeed input ->
      let
        newSpeed = case String.toFloat input of
          Ok val -> val
          Err _ -> model.morseSpeed
      in
        ({ model | morseSpeed = newSpeed }, Cmd.none)
    OnListenToMorse ->
      (model, Audio.playWords model.userInput model.morseSpeed)
    SaveAppState ->
      (model, saveAppState model)
    SoundMsg msg -> 
      Audio.update msg model
    TrainMsg msg ->
      Training.update msg model
    NoOp ->
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
    [
      if model.trainingStarted && model.successRate == Nothing then
          Time.every second (TrainMsg << TrainingTick)
      else
          Sub.none,
      presses (TrainMsg << UserKey),
      appStateLoaded
    ]