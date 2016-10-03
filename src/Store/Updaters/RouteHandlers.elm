module Store.Updaters.RouteHandlers exposing (..)

import Util.Cmd as Cmd

import Routing.Middleware exposing (..)
import Routing.Routes exposing (..)
import Store.Messages as Messages exposing (..)
import Store.State as State exposing (..)
import Views.Home

update : Route -> Model -> ( Model, Cmd msg )
update route model =
  case route of
    HomeRoute ->
      Views.Home.viewActivated model
    _ ->
      ( model, Debug.log "Add your route handlers here!" Cmd.none )
