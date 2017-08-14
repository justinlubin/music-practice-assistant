module Utils exposing (..)

import Random
import Char

maybeToList : Maybe a -> List a
maybeToList mx =
  case mx of
    Just x ->
      [x]
    Nothing ->
      []

ifList : Bool -> a -> List a
ifList bool x =
  case bool of
    True ->
      [x]
    False ->
      []

get : Int -> List a -> Maybe a
get i =
  List.head << List.drop i

getWithDefault : a -> Int -> List a -> a
getWithDefault default i =
  Maybe.withDefault default << List.head << List.drop i

select : List a -> Random.Generator (Maybe a)
select xs =
  let
    len =
      List.length xs
  in
    Random.map (flip get xs) (Random.int 0 len)

selectWithDefault : a -> List a -> Random.Generator a
selectWithDefault default xs =
  Random.map (Maybe.withDefault default) (select xs)

sharpString : String -> String
sharpString =
  flip (++) "♯"

flatString : String -> String
flatString =
  flip (++) "♭"

spaceKeyCode : Char.KeyCode
spaceKeyCode =
  Char.toCode ' '
