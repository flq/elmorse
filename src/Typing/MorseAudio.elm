module Typing.MorseAudio exposing (update, playWords)

import Interop exposing(..)
import Time exposing (millisecond)
import Delay exposing (after,sequence)
import Models exposing (Model)
import Msg exposing (Msg (SoundMsg, NoOp))
import Typing.Msg exposing (SoundMsg(..))
import Morse exposing (..)
{- 
based on
http://www.nu-ware.com/NuCode%20Help/index.html?morse_code_structure_and_timing_.htm
dot -> dot length, dash = 3 * dot, pause between chars = 3 * dot, 
pause between words = 7 * dot
-}

update : SoundMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    StartSound -> (model, audioOn ())
    StopSound -> (model, audioOff ())

type alias Milliseconds = Float

dotLength: Milliseconds
dotLength = 50

dashLength: Milliseconds
dashLength = 150

pauseBetweenChars: Milliseconds
pauseBetweenChars = dashLength

pauseBetweenWords: Milliseconds
pauseBetweenWords = 400

playWords : String -> Float -> Cmd Msg
playWords words factor = 
  stringToMorseSymbols words
  |> List.map (convertSymbolToCommands factor)
  |> bringTogether
  
convertSymbolToCommands: Float -> MorseSymbol -> List (Milliseconds, Msg)
convertSymbolToCommands factor symbol =
  let
    adapt (millisecs, msg) = (millisecs / factor, msg)
    adaptl = List.map adapt
  in
    case symbol of
      Dot -> adaptl playDot
      Dash -> adaptl playDash
      ShortPause -> adaptl playBetweenChars
      LongPause -> adaptl playBetweenWords
      Garbled -> adaptl playBetweenWords

playDot: List (Milliseconds, Msg)
playDot =  
  [ 
    (0, (SoundMsg StartSound)),
    (dotLength, (SoundMsg StopSound)),
    (pauseBetweenChars, NoOp)
  ]
playDash : List (Milliseconds, Msg)
playDash =  
  [ 
    (0, (SoundMsg StartSound)),
    (dashLength, (SoundMsg StopSound)),
    (pauseBetweenChars, NoOp)
  ]

playBetweenChars : List (Milliseconds, Msg)
playBetweenChars = [(pauseBetweenChars, NoOp)]

playBetweenWords : List (Milliseconds, Msg)
playBetweenWords = [(pauseBetweenWords, NoOp)]
  
bringTogether : List (List ( Milliseconds, Msg )) -> Cmd Msg
bringTogether = List.concat >> List.map toSequenceTuple >> sequence

toSequenceTuple : ( Milliseconds, Msg ) -> (Milliseconds, Time.Time, Msg)
toSequenceTuple (time, msg) = (time, millisecond, msg) 
