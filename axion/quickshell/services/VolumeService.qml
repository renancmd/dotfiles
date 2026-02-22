import QtQuick
import Quickshell.Io

Item {
    id: root
    property string volumeText: "󰖁 --%"

    Process {
        id: volProcess
        command: ["bash", "-c", "~/.config/quickshell/scripts/get_volume.sh"]
        stdout: SplitParser {
            onRead: data => { root.volumeText = data }
        }
    }

    Timer {
        interval: 1000 // Atualiza a cada 1 segundo
        running: true
        repeat: true
        onTriggered: volProcess.running = true
    }
    
    Component.onCompleted: volProcess.running = true
}
