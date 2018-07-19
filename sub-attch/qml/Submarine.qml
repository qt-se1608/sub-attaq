//Write by xudan.The first time to write is 7.1
import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: submarine


    entityType: "Submarine"
    property  alias submarineImg: submarineImg
    preventFromRemovalFromEntityManager: true


    Image {
        id: submarineImg
        source: "../assets/submarine.png"
        anchors.fill: parent
    }

    BoxCollider {
        id: submaineCollider
        anchors.fill: submarineImg
        body.bullet: true

        force: Qt.point(0,80)
        fixture.onContactChanged: {
            var fixture = other
            var body = other.getBody()
            var otherEntity = body.target

            // get the entityType of the colliding entity
            var collidingType = otherEntity.entityType
            if(collidingType === "bomb"){
                die()
            }
        }
    }


//the animation of submarine explosion
    //write by xulu
    SequentialAnimation{
        id:submarineImage
        running: false
        PropertyAnimation{
            target: submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step1.png"
        }
        PropertyAnimation{
            target:submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step2.png"
        }
        PropertyAnimation{
            target: submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step3.png"
        }
        PropertyAnimation{
            target: submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step4.png"
        }
        PropertyAnimation{
            target: submarineImg
            properties: "visible"
            to:"false"
        }
    }

    //the movement of submarine

    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        NumberAnimation {
            target: submarine
            property: "x"
            to: 1900
            from:/*gameScene.width*/x
            duration: Math.random()*3000+4000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: submarine
            property: "x"
            to:/*600*/0
            from:/*0*/1900
            duration: Math.random()*3000+4000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation{
            target: submarine
            property: "y"
            to:540
            from:360
        }
  }

//timer,the random of  terpore fire
//write by xulu,xudan
        property Timer bulletTimer: Timer{
            id:bulletTimer
            interval:Math.random()*2000+2000
            running: submarineImg.visible

            onTriggered: {
                // this is the point that we defined in Submarine.qml for the torpedo to spawn
                var imagePointInWorldCoordinates = mapToItem(
                           gameScene, submarineImg.x, submarineImg.y)

                // create the bomb at the specified position with the rotation of the submarine that fires it
                entityManager.createEntityFromUrlWithProperties(
                            Qt.resolvedUrl("Torpedo.qml"), {
                                x: imagePointInWorldCoordinates.x,
                                y: imagePointInWorldCoordinates.y
                            })
                interval = Math.random()*1000+2000
                bulletTimer.restart()
            }

        }


    function die()
    {
//        total--
//        if(total === 0)
//        {
           submarineImage.running = true
       score += 10
//            total = coun
//        }
//        else/*(submarineImg.visible === true)*/
//        {
//            submarineImage.running = true
//        }
    }
    SequentialAnimation{
        id:submarineImagee
        running: false
        PropertyAnimation{
            target: submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step1.png"
        }
        PropertyAnimation{
            target:submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step2.png"
        }
        PropertyAnimation{
            target: submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step3.png"
        }
        PropertyAnimation{
            target: submarineImg
            properties: "source"
            to:"../assets/explosion/submarine/step4.png"
        }
        PropertyAnimation{
            target: submarineImg
            properties: "visible"
            to:"false"
        }
        PropertyAnimation{
            target: gameWindow
            properties: "state"
            to:"menu"
        }

    }

}
