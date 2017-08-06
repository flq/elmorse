module Update exposing(..)

import Time exposing (second)
import Msg exposing (Msg(..))
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
    TrainingTick _ ->
      ({ model | trainingTime = model.trainingTime + 1 }, Cmd.none)
    SoundMsg msg -> 
      MorseAudio.update msg model
    TrainMsg msg ->
      UpdateTraining.update msg model
    NoOp ->
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.trainingStarted then
        Time.every second TrainingTick
    else
        Sub.none