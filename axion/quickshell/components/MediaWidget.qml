import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris

Rectangle {
  id: widgetRoot
  width: 340 
  height: 160
  color: "#1e1e2e" 
  radius: 12
  border.color: "#313244" 
  border.width: 1


  property int playerCount: Mpris.players.values.length
  property var player: playerCount > 0 ? Mpris.players.values[0] : null


  property bool isPlaying: {
    if (!player) return false;
    return player.playbackState === 0 || String(player.playbackState).includes("Playing");
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 16
    spacing: 12

    RowLayout {
      Layout.fillWidth: true
      spacing: 12

      Rectangle {
	Layout.preferredWidth: 64
	Layout.preferredHeight: 64
	radius: 8
	color: "#181825" 
	clip: true 

	Image {
	  anchors.fill: parent
	  source: widgetRoot.player && widgetRoot.player.trackArtUrl ? widgetRoot.player.trackArtUrl : ""
	  fillMode: Image.PreserveAspectCrop
	  visible: source !== "" 
	}

	Text {
	  anchors.centerIn: parent
	  text: "󰎆"
	  color: "#cdd6f4" 
	  font.pixelSize: 24
	  visible: parent.children[0].source == "" 
	}
      }

      ColumnLayout {
	Layout.fillWidth: true
	spacing: 4

	Text {

	  text: {
	    if (!widgetRoot.player) return "No Media Playing";
	    if (widgetRoot.player.trackTitle && widgetRoot.player.trackTitle !== "") return widgetRoot.player.trackTitle;
	    return "Unknown Track";
	  }
	  color: "#cdd6f4" 
	  font.bold: true
	  font.pixelSize: 16
	  elide: Text.ElideRight
	  Layout.fillWidth: true
	}
	Text {
	  text: {
	    if (!widgetRoot.player) return "...";
	    if (widgetRoot.player.trackArtists && widgetRoot.player.trackArtists.length > 0) {
	      return widgetRoot.player.trackArtists.join(", ");
	    }
	    return widgetRoot.player.identity || "Unknown Artist";
	  }
	  color: "#89b4fa" 
	  font.pixelSize: 13
	  elide: Text.ElideRight
	  Layout.fillWidth: true
	}
      }
    }

    Slider {
      id: timeline
      Layout.fillWidth: true
      enabled: widgetRoot.player !== null

      from: 0
      to: widgetRoot.player ? widgetRoot.player.length : 1
      value: widgetRoot.player ? widgetRoot.player.position : 0

      onMoved: if (widgetRoot.player) widgetRoot.player.position = value
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: 16

      Text {
	text: "󰒮"
	color: "#cdd6f4" 
	font.pixelSize: 20
	MouseArea {
	  anchors.fill: parent; cursorShape: Qt.PointingHandCursor
	  onClicked: if(widgetRoot.player) widgetRoot.player.previous()
	}
      }

      Text {

	text: widgetRoot.isPlaying ? "󰏤" : "󰐊" 
	color: "#89b4fa" 
	font.pixelSize: 24
	MouseArea {
	  anchors.fill: parent; cursorShape: Qt.PointingHandCursor
	  onClicked: {
	    if(widgetRoot.player) {
 
	      if (widgetRoot.isPlaying) {
		widgetRoot.player.pause();
	      } else {
		widgetRoot.player.play();
	      }
	    }
	  }
	}
      }

      Text {
	text: "󰒭"
	color: "#cdd6f4" 
	font.pixelSize: 20
	MouseArea {
	  anchors.fill: parent; cursorShape: Qt.PointingHandCursor
	  onClicked: if(widgetRoot.player) widgetRoot.player.next()
	}
      }

      Item { Layout.fillWidth: true } 

      RowLayout {
	spacing: 8
	Text { text: "󰕾"; color: "#cdd6f4"; font.pixelSize: 16 }
	Slider {
	  width: 80
	  enabled: widgetRoot.player !== null
	  from: 0
	  to: 1
	  value: widgetRoot.player ? widgetRoot.player.volume : 0
	  onMoved: if(widgetRoot.player) widgetRoot.player.volume = value
	}
      }
    }
  }
}
