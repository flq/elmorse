module MsgTraining exposing(..)

import Time exposing (Time)

type TrainMsg 
  = StopTraining
  | StartTraining
  | SelectAllLetters
  | DeselectAllLetters
  | ToggleLetter String
  | ChangeTrainingSize String
  | TrainingTick Time
  | NewTrainingStep Int
  