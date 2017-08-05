module Msg exposing(..)

import Navigation exposing (Location)
import MsgAudio exposing (SoundMsg)
import MsgTraining exposing (TrainMsg)

type Msg
    = OnLocationChange Location
    | OnUserInput String
    | OnListenToMorse
    | SoundMsg SoundMsg
    | TrainMsg TrainMsg
    | NoOp

