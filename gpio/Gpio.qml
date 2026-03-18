import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import controller_stmp

Pane {

    Gpio {id: gpioBoard; chip: 0; pin: 14; value: false}
    Gpio {id: gpioRed; chip: 5; pin: 4; value: false}
    Gpio {id: gpioOrange; chip: 5; pin: 6; value: false}
    Gpio {id: gpioGreen; chip: 5; pin: 3; value: false}

    LightShow { id: lightShow; light1: gpioRed
        light2: gpioOrange; light3:  gpioGreen }

    anchors.centerIn: parent
    background: null

    ColumnLayout {
        anchors.left: parent.left
        anchors.leftMargin: 80
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        CheckBox {
            id: checkRed
            checked: gpioRed.value
            onClicked: {
                    if (lightShow.running) { lightShow.stop(); showButton.text = "Light Show" }
                    gpioRed.toggle()
                }
            indicator: Rectangle {
                implicitWidth: 72; implicitHeight: 72; radius: 6
                border.color: "red"
                color: checkRed.checked ? "red" : "white"
            }
            contentItem: Column { leftPadding: 72; spacing: 2
                Text { text: qsTr("Red"); color: "red"; font.pixelSize: 24 }
                Text { text: qsTr("(PF4)"); color: "red"; font.pixelSize: 20 }
            }
        }

        CheckBox {
            id: checkOrange
            checked: gpioOrange.value
            onClicked: {
                    if (lightShow.running) { lightShow.stop(); showButton.text = "Light Show" }
                    gpioOrange.toggle()
                }
            indicator: Rectangle {
                implicitWidth: 72; implicitHeight: 72; radius: 6
                border.color: "orange"
                color: checkOrange.checked ? "orange" : "white"
            }
            contentItem: Column { leftPadding: 72; spacing: 2
                Text { text: qsTr("Orange"); color: "orange"; font.pixelSize: 24 }
                Text { text: qsTr("(PF6)"); color: "orange"; font.pixelSize: 20 }
            }
        }

        CheckBox {
            id: checkGreen
            checked: gpioGreen.value
            onClicked: {
                    if (lightShow.running) { lightShow.stop(); showButton.text = "Light Show" }
                    gpioGreen.toggle()
                }
            indicator: Rectangle {
                implicitWidth: 72; implicitHeight: 72; radius: 6
                border.color: "green"
                color: checkGreen.checked ? "green" : "white"
            }
            contentItem: Column { leftPadding: 72; spacing: 2
                Text { text: qsTr("Green"); color: "green"; font.pixelSize: 24 }
                Text { text: qsTr("(PF3)"); color: "green"; font.pixelSize: 20 }
            }
        }
    }
    ColumnLayout {
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width * 0.5
        height: parent.height

        RowLayout {
            spacing: 40
            Layout.alignment: Qt.AlignHCenter
            ColumnLayout {
                spacing: 30
                Text {
                        text: qsTr("OFF / ON"); color: "black"
                        font.pixelSize: 30; font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                Switch {
                    id: boardLed
                    scale: 3
                    Layout.alignment: Qt.AlignHCenter
                    checked: !gpioBoard.value
                    onCheckedChanged: gpioBoard.value = !checked
                }
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                Item { Layout.preferredHeight: 50 }
                Text {
                    text: qsTr("Board Led")
                    color: "Blue"; font.pixelSize: 24
                    verticalAlignment: Text.AlignBottom
                }
                Text {
                    text: qsTr("(PA14)")
                    color: "Blue"; font.pixelSize: 20
                    verticalAlignment: Text.AlignBottom
                }
            }
        }
        Item { Layout.preferredHeight: 25 }
        Button {
            id: showButton
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Light Show")
            font.pixelSize: 26; font.bold: true

            background: Rectangle {
                implicitWidth: 280; implicitHeight: 85; radius: 16
                color: "purple"; border.color: "brown"; border.width: 3
            }

            contentItem: Text {
                text: parent.text; font: parent.font
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                if (text === "Light Show") {
                    lightShow.start(); text = "Stop Show"
                } else {
                    lightShow.stop(); text = "Light Show"
                }
            }
        }
        Text {
            text: "Build type: " + (gpioBoard.isReal ? "REAL (libgpiod)" : "MOCK")
            font.pixelSize: 20; color: "orange"; Layout.alignment: Qt.AlignHCenter
        }
    }
}
