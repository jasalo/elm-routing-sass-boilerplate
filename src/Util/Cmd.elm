module Util.Cmd exposing (..)

import Task

fromMsg : msg -> Cmd msg
fromMsg x =
  Task.perform identity identity (Task.succeed x)