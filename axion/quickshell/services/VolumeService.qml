import QtQuick
import Quickshell.Io

Item {
    id: root
    property string volumeText: "󰖁 --%"

    function refresh() {
        volProcess.running = false;
        volProcess.running = true;
    }

    function increase() {
        adjustProcess.running = false;
        adjustProcess.command = ["bash", "-c", "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"];
        adjustProcess.running = true;
    }

    function decrease() {
        adjustProcess.running = false;
        adjustProcess.command = ["bash", "-c", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"];
        adjustProcess.running = true;
    }

    function toggleMute() {
        adjustProcess.running = false;
        adjustProcess.command = ["bash", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
        adjustProcess.running = true;
    }

    Process {
        id: volProcess
        command: ["bash", "-c", "~/.config/quickshell/scripts/get_volume.sh"]
        stdout: SplitParser {
            onRead: data => { root.volumeText = data }
        }
    }

    Process {
        id: adjustProcess
        onExited: root.refresh()
    }

    Timer {
        interval: 1000 // Atualiza a cada 1 segundo
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()
}
