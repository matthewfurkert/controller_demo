import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {
    id: sidebar
    property StackView stackView

    // Keep one instance of each page alive (zeroOffset stays saved)
    property var homePage: null
    property var gpioPage: null
    property var i2cPage: null
    property var canPage: null

    background: null
    padding: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        Button {
            text: "Home"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: {
                if (!homePage) homePage = homeComponent.createObject(stackView)
                if (stackView.currentItem !== homePage) {
                    stackView.replace(homePage, StackView.Immediate)
                }
            }
        }
        Button {
            text: "GPIO"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: {
                if (!gpioPage) gpioPage = gpioComponent.createObject(stackView)
                if (stackView.currentItem !== gpioPage) {
                    stackView.replace(gpioPage, StackView.Immediate)
                }
            }
        }
        Button {
            text: "I2C"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: {
                if (!i2cPage) i2cPage = i2cComponent.createObject(stackView)
                if (stackView.currentItem !== i2cPage) {
                    stackView.replace(i2cPage, StackView.Immediate)
                }
            }
        }
        Button {
            text: "CAN"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: {
                if (!canPage) canPage = canComponent.createObject(stackView)
                if (stackView.currentItem !== canPage) {
                    stackView.replace(canPage, StackView.Immediate)
                }
            }
        }
    }

    Component { id: homeComponent; Loader { source: "home/Home.qml" } }
    Component { id: gpioComponent; Loader { source: "gpio/Gpio.qml" } }
    Component { id: i2cComponent;  Loader { source: "i2c/I2c.qml" } }
    Component { id: canComponent;  Loader { source: "can/Can.qml" } }
}