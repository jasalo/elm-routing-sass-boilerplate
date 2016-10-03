module Util.Tuple exposing (..)

map : ( a -> b ) -> ( c, a ) -> ( c, b )
map f ( fst, snd ) = ( fst, f snd )