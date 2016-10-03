
module Util.Http exposing (..)

import Http

httpErrorToString : Http.Error -> String
httpErrorToString err = 
    case err of
        Http.Timeout -> "Timeout"
        Http.NetworkError -> "Network error"
        Http.UnexpectedPayload s -> "Unexpected payload <<" ++ s ++ ">>"
        Http.BadResponse n s -> "Bad response " ++ toString n ++ " " ++ s

