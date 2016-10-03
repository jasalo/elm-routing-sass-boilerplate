module Store.Messages exposing (..)

import Hop.Types exposing (Config, Address, Query)

import Routing.Routes exposing (..)

-- MESSAGES

type RoutingMsg
  = NavigateTo String
  | SetQuery Query
  | RouteActivated Route


type Msg
  = MRouting RoutingMsg
  -- Add here other type of messages
