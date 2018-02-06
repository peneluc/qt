import QtQuick 2.7
import QtQuick.Controls 2.1

Page {
    title: "Cadastrar Cerveja"

    Rectangle{
        id: topBar
        width: parent.width
        height: 35

        Label{
            text: qsTr("Cadastro")
            color:"red"

            font.pointSize: Font.Light
        }
        Rectangle{
            color: "black"
            height: 1
            width: parent.width
            anchors.bottom: parent.bottom
        }
    }

    Column{
        anchors.fill: parent
        anchors.margins:50

        Row {
            id:row1
            anchors.horizontalCenter: parent.horizontalCenter

            Label{
                id: row1label
                text: qsTr("Cerveja: ")
            }
            TextField {
                id: nome
                placeholderText: qsTr("Marca da Cerveja")
                width:parent.parent.width - row1label.width

            }
        }

        Row {
            id: row2
            anchors.horizontalCenter: parent.horizontalCenter
            Label{
                id: row2label1
                text: qsTr("Volume: ")
            }
            TextField {
                id: tamanho
                placeholderText: qsTr("em ml")
                width:parent.parent.width/2 - row2label1.width
            }

            Label{
                id: row2label2
                text: qsTr("Preço: ")
            }
            TextField {
                id: preco
                width:parent.parent.width/2 - row2label1.width
            }
        }

        Row {
            id: row3
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:  10

            Label{
                id: row3label
                text: qsTr("Local: ")
            }
            TextField {
                id: local
                placeholderText: qsTr("Estabelecimento")
                width:parent.parent.width - row3label.width
            }
        }

        Row {
            id: row4
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                id: cadastrar
                text: qsTr("Cadastrar")

                onClicked: {
                    console.log("Cadastro clicked")
                    var volume = tamanho.text + " ml"
                    var rs = databaseInstance.addBeer(nome.text, volume, preco.text, local.text)

                    if(rs){                        
                        nome.clear()
                        tamanho.clear()
                        preco.clear()
                        local.clear()
                    }
                    else{
                        //alert("Cadastro não realizado.")
                    }
                }
            }
        }
    }
}
