import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    readonly property bool embeddedDev: Qt.platform.pluginName === "eglfs"

    id: window
    width: embeddedDev ? 480 : 800
    height: embeddedDev ? 800 : 480
    visible: true
    title: qsTr("Alpha Control Interface")

    FontLoader {
        id: prismaFont
        source: Qt.resolvedUrl("go_fonts/Go-Regular.ttf")
    }

    Page {
        anchors.centerIn: parent
        width: embeddedDev ? window.height : window.width
        height: embeddedDev ? window.width : window.height
        rotation: embeddedDev ? 270 : 0
        padding: 10
        font.family: prismaFont.name
        background: Image {
            fillMode: Image.PreserveAspectCrop
            source: Qt.resolvedUrl("assets/BrushedMetal.jpg")
        }

        RowLayout {
            anchors.fill: parent
            spacing: 1

            Sidebar {
                id: zone1
                stackView: zone2
                Layout.fillHeight: true
                Layout.preferredWidth: 100
            }

            StackView {
                id: zone2
                Layout.fillHeight: true
                Layout.fillWidth: true
                initialItem: Qt.resolvedUrl("home/Home.qml")
            }
        }
    }
}
