import QtQuick
import "../services"

Item {
    id: netRoot
    implicitWidth: netText.implicitWidth
    implicitHeight: netText.implicitHeight

    NetworkService { id: netService }

    Text {
        id: netText
        anchors.centerIn: parent
        text: netService.networkIcon
        color: hoverArea.containsMouse ? "#ffffff" : "#cdd6f4"
        font.pixelSize: 16

        Behavior on color { ColorAnimation { duration: 150 } }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
