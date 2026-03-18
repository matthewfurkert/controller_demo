import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {
    id: sidebar
    property StackView stackView
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
            onClicked: stackView.replace(homeComponent, StackView.Immediate)
        }
        Button {
            text: "GPIO"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: stackView.replace(gpioComponent, StackView.Immediate)
        }
        Button {
            text: "I2C"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: stackView.replace(i2cComponent, StackView.Immediate)
        }
        Button {
            text: "CAN"
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: null
            onClicked: stackView.replace(canComponent, StackView.Immediate)
        }
    }
    // Component definitions for lazy loading
    Component {
        id: homeComponent
        Loader { source: "home/Home.qml" }
    }
    Component {
        id: gpioComponent
        Loader { source: "gpio/Gpio.qml" }
    }
    Component {
        id: i2cComponent
        Loader { source: "i2c/I2c.qml" }
    }
    Component {
        id: canComponent
        Loader { source: "can/Can.qml" }
    }
}
