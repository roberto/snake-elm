module Snake exposing (main, draw)

import Collage exposing (collage, Form)
import Color exposing (Color)
import Element exposing (toHtml)
import Html exposing (Html)
import Block exposing (Location, BlockSize, draw)


draw : BlockSize -> Location -> Form
draw size location =
    Block.draw size { location = location, color = Color.red }


main : Html a
main =
    let
        blockSize =
            25

        apple =
            ( 1, 4 )
    in
        apple
            |> draw blockSize
            |> flip (::) []
            |> collage 500 500
            |> toHtml
