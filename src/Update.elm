module Update exposing(..)

import Msg exposing (Msg(..))
import Models exposing (Model, initialModel)
import Routes
import MorseAudio


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
      (model, Cmd.none)
    NoOp ->
      (model, Cmd.none)