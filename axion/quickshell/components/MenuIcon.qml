import QtQuick

Item {
  id: menuBtn

  implicitWidth: 30
  implicitHeight: 26

  scale: hoverArea.pressed ? 0.92 : 1.0
  Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }

  Text {
    text: "󰍜"
    color: hoverArea.containsMouse ? "#89b4fa" : "#cdd6f4"
    font.pixelSize: 16
    anchors.centerIn: parent

    Behavior on color { ColorAnimation { duration: 150 } }
  }

  MouseArea {
    id: hoverArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: sysMenuPopup.visible = !sysMenuPopup.visible
  }
}
