import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import controller_stmp

Pane {
    id: root
    anchors.fill: parent
    background: null
    padding: 0

    // Sensors
    AS5600Sensor { id: sensor1; busAddress: 0; deviceAddress: 0x40 }
    AS5600Sensor { id: sensor2; busAddress: 0; deviceAddress: 0x41 }
    AS5600Sensor { id: sensor3; busAddress: 0; deviceAddress: 0x42 }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Label {
            id: headerLabel
            Layout.fillWidth: true
            text: "I2C Demo - AS5600L (3 Sensors)"
            font { pixelSize: 32; bold: true }
            horizontalAlignment: Text.AlignHCenter
            topPadding: 20
            bottomPadding: 16
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 24
            Layout.margins: 20

            Repeater {
                model: [
                    { sensor: sensor1, title: "Sensor 1 (0x40)" },
                    { sensor: sensor2, title: "Sensor 2 (0x41)" },
                    { sensor: sensor3, title: "Sensor 3 (0x42)" }
                ]
                delegate: sensorPanel
            }
        }
    }

    Component {
        id: sensorPanel
        ColumnLayout {
            spacing: 12
            Layout.fillWidth: true
            required property AS5600Sensor sensor
            required property string title

            property real zeroOffset: 0
            property real displayAngle: {
                const a = ((sensor.angle - zeroOffset) % 360 + 360) % 360
                return a > 180 ? a - 360 : a
            }
            property bool hasError: !sensor.valid && sensor.errorMessage !== ""

            Label {
                text: title
                font { pixelSize: 19; bold: true }
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                id: errorBox
                Layout.fillWidth: true
                Layout.preferredHeight: hasError ? 32 : 0
                color: "#d32f2f"
                radius: 8
                clip: true
                visible: hasError

                Behavior on Layout.preferredHeight {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }

                Text {
                    anchors.centerIn: parent
                    text: sensor.errorMessage
                    color: "white"
                    font.pixelSize: 15
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    padding: 10
                    wrapMode: Text.Wrap
                }
            }

            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 192
                Layout.preferredHeight: 192
                opacity: sensor.valid ? 1.0 : 0.45
                enabled: sensor.valid

                Image {
                    anchors.centerIn: parent
                    source: Qt.resolvedUrl("../assets/dial_no_background.png")
                    width: 192; height: 192
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    rotation: displayAngle + 140
                }
                Label {
                    text: displayAngle.toFixed(1) + "°"
                    font { pixelSize: 24 }
                    color: sensor.valid ? "#555" : "#999"
                    anchors {
                        top: parent.top
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            RoundButton {
                text: "ZERO"
                font { pixelSize: 24; bold: true }
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: 130
                implicitHeight: 48
                opacity: sensor.valid ? 1.0 : 0.45
                background: Rectangle {
                    radius: width / 2
                    color: parent.pressed ? "#b91c1c" : (sensor.valid ? "#ef4444" : "#999999")
                    border { color: "blue"; width: 4 }
                }
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: zeroOffset = sensor.angle
            }
        }
    }
}