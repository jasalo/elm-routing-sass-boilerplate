port module Views.Home exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Util.Html.Attributes exposing (..)

import Store.Messages as Messages exposing (..)
import Store.State as State exposing (..)

import Routing.Routes exposing (..)

-- VIEW

viewActivated : Model -> ( Model, Cmd m )
viewActivated model =
  -- Do something useful here.
  ( model, Cmd.none )


render : Model -> Html Msg
render model =
  div []
    [ h1 []
      [ text "Hello world!" ]
    ]
