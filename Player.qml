import QtQuick 2.0

Item {
    width: 150
    height: 45
    function setPlayer(comicNumber,name,points)
    {
        playerName = name
    }
    function imageOfNumber(num)
    {
        return "qrc:/comic/"+num+".png"
    }

    property string playerName: "سید مهرداد شبیری ورنوسفادرانی"
    property int playerPoints: 0
    property int playerRank: 0
    property int playerComic: 10

    Image
    {
        source: "qrc:/image/oldpaper.png"
        width: parent.width
        height: 50
    }
    Image {
        id: playerComicText
        height: 36
        width: 30
        x: 8
        y: 8
        opacity: 0.8
        source: imageOfNumber(playerComic)
    }
    Column{
        x: 42
        y: 8
        Text {
            id: playerNameText
            text: playerName.substring(0,13) + "..."
            color: "#441904"
            font.pixelSize: 10
            font.bold: true
        }
        Text {
            id: playerPointsText
            text: qsTr("Points:") + playerPoints
            color: "#441904"
            font.pixelSize: 10
        }
        Text {
            id: playerRankText
            text: qsTr("Rank:") + playerRank
            color: "#441904"
            font.pixelSize: 10
        }


    }

}
