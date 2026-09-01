// components/Launcher.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell
import Qt.labs.folderlistmodel
import Qt5Compat.GraphicalEffects

Rectangle {
  id: launcherRoot
  width: 450
  height: 500
  radius: 18
  border.color: "#313244"
  border.width: 1

  gradient: Gradient {
    GradientStop { position: 0.0; color: "#1e1e2e" }
    GradientStop { position: 1.0; color: "#17171f" }
  }

  layer.enabled: true
  layer.effect: DropShadow {
    transparentBorder: true
    horizontalOffset: 0
    verticalOffset: 10
    radius: 28
    samples: 57
    color: "#90000000"
  }

  signal closeRequested()

  onVisibleChanged: {
    if (visible) {
      searchInput.forceActiveFocus();
    }
  }

  MouseArea {
    anchors.fill: parent
  }

  property int activeSection: 0

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 16
    spacing: 16

    // 1. Sections (Web, Apps, Wallpapers)
    RowLayout {
      Layout.fillWidth: true
      spacing: 12

      component SectionButton: Rectangle {
	id: secBtn
	property string iconText: ""
	property string title: ""
	property int sectionIndex: 0

	property bool isActive: launcherRoot.activeSection === sectionIndex

	Layout.fillWidth: true
	height: 36
	radius: 8
	color: isActive ? "#313244" : (secHover.containsMouse ? "#232336" : "transparent")
	border.color: isActive ? "#89b4fa" : "transparent"
	border.width: 1

	Behavior on color { ColorAnimation { duration: 150 } }
	Behavior on border.color { ColorAnimation { duration: 150 } }

	Row {
	  anchors.centerIn: parent
	  spacing: 8

	  Text {
	    text: secBtn.iconText
	    color: secBtn.isActive ? "#89b4fa" : "#a6adc8"
	    font.pixelSize: 14
	    anchors.verticalCenter: parent.verticalCenter
	  }
	  Text {
	    text: secBtn.title
	    color: secBtn.isActive ? "#cdd6f4" : "#a6adc8"
	    font.bold: secBtn.isActive
	    font.pixelSize: 14
	    anchors.verticalCenter: parent.verticalCenter
	  }
	}

	MouseArea {
	  id: secHover
	  anchors.fill: parent
	  hoverEnabled: true
	  cursorShape: Qt.PointingHandCursor
	  onClicked: {
	    launcherRoot.activeSection = secBtn.sectionIndex;
	    searchInput.forceActiveFocus();
	  }
	}
      }

      SectionButton { iconText: "󰣆"; title: "Apps"; sectionIndex: 0 }
      SectionButton { iconText: "󰸉"; title: "Wallpapers"; sectionIndex: 1 }
    }

    // 2. Search Bar
    Rectangle {
      Layout.fillWidth: true
      height: 44
      color: "#181825"
      radius: 10
      border.color: searchInput.activeFocus ? "#89b4fa" : "#313244"
      border.width: 1

      Behavior on border.color { ColorAnimation { duration: 150 } }

      RowLayout {
	anchors.fill: parent
	anchors.leftMargin: 12
	anchors.rightMargin: 12
	spacing: 10

	Text {
	  text: "" 
	  color: "#a6adc8"
	  font.pixelSize: 16
	}

	TextField {
	  id: searchInput
	  Layout.fillWidth: true
	  placeholderText: "Search..."
	  placeholderTextColor: "#a6adc8"
	  color: "#cdd6f4"
	  font.pixelSize: 15
	  background: Item {} 
	  verticalAlignment: TextInput.AlignVCenter
	  focus: true 

	  // === ESCAPE KEY FIX IS HERE ===
	  Keys.onEscapePressed: launcherRoot.closeRequested()

	  onAccepted: {
	    if (launcherRoot.activeSection === 0) {
	      if (appsList.count > 0) {
		let firstApp = appsList.model.values[0];
		firstApp.execute();
		searchInput.text = "";
		launcherRoot.closeRequested();
	      }
	    }
	  }
	}
      }
    }

    // 3. Main Content Area
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: "#181825"
      radius: 10

      Item {
	anchors.fill: parent
	anchors.margins: 12

	// --- TAB 0: APPS ---
	ListView {
	  id: appsList
	  anchors.fill: parent
	  visible: launcherRoot.activeSection === 0
	  clip: true
	  spacing: 4

	  model: ScriptModel {
	    values: {
	      let query = searchInput.text.toLowerCase().trim();
	      let allApps = DesktopEntries.applications.values;

	      if (query === "") return allApps;
	      return allApps.filter(app => 
	      app.name.toLowerCase().includes(query) || 
	      (app.comment && app.comment.toLowerCase().includes(query))
	    );
	  }
	}

	delegate: Rectangle {
	  width: ListView.view.width
	  height: 48
	  color: hoverArea.containsMouse ? "#313244" : "transparent"
	  radius: 8

	  Behavior on color { ColorAnimation { duration: 120 } }

	  RowLayout {
	    anchors.fill: parent
	    anchors.leftMargin: 12
	    anchors.rightMargin: 12
	    spacing: 12

	    Image {
	      source: Quickshell.iconPath(modelData.icon)
	      Layout.preferredWidth: 28
	      Layout.preferredHeight: 28
	    }

	    Column {
	      Layout.fillWidth: true
	      Layout.alignment: Qt.AlignVCenter 

	      Text {
		text: modelData.name
		color: "#cdd6f4"
		font.pixelSize: 14
		font.bold: true
	      }
	      Text {
		text: modelData.comment || ""
		color: "#a6adc8"
		font.pixelSize: 11
		elide: Text.ElideRight
		width: parent.width
		visible: modelData.comment !== ""
	      }
	    }
	  }

	  MouseArea {
	    id: hoverArea
	    anchors.fill: parent
	    hoverEnabled: true
	    cursorShape: Qt.PointingHandCursor
	    onClicked: {
	      modelData.execute();
	      searchInput.text = "";
	      launcherRoot.closeRequested();
	    }
	  }
	}
      }

      // --- TAB 1: WALLPAPERS ---
      GridView {
	id: wallpaperGrid
	anchors.fill: parent
	visible: launcherRoot.activeSection === 1
	clip: true

	cellWidth: width / 3
	cellHeight: 100

	model: FolderListModel {
	  folder: Qt.resolvedUrl("../assets") 
	  nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.gif"]
	  showDirs: false
	}

	delegate: Item {
	  width: wallpaperGrid.cellWidth
	  height: wallpaperGrid.cellHeight

	  Rectangle {
	    anchors.fill: parent
	    anchors.margins: 4
	    color: "transparent"
	    radius: 10
	    border.color: hoverAreaWall.containsMouse ? "#89b4fa" : "transparent"
	    border.width: 2
	    clip: true
	    scale: hoverAreaWall.containsMouse ? 1.03 : 1.0

	    Behavior on border.color { ColorAnimation { duration: 150 } }
	    Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

	    Image {
	      anchors.fill: parent
	      anchors.margins: 2
	      source: fileUrl
	      fillMode: Image.PreserveAspectCrop
	    }

	    MouseArea {
	      id: hoverAreaWall
	      anchors.fill: parent
	      hoverEnabled: true
	      cursorShape: Qt.PointingHandCursor
	      onClicked: {
		let wallPath = String(filePath);
		let cmd = "sh -c 'awww img \"" + wallPath + "\" --transition-type grow --transition-pos 0.5,0.5 --transition-duration 1 && wal -i \"" + wallPath + "\" -n -q && qs ipc call theme reload'";
		Hyprland.dispatch("exec " + cmd);
		launcherRoot.closeRequested();
	      }
	    }
	  }
	}
      }
    }
  }
}
}
