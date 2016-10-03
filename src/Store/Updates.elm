module Store.Updates exposing (..)

import Routing.Middleware exposing (..)
import Store.Messages as Messages exposing (..)
import Store.State as State exposing (..)

-- Updates' imports
import Store.Updaters.Routing as URouting exposing (..)
import Store.Updaters.RouteHandlers as URouteHandlers exposing (..)

import Util.Cmd as Cmd
import Util.Tuple as Tuple

{-|
Respond to navigation messages in update i.e. NavigateTo and SetQuery
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    MRouting x ->
      Tuple.map (Cmd.map MRouting) <| URouting.update x model
    --_ ->
    --  ( model, Debug.log "Add other Updates' Groups here" Cmd.none )