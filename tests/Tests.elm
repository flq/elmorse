module Tests exposing (..)

import Test exposing (..)
import Expect
import Morse exposing (..)


-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


all : Test
all =
    describe "Morselib produces correct results"
        [ test "H W" <|
            \() ->
                Expect.equal [Dot,Dot,Dot,Dot,Pause,Dot,Dash,Dash] (stringToMorseSymbols "H W")
        ]
