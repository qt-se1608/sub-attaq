//author xulu ,the first time is 4 July
import QtQuick 2.0
import VPlay 2.0

Scene {
    id:gameoverScene
    state: "gameover"
    width: /*640*/parent.width
    height: /*960*/parent.height

    // by default, set the opacity to 0 - this will be changed from the main.qml with PropertyChanges
      opacity: 0
      // we set the visible property to false if opacity is 0 because the renderer skips invisible items, this is an performance improvement
      visible: opacity > 0
      // if the scene is invisible, we disable it. In Qt 5, components are also enabled if they are invisible. This means any MouseArea in the Scene would still be active even we hide the Scene, since we do not want this to happen, we disable the Scene (and therefore also its children) if it is hidden
      enabled: visible


//backButton signal
       signal backPressed
      Image {
          id: image
          source: "../assets/background.png"
          anchors.fill:parent
      }
      //score of gameover
      Text{
          id:text
          font.family: gameFont.name
          text:"Score:" + score
          anchors.centerIn: parent
          color: "red"
          font.pixelSize: 50
      }
      //button of gameover
      MenuButton{
          text: "back"
          onClicked: backPressed()
          anchors.top:text.bottom
          anchors.left: text.left
          width: 150
          height: 80

      }
      onBackPressed:gameWindow.state = "menu"
}
