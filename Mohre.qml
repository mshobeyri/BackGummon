import QtQuick 2.0
import QtGraphicalEffects 1.0
Item{
    width: 25
    height: 25
    property bool isWhite: true
    property bool hasShadow: true

Image {
    id:image
    anchors.fill: parent
    source: if(isGamerWhite)
                if(isWhite) "qrc:/image/w.png"; else "qrc:/image/b.png";
            else
                if(isWhite) "qrc:/image/b.png"; else "qrc:/image/w.png";
}
//Rectangle{
//    width: 25
//    height: 25
//    z: -1
//    color: "gray"
//    opacity: 0.1
//    x:3
//    y:3
//}

//DropShadow {
//        visible: parent.hasShadow
//        anchors.fill: parent
//        horizontalOffset: 3
//        verticalOffset: 3
//        radius: 4
//        samples: 17
//        color: "#80000000"
//        source: image
//    }
}

