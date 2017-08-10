module Update exposing(..)

import Time exposing (second)
import Keyboard exposing (presses)
import Msg exposing (Msg(..))
import MsgTraining exposing (TrainMsg(TrainingTick, UserKey))
import Models exposing (Model, initialModel)
import Routes
import MorseAudio
import UpdateTraining


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    OnLocationChange location ->
      let newRoute = Routes.parseLocation location
      in ( { model | route = newRoute }, Cmd.none )
    OnUserInput input ->
      ({ model | userInput = input }, Cmd.none)
    OnListenToMorse ->
      (model, MorseAudio.playWords model.userInput)
    SoundMsg msg -> 
      MorseAudio.update msg model
    TrainMsg msg ->
      UpdateTraining.update msg model
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
      presses (TrainMsg << UserKey)
    ]