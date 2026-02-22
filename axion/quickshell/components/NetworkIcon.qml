import QtQuick
import "../services"

Row {
    spacing: 6
    anchors.verticalCenter: parent.verticalCenter

    NetworkService { id: netService }

    Text {
        text: netService.networkIcon
        color: "#cdd6f4"
        font.pixelSize: 16
        anchors.verticalCenter: parent.verticalCenter
    }
}
