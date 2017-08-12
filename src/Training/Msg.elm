module Training.Msg exposing(..)

import Time exposing (Time)
import Keyboard exposing (KeyCode)

type TrainMsg 
  = StopTraining
  | StartTraining
  | SelectAllLetters
  | DeselectAllLetters
  | ToggleLetter String
  | ChangeTrainingSize String
  | TrainingTick Time
  | NewTrainingStep Int
  | UserKey KeyCode
  | TrainAimSuceeded
  | TrainAimFailed
  | TrainingDone
  