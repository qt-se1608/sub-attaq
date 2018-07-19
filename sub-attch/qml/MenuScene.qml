//Write By xulu,xudan,the time is  3 july
//Modify by xulu,the time are 7.6
import QtQuick 2.0
import VPlay 2.0

Scene {
    id:menuScene
    state: "menu"
    width: /*640*/parent.width
    height: /*960*/parent.height

    // by default, set the opacity to 0 - this will be changed from the main.qml with PropertyChanges
      opacity: 0
      // we set the visible property to false if opacity is 0 because the renderer skips invisible items, this is an performance improvement
      visible: opacity > 0
      // if the scene is invisible, we disable it. In Qt 5, components are also enabled if they are invisible. This means any MouseArea in the Scene would still be active even we hide the Scene, since we do not want this to happen, we disable the Scene (and therefore also its children) if it is hidden
      enabled: visible

       // background
      // signal indicating that the selectLevelScene should be displayed
         signal selectLevelPressed
         // signal indicating that the creditsScene should be displayed
         signal playPressed
      Image {
          id: image
          source: "../assets/background.png"
          anchors.fill:parent
      }

      Rectangle {
         id: button
         // this will be the default size, it is same size as the contained text + some padding
         width: buttonText.width+ paddingHorizontal*2
         height: buttonText.height+ paddingVertical*2

         color: "#e9e9e9"
         // round edges
         radius: 10

         // the horizontal margin from the Text element to the Rectangle at both the left and the right side.
         property int paddingHorizontal: 10
         // the vertical margin from the Text element to the Rectangle at both the top and the bottom side.
         property int paddingVertical: 5

         // access the text of the Text component
         property alias text: buttonText.text

         // this handler is called when the button is clicked.
         signal clicked

         Text {
           id: buttonText
           anchors.centerIn: parent
           font.pixelSize: 18
           color: "black"
         }

         MouseArea {
           id: mouseArea
           anchors.fill: parent
           hoverEnabled: true
           onClicked: button.clicked()
           onPressed: button.opacity = 0.5
           onReleased: button.opacity = 1
         }
       }
      Column {
           anchors.centerIn: parent
           //button of select game level
           MenuButton {
             text: "Levels"
             width: 150
             height: 80
             onClicked: selectLevelPressed()
           }
           //button of game begin
           MenuButton {
             text: "Play"
             width: 150
             height: 80
             onClicked: playPressed()
           }
         }
      //report gameover's score
      VPlayGameNetwork {
        id: gameNetwork
        gameId: 173 // put your gameId here
        secret: "doodlefrogsecret12345" // put your game secret here
        gameNetworkView: myGameNetworkView

      }

      VPlayGameNetworkView {
        id: myGameNetworkView
        anchors.fill: menuScene.gameWindowAnchorItem
        visible: false

//come in leaderboard signal control
        onShowCalled: {
          myGameNetworkView.visible = true
            text.visible = false
            butto.visible = false
            //menuScene.visible =false
        }
//back to game menu signal control
        onBackClicked: {
          myGameNetworkView.visible = false
          menuScene.visible = true
            text.visible = true
            butto.visible = true
        }
      }// VPlayGameNetworkView
      MenuButton {
          id:butto
        text: "Show Leaderboards"
        color: "green"
        width: 500
        height: 80
        //y:800
        x:parent.width/2-250
        anchors.bottom: parent.bottom
        onClicked: {
          // open the leaderboard view of the VPlayGameNetworkView

          gameNetwork.reportScore(score)//report score
            score = 0
          gameNetwork.showLeaderboard()

        }
      }
      //game's name
      Text{
          id:text
          text:"sub-attaq"
          font.family: gameFont.name
          font.pixelSize: 80
          x:parent.width/2-290
          y:200
          color: "red"
      }
      onSelectLevelPressed: gameWindow.state = "selectLevel"
      //onPlayPressed: gameWindow.state = "game"


}
