import QtQuick
import Quickshell.Hyprland

Row {
  spacing: 8

  Repeater {
    model: 5

    Rectangle {
      id: wsPill

      property bool isActive: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === (index + 1)

      width: isActive ? 26 : 24
      height: 24
      radius: 8
      anchors.verticalCenter: parent ? parent.verticalCenter : undefined

      color: isActive ? "#89b4fa" : (hoverArea.containsMouse ? "#313244" : "transparent")
      border.color: isActive ? "#89b4fa" : (hoverArea.containsMouse ? "#585b70" : "#45475a")
      border.width: 1

      scale: isActive ? 1.05 : (hoverArea.containsMouse ? 1.04 : 1.0)

      Behavior on width { NumberAnimation { duration: 160; easing.type: Easing.OutCubic } }
      Behavior on color { ColorAnimation { duration: 160 } }
      Behavior on border.color { ColorAnimation { duration: 160 } }
      Behavior on scale { NumberAnimation { duration: 160; easing.type: Easing.OutBack } }

      Text {
	text: index + 1
	anchors.centerIn: parent
	color: isActive ? "#1e1e2e" : "#cdd6f4"
	font.bold: isActive
	font.pixelSize: 12

	Behavior on color { ColorAnimation { duration: 160 } }
      }

      MouseArea {
	id: hoverArea
	anchors.fill: parent
	hoverEnabled: true
	cursorShape: Qt.PointingHandCursor
	onClicked: Hyprland.dispatch("workspace " + (index + 1))
      }
    }
  }
}
