module Msg exposing(..)

import Time exposing (Time)
import Navigation exposing (Location)
import MsgAudio exposing (SoundMsg)
import MsgTraining exposing (TrainMsg)

type Msg
    = OnLocationChange Location
    | OnUserInput String
    | OnListenToMorse
    | TrainingTick Time
    | SoundMsg SoundMsg
    | TrainMsg TrainMsg
    | NoOp

