import QtQuick

Text {
    id: timeText
    color: "#cdd6f4"
    font.pixelSize: 14
    font.bold: true
    anchors.verticalCenter: parent.verticalCenter

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeText.text = Qt.formatTime(new Date(), "hh:mm ap")
    }

    Component.onCompleted: timeText.text = Qt.formatTime(new Date(), "hh:mm ap")
}
