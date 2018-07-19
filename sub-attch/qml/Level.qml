//Write by xudan,the time is 4 july
//The modify by xulu ,4 July afternoon

import QtQuick 2.0
import VPlayPlugins 1.0

import VPlay 2.0

Scene {

    id: gameScene
    state:"game"
    width: /*640*/parent.width
    height:960/*parent.height*/
    opacity: 0
    // we set the visible property to false if opacity is 0 because the renderer skips invisible items, this is an performance improvement
    visible: opacity > 0
    // if the scene is invisible, we disable it. In Qt 5, components are also enabled if they are invisible. This means any MouseArea in the Scene would still be active even we hide the Scene, since we do not want this to happen, we disable the Scene (and therefore also its children) if it is hidden
    enabled: visible
    property int total


    property alias player: boat
    property alias submarine: submarine
    property alias submarine1: submarine1

    Image {
        id: background
        source: "../assets/background.png"
        // since we are using a simple Image element to define our background, we stretch it to avoid any kind of black borders on any device
        width: parent.width*1.8
        height: parent.height*1.8
        anchors.centerIn: parent
    }
    Image {
        id: surface
        source: "../assets/surface.png"
        width: parent.width*1.8
        y:230
        x:-220
    }

    // use a physics world because we need collision detection
    PhysicsWorld {
        id: world
//               gravity.y: 9
        updatesPerSecondForPhysics: 60
    }


    Boat {
        id: boat
        x: 390
        y: 230
        rotation: 0
        inputActionsToKeyCode: {
            "fire": Qt.Key_Down,
                    "up": Qt.Key_Right,
                    "down": Qt.Key_Left,
        }
    }

    Submarine {
        id: submarine
        width: 50
        height: 30
        x: 0
        y: 470
    }

    Submarine {
        id: submarine1
        width: 50
        height: 30
        x: 100
        y: 470
    }

    Wall {
        id: border_bottom

        height: 20
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    Wall {
        id: border_top

        height: 195
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }

    Wall {
        id: border_left
        width: 10
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
    }

    Wall {
        id: border_right
        width: 10
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
    }

    focus: true
    // forward the input keys to both players
    Keys.forwardTo: [gameScene.player.controller]
    signal bbackButtonPressed
    MenuButton {
      text: "Back"
      width: 100
      height: 40
      anchors.right: gameScene.gameWindowAnchorItem.right
      anchors.rightMargin: 10
      anchors.top: gameScene.gameWindowAnchorItem.top
      anchors.topMargin: 10

      onClicked: bbackButtonPressed()
    }
    MenuButton {
      text: score
      width: 100
      height: 40
      anchors.left: gameScene.gameWindowAnchorItem.left
      anchors.rightMargin: 10
      anchors.top: gameScene.gameWindowAnchorItem.top
      anchors.topMargin: 10
}
}
