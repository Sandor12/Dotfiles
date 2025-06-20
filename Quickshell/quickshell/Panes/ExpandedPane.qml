import QtQuick
import QtQuick.Layouts

import "../Data/" as Dat
import "../Widgets/" as Wid

Rectangle {
  id: root

  clip: true
  color: Dat.Colors.withAlpha(Dat.Colors.surface, 0.9)
  radius: 20

  RowLayout {
    anchors.fill: parent
    spacing: 0

    CentralPane {
      Layout.fillHeight: true
      Layout.fillWidth: true
      radius: root.radius
    }
    // Rectangle {
    //   Layout.fillHeight: true
    //   Layout.fillWidth: true
    //   radius: root.radius
    // }
    Wid.CalendarView {
      Layout.fillHeight: true
      Layout.fillWidth: true
      radius: root.radius
    }
  }
}
