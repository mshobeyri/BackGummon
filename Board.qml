import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Rectangle{
    id: board
    width: 575
    height: 325
    property var selectedPlace
    property var targetPlace
    property bool isAnyItemSelected: false
    property bool isAnimationRunning: false
    property bool isTakePlaceRight: false
    property bool isGamerWhite: true
    property alias firstDice: diceMaster.firstDice
    property alias secondDice: diceMaster.secondDice
    property alias firstDiceUsed: diceMaster.firstDiceUsed
    property alias secondDiceUsed: diceMaster.secondDiceUsed
    property bool computerTurn: false
    property int diceRemain: diceMaster.diceRemain
    property bool isAnyWhiteMohreDied: if(whiteDiePlace.mohreCount > 0)true; else false
    property var placesList:[place1,place2,place3,place4,place5,place6,place7,place8,place9,place10,place11,place12,
        place13,place14,place15,place16,place17,place18,place19,place20,place21,place22,place23,place24]
    function placeClicked(_place)
    {
        if(!isAnyItemSelected) // enable targets of this selected place
        {
            if((!objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice || firstDiceUsed) &&
                    (!objectOfNumber(_place.placeNumber + secondDice).isEnableByAnyDice || secondDiceUsed))
            {
                return false;
            }
            else
            {
                disableAll()
                if(firstDice !== secondDice)
                {
                    if(objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice && !firstDiceUsed)
                    {
                        objectOfNumber(_place.placeNumber + firstDice).diceHelp = true
                    }

                    if(objectOfNumber(_place.placeNumber + secondDice).isEnableByAnyDice && !secondDiceUsed)
                    {
                        objectOfNumber(_place.placeNumber + secondDice).diceHelp = true
                    }

                    if(objectOfNumber(_place.placeNumber + firstDice + secondDice).isEnableByAnyDice  && !firstDiceUsed && !secondDiceUsed)
                    {
                        objectOfNumber(_place.placeNumber + firstDice + secondDice).diceHelp = true
                    }
                }
                else if(firstDice === secondDice)
                {
                    if(objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice && diceRemain >= 1)
                    {
                        objectOfNumber(_place.placeNumber + firstDice).diceHelp = true
                        if(objectOfNumber(_place.placeNumber + 2*firstDice).isEnableByAnyDice && diceRemain >= 2)
                        {
                            objectOfNumber(_place.placeNumber + 2*firstDice).diceHelp = true
                            if(objectOfNumber(_place.placeNumber + 3*firstDice).isEnableByAnyDice && diceRemain >= 3)
                            {
                                objectOfNumber(_place.placeNumber + 3*firstDice).diceHelp = true
                                if(objectOfNumber(_place.placeNumber + 4*firstDice).isEnableByAnyDice && diceRemain >= 4)
                                {
                                    objectOfNumber(_place.placeNumber + 4*firstDice).diceHelp = true
                                }
                            }
                        }
                    }
                }
            }

            if(_place.mohreCount > 0)selectedPlace = _place;
            isAnyItemSelected = true
        }
        else
        {
            if(firstDice == secondDice)
            {
                var n = (_place.placeNumber - selectedPlace.placeNumber)/firstDice
                switch (n)
                {
                case 4:
                    moves.insert(0,{"isDone":false,
                                     "selectedPlace":objectOfNumber(selectedPlace.placeNumber + 3*firstDice),
                                     "targetPlace":objectOfNumber(selectedPlace.placeNumber + 4*firstDice)})
                case 3:
                    moves.insert(0,{"isDone":false,
                                     "selectedPlace":objectOfNumber(selectedPlace.placeNumber + 2*firstDice),
                                     "targetPlace":objectOfNumber(selectedPlace.placeNumber + 3*firstDice)})
                case 2:
                    moves.insert(0,{"isDone":false,
                                     "selectedPlace":objectOfNumber(selectedPlace.placeNumber + firstDice),
                                     "targetPlace":objectOfNumber(selectedPlace.placeNumber + 2*firstDice)})
                case 1:
                    targetPlace = objectOfNumber(selectedPlace.placeNumber + firstDice);
                    move(selectedPlace,targetPlace);
                    //                    move(objectOfNumber(1),objectOfNumber(23))
                }
            }
            else if(_place.placeNumber - selectedPlace.placeNumber === firstDice + secondDice)
            {
                if(objectOfNumber(selectedPlace.placeNumber + firstDice).diceHelp)
                {
                    moves.insert(0,{"isDone":false,
                                     "selectedPlace":objectOfNumber(selectedPlace.placeNumber + firstDice),
                                     "targetPlace":objectOfNumber(selectedPlace.placeNumber + firstDice +secondDice)})
                    targetPlace = objectOfNumber(selectedPlace.placeNumber + firstDice);
                    move(selectedPlace,targetPlace);
                }
                else
                {
                    moves.insert(0,{"isDone":false,
                                     "selectedPlace":objectOfNumber(selectedPlace.placeNumber + secondDice),
                                     "targetPlace":objectOfNumber(selectedPlace.placeNumber + firstDice +secondDice)})
                    targetPlace = objectOfNumber(selectedPlace.placeNumber + secondDice);
                    move(selectedPlace,targetPlace);
                }

            }
            else
            {
                targetPlace = _place;
                move(selectedPlace,targetPlace);
            }

            disableAll()
        }
    }

    function updateSelectables()
    {
        var _place ;
        if(firstDice !== secondDice)
        {
            if(whiteDiePlace.mohreCount > 0)
            {
                _place = whiteDiePlace
                if((objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice && !firstDiceUsed) ||
                        (objectOfNumber(_place.placeNumber + secondDice).isEnableByAnyDice && !secondDiceUsed))
                {
                    _place.isSelectableConsiderTarget = true
                }
                else
                {
                    _place.isSelectableConsiderTarget = false
                }
                return
            }

            for(var i =0; i <placesList.length ; i++)
            {
                _place = placesList[i]
                if((objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice && !firstDiceUsed) ||
                        (objectOfNumber(_place.placeNumber + secondDice).isEnableByAnyDice && !secondDiceUsed))
                {
                    _place.isSelectableConsiderTarget = true
                }
                else
                {
                    _place.isSelectableConsiderTarget = false
                }
            }
        }
        else
        {
            if(whiteDiePlace.mohreCount > 0)
            {
                _place = whiteDiePlace
                if(objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice && diceMaster.diceRemain > 0)
                {
                    _place.isSelectableConsiderTarget = true
                }
                else
                {
                    _place.isSelectableConsiderTarget = false
                }
                return
            }
            for(var i =0; i <placesList.length ; i++)
            {
                _place = placesList[i]
                if(objectOfNumber(_place.placeNumber + firstDice).isEnableByAnyDice && diceMaster.diceRemain > 0)
                {
                    _place.isSelectableConsiderTarget = true
                }
                else
                {
                    _place.isSelectableConsiderTarget = false
                }
            }
        }
    }

    function move(_selectedPlace, _targetPlace)
    {
        targetPlace = _targetPlace;
        animate(_selectedPlace,_targetPlace,true,0)
        _selectedPlace.mohreCount --;
    }
    function afterMoved()
    {
        isAnyItemSelected = false
        updateSelectables();
    }


    function animate(_selectedPlace,_targetPlace,_isWhite,offset)
    {
        if(offset === 0)diceMaster.disableDice(_targetPlace.placeNumber - _selectedPlace.placeNumber);
        animationMohre.x = _selectedPlace.mohreX
        animationMohre.y = _selectedPlace.mohreYS+offset
        animationMohre.isWhite = _isWhite
        animationMohre.enabled = true
        mohreBehave.enabled = true
        animationMohre.x = _targetPlace.mohreX+0.01
        animationMohre.y = _targetPlace.mohreYT

        mohreBehave.enabled = false
    }

    function hit(_targetPlace)
    {
        hitAnimationMohre.x = _targetPlace.mohreX
        hitAnimationMohre.y = _targetPlace.mohreYT
        _targetPlace.mohreCount --;
        _targetPlace.whiteHouse = ! _targetPlace.whiteHouse
        hitMohreBehave.enabled = true
        hitAnimationMohre.isWhiteHitted = ! _targetPlace.whiteHouse
        if(hitAnimationMohre.isWhiteHitted)
        {
            hitAnimationMohre.x = deiePlaces.x
            hitAnimationMohre.y = deiePlaces.y
        }
        else
        {
            hitAnimationMohre.x = deiePlaces.x
            hitAnimationMohre.y = deiePlaces.y + 40
        }
    }

    function computerMove(selectNum,targetNum)
    {
        var _selectedPlace = objectOfNumber(selectNum);
        var _targetPlace = objectOfNumber(targetNum);
        targetPlace = _targetPlace;
        animationMohre.x = _selectedPlace.mohreX
        animationMohre.y = _selectedPlace.mohreYS
        animationMohre.isWhite = false
        mohreBehave.enabled = true
        isAnimationRunning = true
        _selectedPlace.mohreCount --;
        isAnyItemSelected = false
        animationMohre.x = _targetPlace.mohreX
        animationMohre.y = _targetPlace.mohreYT
        targetPlace.whiteHouse = false
    }

    function objectOfNumber(number)
    {
        switch (number)
        {
        case 1:
            return place1
        case 2:
            return place2
        case 3:
            return place3
        case 4:
            return place4
        case 5:
            return place5
        case 6:
            return place6
        case 7:
            return place7
        case 8:
            return place8
        case 9:
            return place9
        case 10:
            return place10
        case 11:
            return place11
        case 12:
            return place12
        case 13:
            return place13
        case 14:
            return place14
        case 15:
            return place15
        case 16:
            return place16
        case 17:
            return place17
        case 18:
            return place18
        case 19:
            return place19
        case 20:
            return place20
        case 21:
            return place21
        case 22:
            return place22
        case 23:
            return place23
        case 24:
            return place24
        default:
            return placeNull
        }
    }
    function disableAll()
    {
        for(var i=0;i<placesList.length; i++)
        {
            placesList[i].diceHelp = false
        }
    }

    ListModel{
        id:moves
    }

    MouseArea{
        width: 10
        height: 10
        onClicked: isTakePlaceRight = ! isTakePlaceRight
    }
    Image {
        width: parent.width
        height: parent.height
        source: "qrc:/image/board.png"
        mirror: !isTakePlaceRight
    }
    DiceMaster{
        id: diceMaster
        anchors.verticalCenter: parent.verticalCenter
        x : if(isTakePlaceRight)55;else 360
        z:1
    }
    Place{
        id: placeNull
        isEnableByAnyDice: false
        visible: false
    }

    MouseArea{
        id: areaDisabler
        enabled: computerTurn || isAnimationRunning
        anchors.fill: parent
        z: 2
    }
    MouseArea{
        id:cancelSelect
        anchors.fill: parent
        enabled: isAnyItemSelected
        onClicked: {
            isAnyItemSelected = false
            disableAll()
        }
    }
    Item {
        id: deiePlaces
        x:if(isTakePlaceRight)251;else 299
        y:135
        width: 25
        height: 70
        DiedPlace{
            id:whiteDiePlace
            whiteHouse: true
            placeNumber: 0
            mohreCount: 0
            mohreX: deiePlaces.x
            mohreYS: deiePlaces.y
        }
        DiedPlace{
            id:blackDiePlace
            y: 35
            whiteHouse: false
            placeNumber: 0
            mohreCount: 0
            mohreX: deiePlaces.x
            mohreYS: deiePlaces.y+35
        }
    }

    Mohre{
        id:animationMohre
        z:10
        visible: mohreAnimeX.running
        hasShadow: false
        Behavior on x {
            id: mohreBehave
            enabled: false
            PropertyAnimation{
                id: mohreAnimeX
                duration: 1000
                property bool hitState: false
                easing.type: Easing.InOutCubic;
                onRunningChanged: {
                    isAnimationRunning = running
                    if(!running){
                        isAnyItemSelected = false
                        if(hitState)
                        {
                            blackDiePlace.mohreCount ++;
                            hitState = false
                            var b= true
                            for(var i = 0 ; i<moves.count ; i++)
                            {
                                if(moves.get(i).isDone===false)
                                {
                                    selectedPlace = moves.get(i).selectedPlace
                                    targetPlace = moves.get(i).targetPlace
                                    animate(selectedPlace,targetPlace,true,0);
                                    selectedPlace.mohreCount --;
                                    moves.setProperty(i,"isDone",true);
                                    b=false
                                    break
                                }
                            }
                            if(b)updateSelectables();
                        }
                        else
                        {
                            if(targetPlace.isAloneBlack)
                            {
                                hitState = true
                                animate(targetPlace,blackDiePlace,false,25);
                                targetPlace.whiteHouse = true;
                            }
                            else
                            {
                                var isEnded = true
                                targetPlace.mohreCount ++;

                                var b= true
                                for(var i = 0 ; i<moves.count ; i++)
                                {
                                    if(moves.get(i).isDone===false)
                                    {
                                        selectedPlace = moves.get(i).selectedPlace
                                        targetPlace = moves.get(i).targetPlace
                                        animate(selectedPlace,targetPlace,true,0);
                                        selectedPlace.mohreCount --;
                                        moves.setProperty(i,"isDone",true);
                                        b=false
                                        break
                                    }
                                }
                                if(b)updateSelectables();
                            }
                        }
                    }
                }
            }
        }
        Behavior on y {
            enabled: mohreBehave.enabled
            PropertyAnimation{
                duration: mohreAnimeX.duration
                easing.type: mohreAnimeX.easing.type
            }
        }
    }

    Mohre{
        id:hitAnimationMohre
        z:10
        visible: false
        property bool isWhiteHitted: true
        isWhite: isWhiteHitted
        Behavior on x {
            id: hitMohreBehave
            enabled: false
            PropertyAnimation{
                id: hitMohreAnimeX
                duration: 1000
                easing.type: Easing.InOutCubic;
                //                    onStarted: hitAnimationMohre.visible = true
                onRunningChanged:
                {
                    if(running)
                        hitAnimationMohre.visible = true
                    if(!running)
                    {
                        hitAnimationMohre.visible = false
                        isAnimationRunning = false
                        hitMohreBehave.enabled = false
                        if(hitAnimationMohre.isWhiteHitted)
                        {
                            whiteDiePlace.mohreCount ++;
                        }
                        else
                        {
                            blackDiePlace.mohreCount ++;
                        }
                    }
                }
            }
        }
        Behavior on y {
            enabled: hitMohreBehave.enabled

            PropertyAnimation{
                easing.type: hitMohreAnimeX.easing.type
                duration: hitMohreAnimeX.duration
            }
        }
    }

    Row{
        x:if(isTakePlaceRight)29; else 77
        y:12
        spacing: 12
        LayoutMirroring.enabled: isTakePlaceRight
        LayoutMirroring.childrenInherit: isTakePlaceRight
        Place{
            id: place1
            placeNumber: 1
            mohreCount: 2
            whiteHouse: true
        }
        Place{
            id: place2
            placeNumber: 2
        }
        Place{
            id: place3
            placeNumber: 3
        }
        Place{
            id: place4
            placeNumber: 4
        }
        Place{
            id: place5
            placeNumber: 5
        }
        Place{
            id: place6
            placeNumber: 6
            mohreCount: 5
            whiteHouse: false
        }

        Item {
            width: 25
            height: 20
        }
        Place{
            id: place7
            placeNumber: 7
            whiteHouse: false
            mohreCount: 1
        }
        Place{
            id: place8
            placeNumber: 8
            mohreCount: 3
            whiteHouse: false
        }
        Place{
            id: place9
            placeNumber: 9
        }
        Place{
            id: place10
            placeNumber: 10

        }
        Place{
            id: place11
            placeNumber: 11

            whiteHouse: true
            mohreCount: 5
        }
        Place{
            id: place12
            placeNumber: 12
            mohreCount: 5
            whiteHouse: true
        }
    }

    Row{
        spacing: 12
        rotation: 180
        x:if(isTakePlaceRight)29; else 77
        LayoutMirroring.enabled: isTakePlaceRight
        LayoutMirroring.childrenInherit: isTakePlaceRight
        y:188
        Place{
            id: place13
            placeNumber: 13
            mohreCount: 5
            whiteHouse: false
        }
        Place{
            id: place14
            placeNumber: 14
        }
        Place{
            id: place15
            placeNumber: 15
        }
        Place{
            id: place16
            placeNumber: 16
        }
        Place{
            id: place17
            placeNumber: 17
            mohreCount: 3
            whiteHouse: true
        }
        Place{
            id: place18
            placeNumber: 18
        }
        Item {
            width: 25
            height: 20
        }
        Place{
            id: place19
            placeNumber: 19
            mohreCount: 5
            whiteHouse: true
        }
        Place{
            id: place20
            placeNumber: 20
        }
        Place{
            id: place21
            placeNumber: 21
        }
        Place{
            id: place22
            placeNumber: 22
        }
        Place{
            id: place23
            placeNumber: 23
        }
        Place{
            id: place24
            placeNumber: 24
            mohreCount: 2
            whiteHouse: false
        }
    }
}
