module Util.Html.Attributes exposing (..)

import String
import Html exposing (Attribute)
import Html.Attributes exposing (class)

class' : List String -> Attribute msg
class' classes =
      class <| String.join " " classes