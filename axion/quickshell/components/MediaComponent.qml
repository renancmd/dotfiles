import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Io

Item {
  id: mediaRoot


  implicitWidth: contentRow.implicitWidth
  implicitHeight: contentRow.implicitHeight

  property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
  signal clicked()

  Process {
    id: sysInfo
    command: ["sh", "-c", "echo \"$HOSTNAME - $USER\""]
    running: true
    property string fallbackText: "Loading..."

    onExited: fallbackText = stdout ? stdout.trim() : "axion - nan"
  }

  Row {
    id: contentRow
    anchors.centerIn: parent
    spacing: 8

    Text {
      id: mediaIcon
      text: mediaRoot.player ? "󰓇" : "󰒋" 
      color: "#89b4fa" 
      font.pixelSize: 16
      anchors.verticalCenter: parent.verticalCenter
    }

    Text {
      id: mediaText
      text: {
	if (!mediaRoot.player || !mediaRoot.player.trackTitle) return sysInfo.fallbackText;
	let artist = (mediaRoot.player.trackArtists && mediaRoot.player.trackArtists.length > 0) ? mediaRoot.player.trackArtists[0] : mediaRoot.player.identity;
	return artist + " - " + mediaRoot.player.trackTitle;
      }
      color: "#cdd6f4" 
      font.pixelSize: 14
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: mediaRoot.clicked()
  }
}
