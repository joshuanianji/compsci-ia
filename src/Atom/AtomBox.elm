{-
   AtomBox holds the specifications to make each little box in the periodic table.

   Also Colours is my own module, not Elm's

-}


module Atom.AtomBox exposing (atomBox)

import Atom.Atom exposing (..)
import Atom.HardCodedData exposing (..)
import Colours
import Element exposing (Element, alignLeft, centerX, centerY, column, fill, maximum, minimum, pointer, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Msg exposing (Msg(..))



-- this is literally just for the element symbol


atomSymbol : Atom -> Element Msg
atomSymbol atom =
    Element.el
        [ centerX
        , Font.size 30
        , Font.bold
        , Font.color (Colours.stateColour atom.state)
        ]
        (text atom.symbol)



-- just to display the element name below the element symbol


atomName : Atom -> Element Msg
atomName atom =
    Element.el
        [ centerX
        , Font.size 10
        ]
        (text atom.name)



-- displays the element number (amount of protons)


atomNum : Atom -> Element Msg
atomNum atom =
    Element.el
        [ centerX
        , Font.size 8
        ]
        (text <| String.fromInt <| atom.protons)



-- border stuff - I only want the bottom border!!


borderWidths =
    { bottom = 2
    , left = 0
    , right = 0
    , top = 0
    }



{-

   This is just to display the element box on the periodic table

   Because the boxes don't have borders around them, I made them have a margin of about 10. You actually don't see that here because the margin is the `Element.spacing 10` in the Main.elm.

   They also have a fixed width cuz I need them to be uniform. Right now, I have width fill because idk how long the names are going to be, but I have a todo to change the width after I'm done

   TBH 70px seems like a good amount though

   pointer (near the bottom of the Attribute Msg list) allows the mouse to be pointed when hovering the atomBox

-}


atomBox : Atom -> Element Msg
atomBox atom =
    column
        [ width (Element.px 70)
        , Element.spacing 2
        , Element.padding 10
        , Background.color Colours.atomBoxBackground
        , Font.color Colours.fontColour
        , Border.widthEach borderWidths
        , Border.color (Colours.sectionColour atom.section)
        , pointer
        , onClick (ZoomAtom atom)
        ]
        [ atomNum atom
        , atomSymbol atom
        , atomName atom

        -- because I don't need atomic weight haha
        -- , atomWeight atom
        ]
