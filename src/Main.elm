module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Attribute, Html, button, div, h1, h3, h5, input, label, li, p, text, ul)
import Html.Attributes exposing (checked, class, for, id, name, type_, value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { quiz : List QuizQuestion
    , results : Int
    , debug : String
    }


type alias QuizQuestion =
    { question : String
    , options : List QuizOption
    , answer : Maybe QuizOption
    }


type alias QuizOption =
    { label : String
    , rating : Int
    , index : Int
    }



-- Builds the list of questions with the optionsLList


quizQuestions : List QuizQuestion
quizQuestions =
    List.map (\q -> QuizQuestion q quizOptions Nothing) questionsList


quizOptions : List QuizOption
quizOptions =
    List.indexedMap (\i o -> QuizOption o (i + 1) i) optionsList


init : Model
init =
    { quiz = quizQuestions
    , results = 0
    , debug = ""
    }


questionsList : List String
questionsList =
    [ "1. My team can clearly articulate their goals"
    , "2. My team feels recognized for their accomplishments"
    , "3. All team members have personal development plans and see regular progress towards their goals"
    , "4. My team feels empowered to make decisions"
    , "5. My team is more efficient when I’m not there"
    , "6. My team has productive meetings that everyone is involved in (but only when necessary)"
    , "7. Team members will openly express their opinions and concerns"
    , "8. Other people want to be on our team"
    , "9. My team has created their own set of operating guidelines and practices which they are fully bought into"
    , "10. All team members hold each other, including me, accountable for outcomes"
    ]


optionsList : List String
optionsList =
    [ "Strongly Disagree"
    , "Disagree"
    , "Neutral"
    , "Agree"
    , "Strongly Agree"
    ]


type Msg
    = SelectAnswer QuizOption


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectAnswer o ->
            let
                beforeIndex =
                    List.take o.index optionsList

                afterIndex =
                    List.drop (o.index + 1) optionsList

                updatedAnswer =
                    { model | results = o.rating }
            in
            model


view : Model -> Html Msg
view model =
    div [ class "container-fluid p-0" ]
        [ div [ class "sectionDarkBlue row py-5" ]
            [ div [ class "col-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2 text-center" ]
                [ h1 [ class "text-center mb-3" ] [ text "Grade Your Team" ]
                , p [ class "intro" ] [ text "Are you wondering if your team is effective? Are you meeting goals successfully? Take this quiz to find out where your team stands." ]
                ]
            ]
        , div [ class "container mb-5" ]
            [ div [ class "questions row" ] (List.map renderQuestions model.quiz)
            ]
        , div [ class "row" ]
            [ div [ class "col-12 text-center pb-5" ]
                [ button [] [ text "See my results" ]
                ]
            ]
        ]



-- View Helpers


renderQuestions : QuizQuestion -> Html Msg
renderQuestions quizQuestion =
    div [ class "col-12" ]
        [ h5 [ class "mt-5 mb-3" ] [ text quizQuestion.question ]
        , div [ class "answers row d-flex justify-content-between" ]
            (List.map
                (\o ->
                    input
                        [ type_ "button"
                        , class "col-12 col-lg-auto px-5 py-2 m-2 mx-lg-0"
                        , value o.label
                        , onClick (SelectAnswer o)
                        ]
                        []
                )
                quizQuestion.options
            )
        ]
