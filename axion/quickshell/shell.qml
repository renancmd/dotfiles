import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "components"
import "services"

ShellRoot {
    id: root

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            launcherPopup.visible = !launcherPopup.visible;
        }
    }

    PanelWindow {
        id: barWindow
        anchors {
            top: true
            left: true
            right: true
        }
        height: 36
        color: "transparent"

        Rectangle {
            id: bar
            anchors.fill: parent
            color: "#111318"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8

                RowLayout {
                    spacing: 12

                    ArchIcon {
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Clock {
                        Layout.alignment: Qt.AlignVCenter
                    }

                    MediaComponent {
                        id: mediaButton
                        Layout.alignment: Qt.AlignVCenter
                        onClicked: mediaPopup.visible = !mediaPopup.visible
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Workspaces {}

                Item {
                    Layout.fillWidth: true
                }

                RowLayout {
                    spacing: 12

                    RowLayout {
                        spacing: 6
                        NetworkIcon {
                            Layout.alignment: Qt.AlignVCenter
                        }
                        VolumeIcon {
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }

                    MenuIcon {
                        id: menuButton
                        // Certifique-se de que o ícone tenha um onClicked para abrir o menu:
                        // onClicked: sysMenuPopup.visible = !sysMenuPopup.visible
                    }
                }
            }
        }
    }

    PopupWindow {
        id: sysMenuPopup
        visible: false
        width: menuWidget.width
        height: menuWidget.height
        color: "transparent"

        anchor {
            item: menuButton
            edges: Edges.Bottom | Edges.Left
            gravity: Edges.Bottom | Edges.Right
        }

        // Puxa o foco assim que a janela se torna visível
        onVisibleChanged: {
            if (visible) {
                menuWidget.forceActiveFocus();
            }
        }

        MenuWidget {
            id: menuWidget
            // Esconde o menu quando o widget pede para fechar (Esc ou Botão Direito)
            onCloseRequested: sysMenuPopup.visible = false
        }
    }

    PopupWindow {
        id: mediaPopup
        visible: false
        width: mediaWidget.width
        height: mediaWidget.height
        color: "transparent"

        anchor {
            item: mediaButton
            edges: Edges.Bottom | Edges.Left
            gravity: Edges.Bottom | Edges.Right
        }

        MediaWidget {
            id: mediaWidget
        }
    }

    PanelWindow {
        id: launcherPopup
        visible: false

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        color: "transparent"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

        Rectangle {
            anchors.fill: parent
            color: "#80000000"

            MouseArea {
                anchors.fill: parent
                onClicked: launcherPopup.visible = false
            }
        }

        Launcher {
            id: launcher
            anchors.centerIn: parent
            onCloseRequested: launcherPopup.visible = false
        }

        Shortcut {
            sequence: "esc"
            onActivated: launcherPopup.visible = false
        }
    }
}
