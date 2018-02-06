import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

//  Link do papper QMl bit.do/espa04qt

ApplicationWindow {
    id: app
    visible: true
    width: 640
    height: 480
    title: qsTr("Beer Price Comparator")

    Database{
        id: databaseInstance
        onBeerRegistered:
        {
            console.log(">onBeerRegistered")
            beerListPage.beerListViewModel.append(beer)
            console.log("<onBeerRegistered")
        }
        onBeerLoaded: {
            console.log(">onBeerLoaded - beers.length:" + beers.length)
            for(var i=0; i<beers.length; ++i){
                beerListPage.beerListViewModel.append(beers[i])
                console.log("beers " +beers[i].itemId + " | " + beers[i].nome + " | " + beers[i].volume + " | " + beers[i].preco + " | " + beers[i].latitude + " | " + beers[i].longitude )
            }
            console.log("<onBeerLoaded ")
        }
    }

    HttpQmlJson{
        id: databaseJson
        onBeerRegistered:
        {
            console.log(">onBeerRegistered")
            beerListPage.beerListViewModel.append(beer)
            console.log("<onBeerRegistered")
        }
        onBeerLoaded: {
            console.log(">onBeerLoaded - beers.length:" + beers.length)
            for(var i=0; i<beers.length; ++i){
                beerListPage.beerListViewModel.append(beers[i])
                console.log("beers " +beers[i].itemId + " | " + beers[i].nome + " | " + beers[i].volume + " | " + beers[i].preco + " | " + beers[i].latitude + " | " + beers[i].longitude )
            }
            console.log("<onBeerLoaded ")
        }
    }
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        BeerNew{
            id: beerNewPage
        }

        BeerList{
            id: beerListPage
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Cadastre um novo Item")
        }
        TabButton {
            text: qsTr("Visualize as informações")
        }
    }

}
