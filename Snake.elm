module Snake exposing (Snake, Model, Msg, view, update, init, step, subscriptions)

import Collage exposing (collage, Form, group)
import Color exposing (Color)
import Block exposing (Location, BlockSize, draw)
import Keyboard exposing (KeyCode, ups)
import Dict exposing (Dict)


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
    | Nowhere


type Msg
    = KeyDown Int


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        KeyDown keyCode ->
            handleDirection model keyCode ! []


handleDirection : Model -> KeyCode -> Model
handleDirection model keyCode =
    let
        candidate =
            toDirection keyCode
    in
        if opposite model.direction candidate then
            model
        else
            { model | direction = candidate }


toDirection : KeyCode -> Direction
toDirection keyCode =
    case Dict.get keyCode keyCodeToDirection of
        Nothing ->
            Nowhere

        Just direction ->
            direction


keyCodeToDirection : Dict KeyCode Direction
keyCodeToDirection =
    Dict.fromList
        [ ( 37, Left ), ( 38, Up ), ( 39, Right ), ( 40, Down ) ]


opposite : Direction -> Direction -> Bool
opposite a b =
    List.member [ a, b ] oppositors


oppositors : List (List Direction)
oppositors =
    [ [ Left, Right ], [ Right, Left ], [ Up, Down ], [ Down, Up ] ]


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

                Nowhere ->
                    identity

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
