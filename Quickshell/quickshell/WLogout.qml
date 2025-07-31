import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Variants {
	id: root
	property color backgroundColor: "#e60c0c0c"
	property color buttonColor: "#1e1e1e"
	property color buttonHoverColor: "#3700b3"
	default property list<LogoutButton> buttons

	model: Quickshell.screens
	delegate: WlrLayershell {
		id: w

		property var modelData
		screen: modelData

        focusable: false
		exclusionMode: ExclusionMode.Ignore
		//WlrLayershell.layer: WlrLayer.Overlay
		//WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        
        implicitWidth: mar.containsMouse ? 30 : 10
        implicitHeight: 200

		color: "transparent"

		contentItem {
			focus: true
			Keys.onPressed: event => {
                for (let i = 0; i < buttons.length; i++) {
                    let button = buttons[i];
                    if (event.key == button.keybind) button.exec();
                }
                
			}
		}

		anchors {
			//top: true
			left: true
			//bottom: true
			//right: true
		}

		Rectangle {
			//color: backgroundColor;
            height: 50
            color: "#111218"
			anchors.fill: parent
            bottomRightRadius: 20
            topRightRadius: 20

			MouseArea {
                id: mar
				anchors.fill: parent
                hoverEnabled: true
				//onClicked: Qt.quit()

				ColumnLayout {
					anchors.centerIn: parent

					width: parent.width * 1
					height: parent.height * 1

					//columns: 3
					//columnSpacing: 0
					//rowSpacing: 0

					Repeater {
						model: buttons
						delegate: Rectangle {
							required property LogoutButton modelData;

							Layout.fillWidth: true
							Layout.fillHeight: true
                            radius: 20

							color: ma.containsMouse ? buttonHoverColor : buttonColor
                            border.color: "#4B4853"
							border.width: ma.containsMouse ? 0 : 1

							MouseArea {
								id: ma
								anchors.fill: parent
								hoverEnabled: true
								onClicked: modelData.exec()
							}
						}
					}
				}
			}
		}
	}
}
