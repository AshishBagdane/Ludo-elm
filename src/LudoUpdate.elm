module LudoUpdate exposing (update)

import Ludo exposing (moveAllPositions)
import LudoModel exposing (Model, Msg(..), defaultPositions)
import Random


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateRandomNumber ->
            ( model, Random.generate NewRandomNumber (Random.int 1 6) )

        NewRandomNumber number ->
            ( if model.diceNum == 0 then
                { model | diceNum = number }

              else
                model
            , Cmd.none
            )

        MoveCoin clickedPosition ->
            ( { diceNum = 0
              , positions = moveAllPositions clickedPosition model
              , turn =
                    if model.diceNum /= 6 then
                        Ludo.nextTurn model.turn

                    else
                        model.turn
              }
            , Cmd.none
            )
