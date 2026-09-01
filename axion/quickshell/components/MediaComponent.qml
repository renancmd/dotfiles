import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Io

Item {
  id: mediaRoot

  implicitWidth: contentRow.implicitWidth
  implicitHeight: 28

  // Só considera players do Spotify (ex: ignora abas do YouTube no navegador)
  property var player: {
    let players = Mpris.players.values;
    for (let i = 0; i < players.length; i++) {
      let p = players[i];
      let identity = (p.identity || "").toLowerCase();
      let dbusName = (p.dbusName || "").toLowerCase();
      let desktopEntry = (p.desktopEntry || "").toLowerCase();
      if (identity.includes("spotify") || dbusName.includes("spotify") || desktopEntry.includes("spotify")) {
        return p;
      }
    }
    return null;
  }

  property bool isPlaying: {
    if (!player) return false;
    return player.playbackState === 0 || String(player.playbackState).includes("Playing");
  }

  signal clicked()

  Process {
    id: sysInfo
    command: ["sh", "-c", "echo \"$HOSTNAME - $USER\""]
    running: true
    property string fallbackText: "Loading..."

    stdout: StdioCollector {
      onStreamFinished: sysInfo.fallbackText = text ? text.trim() : "axion - nan"
    }
  }

  Row {
    id: contentRow
    anchors.centerIn: parent
    spacing: 8

    Text {
      id: mediaIcon
      text: mediaRoot.player ? "󰓇" : "󰒋"
      color: hoverArea.containsMouse ? "#a6d0ff" : "#89b4fa"
      font.pixelSize: 16
      anchors.verticalCenter: parent.verticalCenter

      Behavior on color { ColorAnimation { duration: 150 } }

      RotationAnimation on rotation {
        running: mediaRoot.player && mediaRoot.isPlaying
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 4000
      }
    }

    Text {
      id: mediaText
      text: {
	if (!mediaRoot.player || !mediaRoot.player.trackTitle) return sysInfo.fallbackText;
	let artist = (mediaRoot.player.trackArtists && mediaRoot.player.trackArtists.length > 0) ? (Array.isArray(mediaRoot.player.trackArtists) ? mediaRoot.player.trackArtists[0] : mediaRoot.player.trackArtists) : mediaRoot.player.identity;
	return artist + " - " + mediaRoot.player.trackTitle;
      }
      color: hoverArea.containsMouse ? "#ffffff" : "#cdd6f4"
      font.family: "Roboto"
      font.pixelSize: 13
      anchors.verticalCenter: parent.verticalCenter
      elide: Text.ElideRight
      width: Math.min(implicitWidth, 220)

      Behavior on color { ColorAnimation { duration: 150 } }
    }
  }

  MouseArea {
    id: hoverArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: mediaRoot.clicked()
  }
}
