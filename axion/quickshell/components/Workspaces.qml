import QtQuick
import Quickshell.Hyprland

Row {
  spacing: 8

  Repeater {
    model: 5

    Rectangle {
      width: 24
      height: 24
      radius: 4


      property bool isActive: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === (index + 1)

      color: isActive ? "#89b4fa" : "transparent"
      border.color: isActive ? "#89b4fa" : "#45475a"
      border.width: 1

      Text {
	text: index + 1
	anchors.centerIn: parent
	color: isActive ? "#1e1e2e" : "#cdd6f4"
	font.bold: true
	font.pixelSize: 12
      }

      MouseArea {
	anchors.fill: parent
	cursorShape: Qt.PointingHandCursor
	onClicked: Hyprland.dispatch("workspace " + (index + 1))
      }
    }
  }
}
