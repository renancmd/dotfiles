import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects

Rectangle {
  id: widgetRoot
  width: 340
  height: 160
  radius: 16
  border.color: "#313244"
  border.width: 1

  gradient: Gradient {
    GradientStop { position: 0.0; color: "#1e1e2e" }
    GradientStop { position: 1.0; color: "#181825" }
  }

  layer.enabled: true
  layer.effect: DropShadow {
    transparentBorder: true
    horizontalOffset: 0
    verticalOffset: 8
    radius: 22
    samples: 45
    color: "#80000000"
  }


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
	radius: 12
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
	      return Array.isArray(widgetRoot.player.trackArtists) ? widgetRoot.player.trackArtists.join(", ") : String(widgetRoot.player.trackArtists);
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

      background: Rectangle {
	x: timeline.leftPadding
	y: timeline.topPadding + timeline.availableHeight / 2 - height / 2
	width: timeline.availableWidth
	height: 4
	radius: 2
	color: "#313244"

	Rectangle {
	  width: timeline.visualPosition * parent.width
	  height: parent.height
	  radius: 2
	  color: "#89b4fa"
	}
      }

      handle: Rectangle {
	x: timeline.leftPadding + timeline.visualPosition * (timeline.availableWidth - width)
	y: timeline.topPadding + timeline.availableHeight / 2 - height / 2
	width: 12
	height: 12
	radius: 6
	color: "#cdd6f4"
	border.color: "#89b4fa"
	border.width: timeline.pressed ? 2 : 0
	scale: timeline.pressed ? 1.15 : 1.0
	Behavior on scale { NumberAnimation { duration: 100 } }
      }
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: 16

      Text {
	text: "󰒮"
	color: prevArea.containsMouse ? "#89b4fa" : "#cdd6f4"
	font.pixelSize: 20
	scale: prevArea.pressed ? 0.88 : 1.0
	Behavior on color { ColorAnimation { duration: 120 } }
	Behavior on scale { NumberAnimation { duration: 100 } }
	MouseArea {
	  id: prevArea
	  anchors.fill: parent
	  anchors.margins: -6
	  hoverEnabled: true
	  cursorShape: Qt.PointingHandCursor
	  onClicked: if(widgetRoot.player) widgetRoot.player.previous()
	}
      }

      Rectangle {
	Layout.preferredWidth: 40
	Layout.preferredHeight: 40
	radius: 20
	color: playArea.containsMouse ? "#313244" : "#181825"
	border.color: "#89b4fa"
	border.width: 1
	scale: playArea.pressed ? 0.92 : 1.0
	Behavior on color { ColorAnimation { duration: 120 } }
	Behavior on scale { NumberAnimation { duration: 100 } }

	Text {
	  anchors.centerIn: parent
	  anchors.horizontalCenterOffset: widgetRoot.isPlaying ? 0 : 1
	  text: widgetRoot.isPlaying ? "󰏤" : "󰐊"
	  color: "#89b4fa"
	  font.pixelSize: 20
	}

	MouseArea {
	  id: playArea
	  anchors.fill: parent
	  hoverEnabled: true
	  cursorShape: Qt.PointingHandCursor
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
	color: nextArea.containsMouse ? "#89b4fa" : "#cdd6f4"
	font.pixelSize: 20
	scale: nextArea.pressed ? 0.88 : 1.0
	Behavior on color { ColorAnimation { duration: 120 } }
	Behavior on scale { NumberAnimation { duration: 100 } }
	MouseArea {
	  id: nextArea
	  anchors.fill: parent
	  anchors.margins: -6
	  hoverEnabled: true
	  cursorShape: Qt.PointingHandCursor
	  onClicked: if(widgetRoot.player) widgetRoot.player.next()
	}
      }

      Item { Layout.fillWidth: true } 

      RowLayout {
	spacing: 8
	Text { text: "󰕾"; color: "#cdd6f4"; font.pixelSize: 16 }
	Slider {
	  id: volSlider
	  width: 80
	  enabled: widgetRoot.player !== null
	  from: 0
	  to: 1
	  value: widgetRoot.player ? widgetRoot.player.volume : 0
	  onMoved: if(widgetRoot.player) widgetRoot.player.volume = value

	  background: Rectangle {
	    x: volSlider.leftPadding
	    y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
	    width: volSlider.availableWidth
	    height: 4
	    radius: 2
	    color: "#313244"

	    Rectangle {
	      width: volSlider.visualPosition * parent.width
	      height: parent.height
	      radius: 2
	      color: "#89b4fa"
	    }
	  }

	  handle: Rectangle {
	    x: volSlider.leftPadding + volSlider.visualPosition * (volSlider.availableWidth - width)
	    y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
	    width: 10
	    height: 10
	    radius: 5
	    color: "#cdd6f4"
	  }
	}
      }
    }
  }
}
