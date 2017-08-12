module Typing.View exposing(view)

import List exposing (map)
import String exposing (fromChar, toList)
import Html exposing (Html, text, div, p, span, section, form, input)
import Html.Attributes exposing (
  id, class, href, autofocus, type_, autocomplete, value)
import Html.Events exposing (onInput, onClick)
import Models exposing (Model)
import Msg exposing (..)
import Morse exposing (charToMorseCode)

view : Model -> Html Msg
view model = 
    section [class "typingScreen"]
    [
      form []
      [
        input [
          autofocus True, 
          type_ "text", 
          class "userInput", 
          value model.userInput,
          onInput OnUserInput] [],
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