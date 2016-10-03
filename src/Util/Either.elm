module Util.Either exposing (..)

{-| Represents any data that can take two different types.

# Type and Constructors
@docs Either

# Taking Eithers apart
@docs either, isLeft, isRight

# Eithers and Lists
@docs lefts, rights, partition

-}

import List

{-| Represents any data may take two forms. For example, a user ID may be
either an `Int` or a `String`.

This can also be used for error handling `(Either String a)` where
error messages are stored on the left, and the correct values
(&ldquo;right&rdquo; values) are stored on the right.
-}
type Either a b = Left a | Right b

{-| Apply the first function to a `Left` and the second function to a `Right`.
This allows the extraction of a value from an `Either`.
-}
either : (a -> c) -> (b -> c) -> Either a b -> c
either f g e = case e of 
                   Left x -> f x 
                   Right y -> g y

{-| True if the value is a `Left`. -}
isLeft : Either a b -> Bool
isLeft = either (\ _ -> True) (\ _ -> False)

{-| True if the value is a `Right`. -}
isRight : Either a b -> Bool
isRight = either (\ _ -> False) (\ _ -> True)

{-| Keep only the values held in `Left` values. -}
lefts : List (Either a b) -> List a
lefts = List.foldr consLeft []

{-| Keep only the values held in `Right` values. -}
rights : List (Either a b) -> List b
rights = List.foldr consRight []

{-| Split into two lists, lefts on the left and rights on the right. So we
have the equivalence: `(partition es == (lefts es, rights es))`
-}
partition : List (Either a b) -> (List a,List b)
partition = List.foldr consEither ([],[])

consLeft e vs =
    case e of
      Left  v -> v :: vs
      Right _ -> vs

consRight e vs =
    case e of
      Left  _ -> vs
      Right v -> v :: vs

consEither e (ls,rs) =
    case e of
      Left  l -> (l::ls,rs)
      Right r -> (ls,r::rs)
