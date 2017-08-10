module Utility exposing (..)

import Task exposing (perform, succeed)
import Msg exposing (Msg)

{- A not very fast way to get the nth element of a list -}
getWithDefault : String -> Int -> List String -> String
getWithDefault def n xs = 
  case List.head (List.drop n xs) of
  Just s -> s
  Nothing -> def

message : Msg -> Cmd Msg
message msg = perform identity (succeed msg)