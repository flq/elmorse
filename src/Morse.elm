module Morse exposing (charToMorseCode)

import List exposing (map2)
import Dict exposing (Dict, fromList, get)

zip : List a -> List b -> List ( a, b )
zip = map2 (,)

letters : List String
letters = 
  [
    ".", ",", "?",
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z",
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
  ]

codes : List String
codes = 
  [
    ".-.-.-", "--..--", "..--..",
    ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..",
    "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-",
    "-.--", "--..",
    ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----.", "-----"
  ]

lettersToCode : Dict String String
lettersToCode = zip letters codes |> fromList

codeToLetters : Dict String String
codeToLetters = zip codes letters |> fromList

stringToMorseCode : String -> String
stringToMorseCode = convert lettersToCode

charToMorseCode : Char -> String
charToMorseCode = stringToMorseCode << String.fromChar
  
morseCodeToChar : String -> String
morseCodeToChar = convert codeToLetters

convert : Dict String String -> String -> String
convert dict char = 
  case get (String.toLower char) dict of
    Just v -> v
    Nothing -> "?"