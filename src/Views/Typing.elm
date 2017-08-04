module Views.Typing exposing(..)

import List exposing (map)
import String exposing (fromChar, toList)
import Html exposing (Html, text, div, p, span, section, form, input)
import Html.Attributes exposing (
  id, class, href, autofocus, type_, autocomplete, value)
import Html.Events exposing (onInput, onClick)
import Models exposing (Model)
import Messages exposing (..)
import Morse exposing (charToMorseCode)

typingView : Model -> Html Msg
typingView model = 
    section [class "typingScreen"]
    [
      form []
      [
        input [autofocus True, type_ "text", class "userInput", onInput OnUserInput] [],
        div [class "soundControls"]
        [
          input [
            type_ "button", 
            class "soundButton", 
            onClick OnListenToMorse,
            value "Play Morse" ] []
        ]
      ],
      wordToMorse model.userInput
    ]
    
wordToMorse : String -> Html msg
wordToMorse userInput =
  section [] (String.words userInput |> map morseWord)
  
morseWord : String -> Html msg
morseWord word =
  span [class "morseWord"] (toList word |> map morseChar)
  

morseChar : Char -> Html msg
morseChar c =
  div [class "morseToken"]
  [
    span [class "morseChar"] [fromChar c |> text],
    span [class "morseCode"] [charToMorseCode c |> text]
  ]