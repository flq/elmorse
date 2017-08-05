module MsgTraining exposing(..)

type TrainMsg 
  = StopTraining
  | StartTraining
  | SelectAllLetters
  | DeselectAllLetters
  | ToggleLetter String
  