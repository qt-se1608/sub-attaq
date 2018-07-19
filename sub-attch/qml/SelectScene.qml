//author xulu
import QtQuick 2.0
import VPlay 2.0

Scene {
      id:selectLevelScene
      state:"selectLevel"
      // by default, set the opacity to 0 - this will be changed from the main.qml with PropertyChanges
        opacity: 0
        // we set the visible property to false if opacity is 0 because the renderer skips invisible items, this is an performance improvement
        visible: opacity > 0
        // if the scene is invisible, we disable it. In Qt 5, components are also enabled if they are invisible. This means any MouseArea in the Scene would still be active even we hide the Scene, since we do not want this to happen, we disable the Scene (and therefore also its children) if it is hidden
        width: 640
        height: 960
        enabled: visible
        signal backButtonPressd
        signal levelPressed
        signal level2Pressed


      // background
      Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#ece468"
      }
      //button of back menu
      MenuButton {
        text: "Back"
        width: 150
        height: 80
        anchors.right: selectLevelScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.gameWindowAnchorItem.top
        anchors.topMargin: 10

        onClicked: backButtonPressed()
      }
      //level button
      Grid {
           anchors.centerIn: parent
           spacing: 10
           columns: 3
           MenuButton {
               color: "pink"
             text: "1"
             width: 150
             height: 80
             onClicked: {
               levelPressed()
             }
           }
           MenuButton {
             color: "pink"
             text: "2"
             width: 150
             height: 80
             onClicked: {
               level2Pressed()
             }
           }
           MenuButton {
               color: "pink"
             text: "3"
             width: 150
             height: 80
             onClicked: {
               levelPressed("Level3.qml")
             }
           }
           Repeater {
             model: 6
             MenuButton {
                 color: "pink"
               text: " "
               width: 150
               height: 80
             }
           }
         }
}


