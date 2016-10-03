module Store.Updaters.Routing exposing (..)

import Util.Cmd as Cmd

import Hop
import Navigation

import Routing.Middleware exposing (..)
import Routing.Routes exposing (..)
import Store.Messages as Messages exposing (..)
import Store.State as State exposing (..)
import Store.Updaters.RouteHandlers as URouteHandlers

--

update : RoutingMsg -> Model -> ( Model, Cmd RoutingMsg )
update msg model =
  case msg of
    NavigateTo path ->
      let
        route = str2route path
        command =
          -- First generate the URL using your config (`outputFromPath`).
          -- Then generate a command using Navigation.newUrl.
          Hop.outputFromPath hopConfig path |> Navigation.newUrl
        -- Add other commands if you wish
        cmds = Cmd.batch <| [ command, Cmd.fromMsg (RouteActivated route) ]
      in
        ( model, cmds )

    SetQuery query ->
      let
        command =
          -- First modify the current stored address record (setting the query)
          -- Then generate a URL using Hop.output
          -- Finally, create a command using Navigation.newUrl
          model.address
            |> Hop.setQuery query
            |> Hop.output hopConfig
            |> Navigation.newUrl
      in
        ( model, command )

    -- Will never get here, but is necessary to cover all cases
    RouteActivated route ->
      URouteHandlers.update route model

