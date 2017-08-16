module StateStorage exposing
  (saveAppState, loadAppState, appStateLoaded,injectProgress)

import Json.Encode as J exposing (object)
import Json.Decode as D exposing (int, string, float, list, Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Interop exposing (storeObject, retrieveObject, objectRetrieved)
import Msg exposing (Msg(OnAppStateLoaded))
import Models exposing (Model, Progress)

stateKey : String
stateKey = "appState"

loadAppState : Cmd msg
loadAppState = retrieveObject stateKey  

appStateLoaded : Sub Msg
appStateLoaded =
  let
    getModel json = case (D.decodeValue modelDecoder json) of
      Ok m -> Just m
      Err _ -> Nothing
    retrieval (key, json) =
      OnAppStateLoaded (getModel json)
  in
    objectRetrieved retrieval

injectProgress : Model -> Maybe Progress -> Model
injectProgress model progress =
  case progress of
    Just p ->
      { model | 
        userInput = p.userInput,
        lettersInScope = p.lettersInScope,
        morseSpeed = p.morseSpeed,
        trainCount = p.trainCount 
      }
    Nothing ->
      model

saveAppState : Model -> Cmd msg
saveAppState model = 
  let
      map m = 
        {
          userInput = m.userInput,
          lettersInScope = m.lettersInScope,
          morseSpeed = m.morseSpeed,
          trainCount = m.trainCount
        } 
  in
    storeObject (stateKey, encode <| map model)

encode : Progress -> J.Value
encode p =
  object [
    ("userInput", J.string p.userInput),
    ("lettersInScope", J.list <| List.map J.string p.lettersInScope),
    ("morseSpeed", J.float p.morseSpeed),
    ("trainCount", J.int p.trainCount)    
  ]

modelDecoder : Decoder Progress
modelDecoder = 
  decode Progress
    |> required "userInput" string
    |> required "lettersInScope" (list string)
    |> required "morseSpeed" float
    |> required "trainCount" int