import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Rectangle {
    id: menuRoot
    width: 340
    // Dynamically size height based on contents
    height: mainLayout.implicitHeight + 32
    color: "#1e1e2e"
    radius: 12
    border.color: "#313244"
    border.width: 1

    // Sinal para solicitar o fechamento ao elemento pai
    signal closeRequested

    // Permite que o widget receba foco do teclado para capturar o Esc
    focus: true
    Keys.onEscapePressed: menuRoot.closeRequested()

    // Captura o clique com o botão direito em qualquer lugar do widget
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: menuRoot.closeRequested()
    }

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: 16
        spacing: 24

        // ==========================================
        // SECTION 1: PROFILE & UPTIME
        // ==========================================
        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            // Avatar Circle
            Rectangle {
                Layout.preferredWidth: 56
                Layout.preferredHeight: 56
                radius: 28
                color: "#313244"
                border.color: "#89b4fa"
                border.width: 2
                clip: true

                Text {
                    anchors.centerIn: parent
                    text: "󰣇" // Arch icon as default avatar
                    color: "#89b4fa"
                    font.pixelSize: 32
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    id: usernameText
                    text: "Loading..."
                    color: "#cdd6f4"
                    font.pixelSize: 18
                    font.bold: true
                }

                Text {
                    id: uptimeText
                    text: "up ..."
                    color: "#a6adc8"
                    font.pixelSize: 13
                }
            }

            // Fetch Username once
            Process {
                command: ["whoami"]
                running: true
                onExited: usernameText.text = stdout ? "@" + String(stdout).trim() : "@user"
            }

            // Fetch Uptime periodically
            Process {
                id: uptimeCmd
                command: ["uptime", "-p"]
                running: true
                onExited: uptimeText.text = stdout ? String(stdout).trim() : "uptime unknown"
            }
            Timer {
                interval: 60000 // Update uptime every minute
                running: true
                repeat: true
                onTriggered: {
                    uptimeCmd.running = false;
                    uptimeCmd.running = true;
                }
            }
        }

        // ==========================================
        // SECTION 2: CLOCK & DATE
        // ==========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 4

            Text {
                id: bigClockText
                Layout.alignment: Qt.AlignHCenter
                color: "#cdd6f4"
                font.pixelSize: 36
                font.bold: true
            }

            Text {
                id: dateText
                Layout.alignment: Qt.AlignHCenter
                color: "#a6adc8"
                font.pixelSize: 14
                font.weight: Font.Medium
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    let now = new Date();
                    bigClockText.text = Qt.formatTime(now, "hh:mm:ss ap");
                    dateText.text = Qt.formatDateTime(now, "MM/dd/yyyy, dddd");
                }
                Component.onCompleted: {
                    let now = new Date();
                    bigClockText.text = Qt.formatTime(now, "hh:mm:ss ap");
                    dateText.text = Qt.formatDateTime(now, "MM/dd/yyyy, dddd");
                }
            }
        }

        // ==========================================
        // SECTION 3: SYSTEM PERFORMANCE
        // ==========================================
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 24

            CircularBar {
                id: cpuBar
                barColor: "#f38ba8"
                labelText: "CPU"
            }
            CircularBar {
                id: ramBar
                barColor: "#a6e3a1"
                labelText: "RAM"
            }
            CircularBar {
                id: diskBar
                barColor: "#f9e2af"
                labelText: "DISK"
            }

            // --- Bash Processes to fetch live stats ---

            // CPU: Uses top to grab idle percentage and subtracts from 100
            Process {
                id: cpuCmd
                command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'"]
                onExited: cpuBar.value = stdout ? parseFloat(String(stdout).trim()) : 0
            }

            // RAM: Uses free to calculate used memory percentage
            Process {
                id: ramCmd
                command: ["sh", "-c", "free -m | awk 'NR==2{printf \"%.0f\", $3*100/$2 }'"]
                onExited: ramBar.value = stdout ? parseFloat(String(stdout).trim()) : 0
            }

            // DISK: Uses df to get the root partition capacity percentage
            Process {
                id: diskCmd
                command: ["sh", "-c", "df -h / | awk '$NF==\"/\"{printf \"%s\", $5}' | tr -d '%'"]
                onExited: diskBar.value = stdout ? parseFloat(String(stdout).trim()) : 0
            }

            // Refresh Stats every 3 seconds
            Timer {
                interval: 3000
                running: true
                repeat: true
                onTriggered: {
                    // Força a atualização alternando o estado running
                    cpuCmd.running = false;
                    cpuCmd.running = true;
                    ramCmd.running = false;
                    ramCmd.running = true;
                    diskCmd.running = false;
                    diskCmd.running = true;
                }
                Component.onCompleted: {
                    cpuCmd.running = true;
                    ramCmd.running = true;
                    diskCmd.running = true;
                }
            }
        }
    }

    // Custom Component for Circular Progress
    component CircularBar: Item {
        id: rootBar
        width: 70
        height: 70

        property real value: 0
        property string barColor: "#89b4fa"
        property string labelText: ""

        Canvas {
            id: canvas
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);

                var centerX = width / 2;
                var centerY = height / 2;
                var radius = (width / 2) - 6;

                // Draw Background Track
                ctx.beginPath();
                ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
                ctx.lineWidth = 6;
                ctx.strokeStyle = "#313244";
                ctx.stroke();

                // Draw Foreground Progress
                ctx.beginPath();
                var startAngle = -Math.PI / 2;
                var endAngle = startAngle + (rootBar.value / 100) * 2 * Math.PI;
                ctx.arc(centerX, centerY, radius, startAngle, endAngle);
                ctx.lineWidth = 6;
                ctx.strokeStyle = rootBar.barColor;
                ctx.lineCap = "round";
                ctx.stroke();
            }

            Connections {
                target: rootBar
                function onValueChanged() {
                    canvas.requestPaint();
                }
            }
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 2

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: isNaN(rootBar.value) ? "0%" : Math.round(rootBar.value) + "%"
                color: "#cdd6f4"
                font.pixelSize: 12
                font.bold: true
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: rootBar.labelText
                color: "#a6adc8"
                font.pixelSize: 10
            }
        }
    }
}
