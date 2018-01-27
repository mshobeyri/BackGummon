import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id:place
    width: 25
    height: 25
    color: "#00000000"//if(isEnable) "blue"; else "skyblue"
    property int mohreCount: 0
    property bool whiteHouse: true
    property bool diceHelp: false
    property bool isSelectSituation
    property int mohreX: 200
    property int mohreTargeHelper: if(mohreCount<=5)mohreCount;else 5
    property int mohreYS: 250
    property int mohreYT: mohreYS
    property int placeNumber: -1
    property bool isSelectableConsiderTarget: false
    property bool isEnableByAnyDice: if(mohreCount < 2 || whiteHouse) true;else false
    property bool isEnableForSelect: whiteHouse && !isAnimationRunning && mohreCount > 0 && (!firstDiceUsed || !secondDiceUsed) && isSelectableConsiderTarget
//    property bool isEnableForTarget : if((mohreCount < 2 || whiteHouse) && diceHelp) true;else false
    property bool isEnable : if(mohreCount > 0 && whiteHouse)true;else false

    MouseArea{
        enabled: isEnable
        anchors.fill: parent
        onClicked: {
            placeClicked(place);
        }
    }
    Rectangle{
        id: glowRect
        visible: if(isEnableForSelect) true;else false
        radius: 50
        color: "#000000"
        width: m1.width
        height: m1.height
        z:-1
    }
    Glow {
          anchors.fill: glowRect
          visible: isEnableForSelect
          radius: 8
          samples: 17
          color: "green"
          source: glowRect
    }

    Column{
        width: parent.width
        height: parent.height
        Mohre{
            id:m1
            visible: if(mohreCount >= 1)true;else false
            isWhite: whiteHouse
            Text {
                id: numberOfMohres
                anchors.centerIn: parent
                visible: if(mohreCount >= 1)true;else false
                rotation: if(placeNumber>12)180;else 0
                color: if(whiteHouse)"black";else "white"
                text: mohreCount
            }
        }
    }
}

