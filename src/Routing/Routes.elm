module Routing.Routes exposing (..)

import List
import UrlParser exposing ((</>),s,int,format,string,oneOf)

-- ROUTES

type Route
  = HomeRoute
  | UsersRoutes UsersRoute
  | NotFoundRoute

type alias UserId = String

type UsersRoute
  = UserRoute UserId
  | UsersRoute

usersMatchers =
  [ format UserRoute (string)
  , format UsersRoute (s "")
  ]

{-- Route matchers
See `https://github.com/sporto/hop/blob/master/docs/building-routes.md` for more examples.
IMPORTANT: Remember that order matters! Do MORE specific first
Ex:
  1. "users/3/posts"
  2. "users/3"
  3. "users"
--}
appRoutesMatchers : List (UrlParser.Parser (Route -> a) a)
appRoutesMatchers =
  [ format UsersRoutes <| s "users" </> (oneOf usersMatchers)
  , format NotFoundRoute <| s "not-found"
  , format HomeRoute <| s ""
  ]