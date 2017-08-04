module Messages exposing(..)

import Navigation exposing (Location)
import MsgAudio exposing (SoundMsg)

type Msg
    = OnLocationChange Location
    | OnUserInput String
    | OnListenToMorse
    | SoundMsg SoundMsg
    | NoOp