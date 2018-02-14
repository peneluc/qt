import QtQuick 2.0
import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 2.1

Item {
    width: 512
    height: 512
    visible: true
    property variant locationOslo: QtPositioning.coordinate( 59.93, 10.76)

    Plugin {
        id: mapPlugin
        name: "osm" //"osm", "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Map {
        id: map
        zoomLevel: (maximumZoomLevel - minimumZoomLevel)/2 + 2
        anchors.fill: parent
        plugin: mapPlugin
        center: locationOslo // Oslo

        MapItemView {
            model: searchModel
            delegate: MapQuickItem {
                coordinate: place.location.coordinate

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image { id: image; source: "marker.png" }
                    Text { text: title; font.bold: true }
                }
            }
        }
    }

    PlaceSearchModel {
        id: searchModel

        plugin: mapPlugin

        searchTerm: "Hospital"
        searchArea: QtPositioning.circle(locationOslo)

        Component.onCompleted: update()
    }

    PositionSource {
        id: positionSource
        property variant lastSearchPosition: locationOslo
        active: true
        updateInterval: 120000 // 2 mins
        onPositionChanged:  {
            var currentPosition = positionSource.position.coordinate
            map.center = currentPosition
            var distance = currentPosition.distanceTo(lastSearchPosition)
            if (distance > 500) {
                // 500m from last performed pizza search
                lastSearchPosition = currentPosition
                searchModel.searchArea = QtPositioning.circle(currentPosition)
                searchModel.update()
            }
        }
    }

}
