module Snake exposing (Snake, Model, Msg, view, update, init, step, subscriptions)

import Collage exposing (collage, Form, group)
import Color exposing (Color)
import Block exposing (Location, BlockSize, draw)
import Keyboard


type alias Model =
    { snake : Snake
    , direction : Direction
    }


init : Model
init =
    { snake = [ ( 1, 1 ), ( 1, 2 ), ( 1, 3 ) ]
    , direction = Up
    }


subscriptions : Sub Msg
subscriptions =
    Sub.batch [ Keyboard.ups KeyDown ]


type alias Scale =
    Location


type alias Snake =
    List Scale


type Direction
    = Up
    | Down
    | Right
    | Left


type Msg
    = KeyDown Int


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        KeyDown key ->
            case key of
                37 ->
                    { model | direction = Left } ! []

                38 ->
                    { model | direction = Up } ! []

                39 ->
                    { model | direction = Right } ! []

                40 ->
                    { model | direction = Down } ! []

                _ ->
                    model ! []


step : Model -> Model
step model =
    let
        removeLast snake =
            List.take (List.length snake - 1) snake

        addFirst snake =
            case List.head snake of
                Just scale ->
                    (move scale) :: snake

                Nothing ->
                    snake

        move =
            case model.direction of
                Up ->
                    \( x, y ) -> ( x, y + 1 )

                Down ->
                    \( x, y ) -> ( x, y - 1 )

                Left ->
                    \( x, y ) -> ( x - 1, y )

                Right ->
                    \( x, y ) -> ( x + 1, y )

        newSnake =
            model.snake
                |> removeLast
                |> addFirst
    in
        { model | snake = newSnake }


view : BlockSize -> Model -> Form
view size { snake } =
    let
        block scale =
            Block.draw size { location = scale, color = Color.green }
    in
        List.map block snake |> group
