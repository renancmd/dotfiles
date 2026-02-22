import QtQuick
import Quickshell.Io

Item {
    id: root
    property string networkIcon: "󰤭"

    Process {
        id: netProcess
        command: ["bash", "-c", "~/.config/quickshell/scripts/get_network.sh"]
        stdout: SplitParser {
            onRead: data => { root.networkIcon = data }
        }
    }

    Timer {
        interval: 3000 // Atualiza a cada 3 segundos
        running: true
        repeat: true
        onTriggered: netProcess.running = true
    }
    
    Component.onCompleted: netProcess.running = true
}
