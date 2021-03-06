port module Interop exposing (..)

import Json.Encode as J

port audioOn : () -> Cmd msg
port audioOff : () -> Cmd msg

port storeObject : (String, J.Value) -> Cmd msg
port retrieveObject : String -> Cmd msg
port objectRetrieved : ((String, J.Value) -> msg) -> Sub msg