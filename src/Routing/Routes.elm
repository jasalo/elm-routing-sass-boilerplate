module Routing.Routes exposing (..)

import List
import UrlParser exposing ((</>))

-- ROUTES

type Route
  = HomeRoute
  | NotFoundRoute

{-- Route matchers
See `https://github.com/sporto/hop/blob/master/docs/building-routes.md` for more examples.
IMPORTANT: Remember that order matters! Do MORE specific first
Ex:
  1. "users/3/posts"
  2. "users/3"
  3. "users"
--}
appRoutes : List ( Route, UrlParser.Parser a a, String )
appRoutes =
  [ ( NotFoundRoute, (UrlParser.s "not-found"), "not-found" )
  , ( HomeRoute, (UrlParser.s ""), "" )
  ]

lookupTuple3Snd : a -> b -> List (a,b,c) -> b
lookupTuple3Snd key default =
  List.foldl (\(a,b,c) d -> if a == key then b else d) default

lookupTuple3Trd : a -> c -> List (a,b,c) -> c
lookupTuple3Trd key default =
  List.foldl (\(a,b,c) d -> if a == key then c else d) default

str2route : String -> Route
str2route x = lookupTuple3Snd x NotFoundRoute <| List.map (\(a,b,c) -> (c,a,b)) appRoutes

route2str : Route -> String
route2str r = lookupTuple3Snd r "no-route" <| List.map (\(a,b,c) -> (a,c,b)) appRoutes

route2parser : Route -> UrlParser.Parser a a
route2parser r = lookupTuple3Snd r (UrlParser.s "not-found") appRoutes
