import QtQuick 2.0
Rectangle {
    width: 200
    height: 40
    color: "#00000000"
    property int firstDice: Math.random()*6 +1;
    property int secondDice: Math.random()*6 +1;
    property int bounesDiceFirst: if(firstDice == secondDice) firstDice; else 0
    property int bounesDiceSecond: if(firstDice == secondDice) firstDice; else 0
    property bool firstDiceUsed: true
    property bool secondDiceUsed: true
    property bool firstBounesDiceUsed: if(diceRemain <= 3) true;else false
    property bool secondBounesDiceUsed: if(diceRemain <= 2 ) true;else false
    property int diceRemain: 0
    function roleDice()
    {
        firstDice = Math.random()*6 +1;
        secondDice = Math.random()*6 +1;
        firstDiceUsed = false
        secondDiceUsed = false
        if(firstDice == secondDice)
        {
            diceRemain = 4
        }

        updateSelectables();
    }
    function getOpacity(dice)
    {
        if(dice)
            return 0.2
        return 1
    }

    function diceNumberImageSource(number)
    {
        switch(number)
        {
        case 1:
            return "qrc:/image/1.png";
        case 2:
            return "qrc:/image/2.png";
        case 3:
            return "qrc:/image/3.png";
        case 4:
            return "qrc:/image/4.png";
        case 5:
            return "qrc:/image/5.png";
        case 6:
            return "qrc:/image/6.png";
        case 0:
            return "qrc:/image/1.png";
        }
    }
    function disableDice(number)
    {
        if(firstDice == secondDice)
        {
            diceRemain = diceRemain - number/firstDice
            if(diceRemain <= 0)secondDiceUsed = true
            if(diceRemain <= 1)firstDiceUsed = true

            return
        }
        if(firstDice!==secondDice)
        {
            if(!firstDiceUsed && number === firstDice)
            {
                firstDiceUsed = true
                return
            }
            if(!secondDiceUsed && number === secondDice)
            {
                secondDiceUsed = true
                return
            }
            if(!firstDiceUsed && !secondDiceUsed && firstDice+secondDice === number)
            {
                firstDiceUsed = true
                secondDiceUsed = true
                return
            }
        }
        console.log("disable dice Error")
    }

    MouseArea{
//        enabled: firstDiceUsed && secondDiceUsed && firstBounesDiceUsed && secondBounesDiceUsed
        anchors.fill: parent
        z:1
        onClicked: {
            roleDice()
        }
    }

    Row{
        Item {
            width: 40
            height: 40
            visible: !bounesDiceFirst
        }
        Dice{
            visible: bounesDiceFirst
            source: diceNumberImageSource(bounesDiceFirst)
            opacity: getOpacity(firstBounesDiceUsed)
        }

        Dice{
            visible: bounesDiceSecond
            source: diceNumberImageSource(bounesDiceSecond)
            opacity: getOpacity(secondBounesDiceUsed)
        }
        Dice{
            visible: firstDice
            source: diceNumberImageSource(firstDice)
            opacity: getOpacity(firstDiceUsed)
        }
        Dice{
            visible: secondDice
            source: diceNumberImageSource(secondDice)
            opacity: getOpacity(secondDiceUsed)
        }

    }
}

