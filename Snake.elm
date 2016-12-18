module Snake exposing (main)

import Collage exposing (collage, Form, group)
import Color exposing (Color)
import Element exposing (show, toHtml)
import Html exposing (Html)
import Block exposing (Location, BlockSize, draw)


type alias Scale =
    Location


type alias Snake =
    List Scale


draw : BlockSize -> Snake -> Form
draw size snake =
    let
        block scale =
            Block.draw size { location = scale, color = Color.green }
    in
        List.map block snake |> group


main : Html a
main =
    let
        blockSize =
            25

        snake =
            [ { x = 0, y = 0 }
            , { x = 0, y = 1 }
            , { x = 0, y = 2 }
            ]
    in
        snake
            |> draw blockSize
            |> flip (::) []
            |> collage 500 500
            |> toHtml
