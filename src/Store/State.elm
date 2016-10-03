module Store.State exposing (..)

import Array exposing (Array)

import Hop
import Hop.Types exposing (Config, Address, Query)

import Store.Messages as Messages exposing (..)
import Routing.Routes exposing (..)

import Util.Cmd as Cmd

-- MODEL

{-|
Add the current route and address to your model.
- `Route` is your Route union type defined above.
- `Hop.Address` is record to aid with changing the query string.
`route` will be used for determining the current route in the views.
`address` is needed because:
- Some navigation functions in Hop need this information to rebuild the current address.
- Your views might need information about the current query string.
-}
type alias Model =
  { address : Address
  , route : Route
  }


{-|
Your init function will receive an initial payload from Navigation, this payload is the initial matched location.
Here we store the `route` and `address` in our model.
-}
init : ( Route, Address ) -> ( Model, Cmd Msg )
init ( route, address ) =
  ( Model
      address
      route
  , Cmd.batch <|
      [ Cmd.map MRouting <| Cmd.fromMsg (NavigateTo <| route2str route)
      -- Other commands you wish your app to init with
      ]
  )

