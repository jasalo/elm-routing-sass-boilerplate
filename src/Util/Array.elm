
module Util.Array exposing (..)

import Array exposing (..)

lookup : a -> Array a -> Maybe Int
lookup x arr =
    let f e (i,m) = 
            if x == e
            then (i+1,Just i)
            else (i+1,m) 
    in snd (foldr f (0,Nothing) arr) 

lookupWith : a -> (a -> b -> Bool) -> Array b -> Maybe b
lookupWith k p arr = 
    let f b m = if p k b
                then Just b
                else m
    in Array.foldl f Nothing arr

lookupWithDefault : v -> k -> (k -> v -> Bool) -> Array v -> v
lookupWithDefault v k p arr =
    Maybe.withDefault v <| lookupWith k p arr
