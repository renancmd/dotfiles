import QtQuick
import "../services"

Item {
    id: volRoot
    implicitWidth: contentRow.implicitWidth
    implicitHeight: contentRow.implicitHeight

    VolumeService { id: volService }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: volService.volumeText
            color: hoverArea.containsMouse ? "#ffffff" : "#cdd6f4"
            font.pixelSize: 16
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter

            Behavior on color { ColorAnimation { duration: 150 } }
        }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        // Clique esquerdo alterna mudo; a roda do mouse ajusta o volume
        onClicked: volService.toggleMute()
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0) {
                volService.increase();
            } else if (wheel.angleDelta.y < 0) {
                volService.decrease();
            }
        }
    }
}
