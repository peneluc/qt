import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6


MapQuickItem {
    property string sourceImg: "qrc:/marker2.png"
    property variant mapQuickItemPlaceCoordinates: QtPositioning.coordinate(-12.6590134, -38.477)

    id: item_marker
    coordinate: mapQuickItemPlaceCoordinates
    anchorPoint.x: image.width * 0.5
    anchorPoint.y: image.height
    sourceItem: Column {
        Image { id: image; source: sourceImg; width: 45; height: width }
    }
}
