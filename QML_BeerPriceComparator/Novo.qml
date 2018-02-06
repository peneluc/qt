import QtQuick 2.8
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.1

Page {
    title: "Novo Item"

    property string dataSelecionada: ""

    Column {
        spacing: 10
        anchors { fill: parent; margins: 16 }

        Label { text: "Digite o NOME da cerveja" }
        TextField {
            id: nome
            width: parent.width
        }

        Label { text: "Digite o VOLUME do item" }
        TextField {
            id: volume
            width: parent.width
        }

        Label { text: "Digite o VALOR do produto" }
        TextField {
            id: valor
            width: parent.width
        }

        Label { text: "Digite o LOCAL de venda" }
        TextField {
            id: local
            width: parent.width
        }

        Button {
            text: "Salvar"
            width: parent.width
            onClicked: {
                //function salvarItem(id, nome, volume, valor, local)
                var result = database.incluirItem(nome.text, volume.text, valor.text, local.text)
                if (result) {
                    showdialog("OK", "Dados registrados com sucesso!")
                    nome.text = volume.text = valor.text = local.text = ""
                } else {
                    showdialog("Erro!", "Não foi possível salvar a informação!")
                }
            }
        }
    }
}
