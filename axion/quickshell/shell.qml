import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

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
        margins {
            top: 8
            left: 14
            right: 14
        }
        height: 42
        color: "transparent"

        // Componente reutilizável: fundo "cápsula" próprio de cada grupo (esquerda/centro/direita)
        component Capsule: Rectangle {
            radius: 14
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
                verticalOffset: 4
                radius: 14
                samples: 29
                color: "#70000000"
            }
        }

        Item {
            anchors.fill: parent

            // ===================== GRUPO ESQUERDA =====================
            Capsule {
                height: parent.height
                width: leftGroup.implicitWidth + 28
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                RowLayout {
                    id: leftGroup
                    anchors.centerIn: parent
                    spacing: 14

                    ArchIcon {
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Clock {
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Rectangle {
                        Layout.preferredWidth: 1
                        Layout.fillHeight: true
                        Layout.topMargin: 4
                        Layout.bottomMargin: 4
                        color: "#313244"
                    }

                    MediaComponent {
                        id: mediaButton
                        Layout.alignment: Qt.AlignVCenter
                        onClicked: mediaPopup.visible = !mediaPopup.visible
                    }
                }
            }

            // ===================== GRUPO CENTRO =====================
            Capsule {
                height: parent.height
                width: centerGroup.implicitWidth + 28
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Workspaces {
                    id: centerGroup
                    anchors.centerIn: parent
                }
            }

            // ===================== GRUPO DIREITA =====================
            Capsule {
                height: parent.height
                width: rightGroup.implicitWidth + 28
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                RowLayout {
                    id: rightGroup
                    anchors.centerIn: parent
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

                    Rectangle {
                        Layout.preferredWidth: 1
                        Layout.fillHeight: true
                        Layout.topMargin: 4
                        Layout.bottomMargin: 4
                        color: "#313244"
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
            margins.top: 10
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
            margins.top: 10
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
            color: "#9c000000"

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
