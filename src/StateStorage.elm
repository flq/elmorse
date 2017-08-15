module StateStorage exposing(saveAppState)

import Json.Decode exposing (int, string, float, list, Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Interop exposing (storeObject)
import Models exposing (Progress)

saveAppState : a -> Progress -> Cmd msg
saveAppState key model = Cmd.none


modelDecoder : Decoder Progress
modelDecoder = 
  decode Progress
    |> required "userInput" string
    |> required "lettersInScope" (list string)
    |> required "morseSpeed" float
    |> required "trainCount" int