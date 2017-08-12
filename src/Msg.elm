module Msg exposing(..)

import Navigation exposing (Location)
import Typing.Msg exposing (SoundMsg)
import Training.Msg exposing (TrainMsg)

type Msg
    = OnLocationChange Location
    | OnUserInput String
    | OnListenToMorse
    | SoundMsg SoundMsg
    | TrainMsg TrainMsg
    | NoOp

