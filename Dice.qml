import QtQuick 2.0
import QtGraphicalEffects 1.0
Item {
    width: 40
    height: 40
    scale: 0.8
    property string source
    Image {
        id: bd1
        source: parent.source
        anchors.fill: parent
    }
//    DropShadow {
//        anchors.fill: parent
//        horizontalOffset: 6
//        verticalOffset: 6
//        radius: 30
//        samples: 100
//        color: "#80000000"
//        source: bd1
//    }
}
