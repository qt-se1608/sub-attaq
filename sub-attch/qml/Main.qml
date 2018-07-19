//author xulu.the time is 3 July

import VPlay 2.0
import QtQuick 2.0
import VPlayPlugins 1.0

GameWindow {
    id: gameWindow
    property  int score: 0

    state: "menu"
    screenWidth: 640
    screenHeight: 960


   //activeScene: gameScene

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }
//    GoogleAnalytics {
//      id: ga

//      // property tracking ID from Google Analytics dashboard
//      propertyId: "UA-67377753-2"
//    }

    BackgroundMusic{
        id:backgroundMusic
        source: "../assets/POL-coconut-land-short.wav"
    }
    FontLoader {
        id: gameFont
        source: "../assets/fonts/akaDylan Plain.ttf"
    }

    // menu scene
    MenuScene {
      id: menuScene
      onPlayPressed:{
          gameScene.total=2
          gameWindow.state = "game"
          entityManager.entityContainer = gameScene
          entityManager.removeEntitiesByFilter(["Torpedo","bomb"])
          gameScene.player.image.source = "../assets/boat.png"
          gameScene.player.image.visible = true
          gameScene.player.x = 390
          gameScene.player.y = 230
         // entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Submarine.qml"), {x: 100, y: 470})
          gameScene.submarine.submarineImg.source = "../assets/submarine.png"
          gameScene.submarine.submarineImg.visible = true
          gameScene.submarine1.submarineImg.source = "../assets/submarine.png"
          gameScene.submarine1.submarineImg.visible = true
          joy.playerTwoxisController = gameScene.player.getComponent("TwoAxisController")
      }
    }

    Level{
        id:gameScene
        total: 2
        coun:2
        onBbackButtonPressed: gameWindow.state = "menu"
    }

    Level{
        id:gameScene2
        state: "game2"
        total: 3
        coun:3
        property alias submarine2: submarine2
        Submarine{
                    id: submarine2
                    width: 50
                    height: 30
                    x: 100
                    y: 570
        }

        onBbackButtonPressed: gameWindow.state = "menu"
    }

    // scene for selecting levels
    SelectScene {
      id: selectLevelScene
      onBackButtonPressed: gameWindow.state = "menu"
      onLevelPressed:
      {
          gameWindow.state = "game"
          entityManager.entityContainer = gameScene
          gameScene.total=2
         // entityManager.removeAllEntities()
            entityManager.removeEntitiesByFilter(["Torpedo","bomb"])
         // entityManager.createEntityFromUrl(Qt.resolvedUrl("Bomb.qml"),{}
          gameScene.player.image.source = "../assets/boat.png"
          gameScene.player.image.visible = true
          gameScene.player.x = 390
          gameScene.player.y = 230
          gameScene.submarine.submarineImg.source = "../assets/submarine.png"
          gameScene.submarine.submarineImg.visible = true
          gameScene.submarine1.submarineImg.source = "../assets/submarine.png"
          gameScene.submarine1.submarineImg.visible = true
          joy.playerTwoxisController = gameScene.player.getComponent("TwoAxisController")

      }
      onLevel2Pressed: {
          gameWindow.state = "game2"
          entityManager.entityContainer = gameScene2
          gameScene2.total=3
          //entityManager.removeAllEntities()
            entityManager.removeEntitiesByFilter(["Torpedo","bomb"])
          //entityManager.createEntityFromComponent(submarineComponent)
          gameScene2.player.image.source = "../assets/boat.png"
          gameScene2.player.image.visible = true
          gameScene2.player.x = 390
          gameScene2.player.y = 230
          gameScene2.submarine.submarineImg.source = "../assets/submarine.png"
          gameScene2.submarine.submarineImg.visible = true
          gameScene2.submarine1.submarineImg.source = "../assets/submarine.png"
          gameScene2.submarine1.submarineImg.visible = true
          gameScene2.submarine2.submarineImg.source = "../assets/submarine.png"
          gameScene2.submarine2.submarineImg.visible = true
          joy.playerTwoxisController = gameScene2.player.getComponent("TwoAxisController")
      }
    }


    GameoverScene{
        id:gameoverScene
    }

    states: [
       State {
         name: "menu"
         PropertyChanges {target: menuScene; opacity: 1}
         PropertyChanges {target: gameWindow; activeScene: menuScene}
       },
       State {
         name: "selectLevel"
         PropertyChanges {target: selectLevelScene; opacity: 1}
         PropertyChanges {target: gameWindow; activeScene: selectLevelScene}
       },
       State {
         name: "gameover"
         PropertyChanges {target: gameoverScene; opacity: 1}
         PropertyChanges {target: gameWindow; activeScene: gameoverScene}
       },
       State {
         name: "game"
         PropertyChanges {target: gameScene; opacity: 1}
         PropertyChanges {target: gameWindow; activeScene: gameScene}
       },
        State {
          name: "game2"
          PropertyChanges {target: gameScene2; opacity: 1}
          PropertyChanges {target: gameWindow; activeScene: gameScene2}
        }
     ]

    JoystickControllerHUD {
        id:joy
     anchors.bottom: parent.bottom
     anchors.left: parent.left

     // the joystick width is the space from the left to the start of the logical scene, so the radius is its half
     joystickRadius: gameScene.x/4


     // this allows setting custom images for the JoystickControllerHUD component
     source: "../assets/joystick_background.png"
     thumbSource: "../assets/joystick_thumb.png"


     // this is the mapping between the output of the JoystickControllerHUD to the input of the player's TwoAxisController
     // this is a performance improvement, to not have to bind every time the position changes
     property variant playerTwoxisController: //
gameScene.player.getComponent("TwoAxisController")
     //property variant playerTwoxisController:gameScene2.player.getComponent("TwoAxisController")
     onControllerXPositionChanged: playerTwoxisController.xAxis = controllerXPosition;
     onControllerYPositionChanged: playerTwoxisController.yAxis = controllerYPosition;

}
}
