module Msg exposing(..)

import Navigation exposing (Location)
import Typing.Msg exposing (SoundMsg)
import Training.Msg exposing (TrainMsg)
import Models exposing (Progress)

type Msg
    = OnLocationChange Location
    | OnUserInput String
    | OnChangeMorseSpeed String
    | OnListenToMorse
    | SaveAppState
    | OnAppStateLoaded (Maybe Progress)
    | SoundMsg SoundMsg
    | TrainMsg TrainMsg
    | NoOp

