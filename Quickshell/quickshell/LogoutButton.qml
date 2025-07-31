import QtQuick
import Quickshell.Hyprland

QtObject {
	required property string command
	required property string text
	required property string icon
	property var keybind: null

	id: button

	function exec() {
        Hyprland.dispatch(`workspace ${button.command}`)
	}
}
