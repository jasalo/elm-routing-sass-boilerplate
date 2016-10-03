module Routing.Middleware exposing (..)

import Task

import Dict
import Navigation
import UrlParser exposing ((</>))
import Hop
import Hop.Types exposing (Config, Address, Query)
import Store.Messages as Messages exposing (..)
import Store.State exposing (..)
import Routing.Routes exposing (..)



{-|
Define route matchers.
See `https://github.com/sporto/hop/blob/master/docs/building-routes.md` for more examples.
IMPORTANT: Order matters! Do MOST specific first.
Ex:
  1. "users/3/posts"
  2. "users/3"
  3. "users"
-}
routes : UrlParser.Parser (Route -> a) a
routes =
  UrlParser.oneOf <|
    List.map (\(route,parser,path) -> UrlParser.format route parser ) appRoutes

{-|
Router configuration.
Use `hash = True` for hash routing e.g. `#/users/1`.
Use `hash = False` for push state e.g. `/users/1`.
The `basePath` is only used for path routing.
This is useful if you application is not located at the root of a url
e.g. `/app/v1/users/1` where `/app/v1` is the base path.
-}
hopConfig : Config
hopConfig =
  { hash = True
  , basePath = ""
  }

{-|
Create a URL Parser for Navigation
-}
urlParser : Navigation.Parser ( Route, Address )
urlParser =
  let
    -- A parse function takes the normalised path from Hop after taking
    -- in consideration the basePath and the hash.
    -- This function then returns a result.
    parse path =
      -- First we parse using UrlParser.parse.
      -- Then we return the parsed route or NotFoundRoute if the parsed failed.
      -- You can choose to return the parse return directly.
      path
        |> UrlParser.parse identity routes
        |> Result.withDefault NotFoundRoute

    resolver =
      -- Create a function that parses and formats the URL
      -- This function takes 2 arguments: The Hop Config and the parse function.
      Hop.makeResolver hopConfig parse
  in
    -- Create a Navigation URL parser
    Navigation.makeParser (.href >> resolver)


{-|
Navigation will call urlUpdate when the address changes.
This function gets the result from `urlParser`, which is a tuple with (Route, Hop.Types.Address)
Address is a record that has:
```elm
{
  path: List String,
  query: Hop.Types.Query
}
```
- `path` is an array of strings that has the current path e.g. `["users", "1"]` for `"/users/1"`
- `query` Is dictionary of String String. You can access this information in your views to show
  the relevant content.
  We store these two things in our model. We keep the address because it is needed for matching a query string.
-}
urlUpdate : ( Route, Address ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, address ) model =
  ( { model | route = route, address = address }, Cmd.none )

