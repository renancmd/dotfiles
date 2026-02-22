import QtQuick

Rectangle {

  width: 32

  height: 26

  color: "#313244"

  radius: 6


  Text {

    text: "󰍜"

    color: "#cdd6f4"

    font.pixelSize: 16

    anchors.centerIn: parent

  }


  MouseArea {

    anchors.fill: parent

    cursorShape: Qt.PointingHandCursor

    onClicked: {



      sysMenuPopup.visible = !sysMenuPopup.visible

    }

  }

} 
