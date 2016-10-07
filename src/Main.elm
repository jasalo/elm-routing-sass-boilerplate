port module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.App as Html
import Html.Attributes exposing (..)

import Navigation
import Util.Html.Attributes exposing (..)

-- Routing imports
import Routing.Middleware
import Routing.Routes exposing (..)

-- Views Imports
import Views.Home as Home

-- Store imports
import Store.Messages as Messages exposing (..)
import Store.State as State exposing (..)
-- IMPORTANT! Please note, Main module should be the only one using (i.e. importing) the Updates module.
import Store.Updates as Updates exposing (..)


-- VIEWS


view : Model -> Html Msg
view model =
  div []
    [ pageView model
    ]

{-|
Views can decide what to show using `model.route`.
-}
pageView : Model -> Html Msg
pageView model =
  case model.route of
    HomeRoute -> Home.render model
    NotFoundRoute -> div [] [ h1 [] [ text "Page not found :(" ] ]
    -- Useful for debugging or unimplemented routes:
    _  -> todoView <| "«" ++ toString model.route ++ "» hasn't been implemented!"

todoView : String -> Html msg
todoView txt =
  div [ class' ["p2"] ] [ h1 [ class' ["m0"] ]
    [ text "TODO:"
    , br [] []
    , div [ class' ["h5","cl-body"] ]
      [ text txt ] ]
    ]


-- APP


{-|
Wire everything using Navigation.
-}
main : Program Never
main =
  Navigation.program Routing.Middleware.urlParser
    { init = State.init
    , view = view
    , update = Updates.update
    , urlUpdate = Routing.Middleware.urlUpdate
    , subscriptions = subscriptions
    }

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = 
  -- TODO: Group all of your app subscriptions here.
  -- Hint: Use Sub.map or the handy function `subMap` provided below, to do so for a List of Subscriptions
  Sub.batch []

subMap : (msgA -> msgB) -> List (Sub msgA)-> List (Sub msgB)
subMap st = List.map (Sub.map st)
