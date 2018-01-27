import QtQuick 2.0
import QtGraphicalEffects 1.0
Rectangle {
    id:place
    width: 25
    height: 125
    color: "#00000000"
//    onIsEnableForTargetChanged: {
//        if(isEnableForTarget)
//        {
//            anim3.start()
//        }
//        else
//        {
//            anim3.stop()
//            anim4.stop()
//        }
//    }

    property int placeNumber: -1
    property int mohreCount: 0
    property bool whiteHouse: true
    property bool diceHelp: false
    property bool isSelectableConsiderTarget: false

    property int mohreTargeHelper: if(isAloneBlack) 0; else if(mohreCount<=5) mohreCount; else 5
    property int xOffset : if(isTakePlaceRight)29; else 77
    property int mohreX: if(placeNumber < 13)x + xOffset; else 444 - x + xOffset;
    property int mohreYS: if(placeNumber < 13)m1.width * (mohreTargeHelper-1) +12 ; else 125 -m1.width * (mohreTargeHelper-1) +163
    property int mohreYT: if(m5.visible)mohreYS;else if(placeNumber < 13)m1.width * (mohreTargeHelper) +12 ; else 125 -m1.width * (mohreTargeHelper) +163

    property bool isAloneBlack: if(!whiteHouse && mohreCount == 1)true; else false
    property bool isWhiteTower: if(mohreCount >= 2 && whiteHouse)true; else false
    property bool isEnableForSelect : if(!isAnyItemSelected && whiteHouse && mohreCount > 0 && !isAnyWhiteMohreDied && isSelectableConsiderTarget && (!firstDiceUsed || !secondDiceUsed))true; else false
    property bool isEnableByAnyDice: if(mohreCount < 2 || whiteHouse ) true;else false
    property bool isEnableForTarget : if((mohreCount < 2 || whiteHouse) && diceHelp && isAnyItemSelected) true;else false

    property bool isEnable : if(!isAnyItemSelected)isEnableForSelect; else isEnableForTarget
    Rectangle{
        id:gr
        x:10
        y: -10
        radius: 50
        width: 5
        height: 5
        color: "white"
        visible: isEnableForTarget && isAnyItemSelected
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
    }
    MouseArea{
        enabled: isEnable
        width: 36
        height: parent.height +20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            placeClicked(place);
        }
    }
    Rectangle{
        id: glowRect
        y: (mohreTargeHelper-1)* m1.height
        visible: if(isEnableForSelect) true;else false
        radius: 50
        color: "#000000"
        width: m1.width
        height: m1.height
        z:-1
    }
    Glow {
        id: glow
          anchors.fill: glowRect
          visible: glowRect.visible && !isAnimationRunning
          radius: 8
          samples: 17
          color: "green"
          source: glowRect
//          onVisibleChanged: {
//              if(visible)
//              {
//                  anim1.start()
//              }
//              else
//              {
//                  anim1.stop()/*
//                  anim2.stop()*/
//              }
//          }

//          PropertyAnimation{
//            id:anim1
//            target:  glow
//            property: "samples"
//            duration: 1000
////            onStopped: anim2.start()
//            from: 17
//            to: 10
//          }
//          PropertyAnimation{
//            id:anim2
//            target:  glow
//            property: "samples"
//            duration: 1000
//            onStopped: anim1.start()
//            from: 10
//            to: 17
//          }
      }
    Column{
        width: parent.width
        height: parent.height
        Mohre{
            id:m1
            visible: if(mohreCount >= 1)true;else false
            isWhite: whiteHouse
            rotation: if(placeNumber >12) 180;else 0
            z: if(placeNumber >12) 5 ;else 1
        }
        Mohre{
            id:m2
            visible: if(mohreCount >= 2)true;else false
            isWhite: whiteHouse
            rotation: if(placeNumber >12) 180;else 0
            z: if(placeNumber >12) 4 ;else 2
        }
        Mohre{
            id:m3
            visible: if(mohreCount >= 3)true;else false
            isWhite: whiteHouse
            rotation: if(placeNumber >12) 180;else 0
            z:3
        }
        Mohre{
            id:m4
            visible: if(mohreCount >= 4)true;else false
            isWhite: whiteHouse
            rotation: if(placeNumber >12) 180;else 0
            z: if(placeNumber >12) 2 ;else 4
        }
        Mohre{
            id:m5
            visible: if(mohreCount >= 5)true;else false
            isWhite: whiteHouse
            rotation: if(placeNumber >12) 180;else 0
            z: if(placeNumber >12) 1 ;else 5
            Text {
                id: numberOfMohres
                anchors.centerIn: parent
                visible: if(mohreCount >= 6)true;else false
                color: if(whiteHouse)"black"; else "white"
                text: mohreCount
            }
        }
    }
}

