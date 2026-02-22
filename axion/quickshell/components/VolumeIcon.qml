import QtQuick
import "../services"

Row {
    spacing: 6
    anchors.verticalCenter: parent.verticalCenter

    VolumeService { id: volService }

    Text {
        text: volService.volumeText
        color: "#cdd6f4"
        font.pixelSize: 16
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    }
}
