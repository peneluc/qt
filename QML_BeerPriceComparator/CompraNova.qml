import QtQuick 2.7
import QtQuick.Controls 2.1

Page {
    title: "Cadastrar Cerveja"

    header:
        ToolBar {
            Label {
                text: qsTr("Cadastro")
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }

    Column{
        anchors.fill: parent
        anchors.margins:20

        Row {
            width: parent.width

            Label{
                id: row1label
                height: 20
                text: qsTr("Cerveja: ")
            }
        }

        Row {
            width: parent.width

            ComboBox {
                model: ListModel {
                    id: nome
                    ListElement { text: "Skol"}
                    ListElement { text: "Brahma" }
                    ListElement { text: "Proibida" }
                }
                onCurrentIndexChanged:
                {
                    erro.text = ""
                    console.debug(currentText + ", " + nome.get(currentIndex).text)
                }
            }
        }

        Row {
            width: parent.width

            Label{
                id: row2label1
                height: 20
                text: qsTr("Volume: ")
                width: parent.width
            }
        }

        Row {
            width: parent.width

            TextField {
                id: volume
                placeholderText: qsTr("em ml")
                onFocusChanged: erro.text = ""
                width: parent.width
            }

        }

        Row {
            width: parent.width

            Label{
                id: row2label2
                height: 20
                text: qsTr("Preço: ")
                width: parent.width
            }
        }

        Row {
            width: parent.width

            TextField {
                id: preco
                placeholderText: qsTr("R$")
                onFocusChanged: erro.text = ""
                width: parent.width
            }
        }

        Row {
            width: parent.width

            Label{
                id: row3label1
                height: 20
                text: qsTr("Latitude: ")
                width: parent.width
            }
        }

        Row {
            width: parent.width

            TextField {
                id: latitude
                placeholderText: qsTr("Latidude")
                onFocusChanged: erro.text = ""
                width: parent.width
            }

        }

        Row {
            width: parent.width

            Label{
                id: row3label2
                height: 20
                text: qsTr("Logitude: ")
                width: parent.width
            }
        }

        Row {
            width: parent.width

            TextField {
                id: longitude
                placeholderText: qsTr("Longitude")
                onFocusChanged: erro.text = ""
                width: parent.width
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            Button {
                id: cadastrar
                text: qsTr("Cadastrar")
                width:parent.parent.width/2 - width
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: cadastrar.down ? "#d6a6a6" : "#f6f6f6"
                    border.color: "#259595"
                    border.width: 1
                    radius: 4
                }

                onClicked: {
                    console.log("Disparado onClicked do botao Cadastrar")

                    var rs = databaseInstance.addBeer(
                                nome.get(nome.currentIndex).text,
                                volume.text,
                                preco.text,
                                latitude.text,
                                longitude.text)
                    if(rs){
                        //nome.currentIndex = -1
                        volume.clear()
                        preco.clear()
                        latitude.clear()
                        longitude.clear()
                    }
                    else{
                        erro.text = "ERRO: Cadastro não realizado."
                    }
                }
            }

            Button {
                id: cadastrarJSON
                text: qsTr("Cadastrar Online")
                width:parent.parent.width/2 - width
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: cadastrarJSON.down ? "#d6d6d6" : "#f6f6f6"
                    border.color: "#26282a"
                    border.width: 1
                    radius: 4
                }

                onClicked: {
                    console.log("Disparado onClicked do botao Cadastrar")

//                    var rs = databaseJSON.addBeer(
//                                nome.get(nome.currentIndex).text,
//                                volume.text,
//                                preco.text,
//                                latitude.text,
//                                longitude.text)
//                    if(rs){
//                        //nome.currentIndex = -1
//                        volume.clear()
//                        preco.clear()
//                        latitude.clear()
//                        longitude.clear()
//                    }
//                    else{
//                        erro.text = "ERRO: Cadastro não realizado."
//                    }
                }
            }
        }

        Row {
            anchors.horizontalCenter: parent.bottom
            height: 100
            Label{
                id: erro
                text: qsTr(" ")
            }
        }
    }
}
