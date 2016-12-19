module SnakeGame exposing (main)

import AnimationFrame
import Collage exposing (collage)
import Element exposing (toHtml)
import Html exposing (Html)
import Snake exposing (draw, Snake)
import Apple exposing (draw, Apple)
import Time exposing (Time)
import Keyboard


main : Program Never Model Msg
main =
    Html.program
        { init = ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions =
            \_ ->
                Sub.batch
                    [ AnimationFrame.times CurrentTick
                    , Keyboard.ups KeyDown
                    ]
        }


type alias Model =
    { snake : Snake, apple : Apple, lastUpdate : Time, direction : Direction }


type Direction
    = Up
    | Down
    | Right
    | Left


init : Model
init =
    { snake = [ ( 1, 1 ), ( 1, 2 ), ( 1, 3 ) ]
    , apple = ( 0, -1 )
    , lastUpdate = 0
    , direction = Up
    }


type Msg
    = CurrentTick Time
    | KeyDown Int


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        CurrentTick time ->
            if time - model.lastUpdate > 100 then
                step { model | lastUpdate = time } ! []
            else
                model ! []

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


view : Model -> Html a
view { snake, apple } =
    let
        blockSize =
            25

        blocks =
            [ Apple.draw blockSize apple, Snake.draw blockSize snake ]
    in
        blocks
            |> collage 500 500
            |> toHtml
