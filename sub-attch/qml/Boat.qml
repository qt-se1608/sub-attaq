//Write by xudan.The first time to write is 7.1
//The big modification  was 2 July
import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: boatEntity // the id we use as a reference inside this class

    entityType: "Boat" // always name your entityTypes

    preventFromRemovalFromEntityManager: true

    property alias id: boatEntity
    property alias inputActionsToKeyCode: twoAxisController.inputActionsToKeyCode
    property alias image: image

    // gets accessed to insert the input when touching the HUDController
    property alias controller: twoAxisController

    readonly property real forwardForce: 5000 * world.pixelsPerMeter

    Component.onCompleted: {
        console.debug("boat.onCompleted()")
        console.debug("boat.x:", x)
        var mapped = mapToItem(world.debugDraw, x, y)
        console.debug("boat.x world:", mapped.x)
    }

    // this is used as input for the BoxCollider force  properties
    TwoAxisController {
        id: twoAxisController

        // call the logic function when an input press (possibly the fire event) is received
        onInputActionPressed: handleInputAction(actionName)
    }


    Image {
        id: image
        source: "../assets/boat.png"

        anchors.centerIn: parent
        width: boatCollider.width
        height: boatCollider.height

        property list<Item> imagePoints: [
            // this imagePoint can be used for creation of the bomb
            // it must be far enough in front of the boat that they don't collide upon creation
            // the +10 might have to be adapted if the size of the bomb is changed
            Item {
                x: image.width / 2 + 10
            }
        ]

        //the mobile phone control the direction
        SimpleButton{
            anchors.fill: parent
            opacity: 0
            onClicked:{
                var imagePonintInWoldCoordinates = mapToItem(gameScene,image.x+10,image.y)
                entityManager.createEntityFromUrlWithProperties(
                            Qt.resolvedUrl("Bomb.qml"), {
                                x: imagePonintInWoldCoordinates.x,
                                y: imagePonintInWoldCoordinates.y,
                                rotation: boatEntity.rotation
                            })

            }
        }
    }

    BoxCollider {
        id: boatCollider
        width: 50
        height: 30
        bodyType: Body.Dynamic
        anchors.centerIn: parent

        density: 0.02
        friction: 0.4
        restitution: 0
        body.bullet: true
        body.linearDamping: 10
        body.angularDamping: 15

        //move left and right
        force: Qt.point(twoAxisController.yAxis * forwardForce, 0)

//        Component.onCompleted: {
//            console.debug("boat.physics.x:", x)
//            var mapped = mapToItem(world.debugDraw, x, y)
//            console.debug("boat.physics.x world:", mapped.x)
//        }

        fixture.onBeginContact: {
            var fixture = other
            var body = other.getBody()
            var component = other.getBody().target
            var collidingType = component.entityType
            if(collidingType === "Torpedo")//check collider
            {
                boatImage.running=true
            }

        }

    }
// the animotion of boat when boat meet torpedo
    //write by xulu
    SequentialAnimation{
        id:boatImage
        running: false
        PropertyAnimation{
            target: image
            properties: "source"
            to:"../assets/explosion/boat/step1.png"
        }
        PropertyAnimation{
            target:image
            properties: "source"
            to:"../assets/explosion/boat/step2.png"
        }
        PropertyAnimation{
            target: image
            properties: "source"
            to:"../assets/explosion/boat/step3.png"
        }
        PropertyAnimation{
            target: image
            properties: "source"
            to:"../assets/explosion/boat/step4.png"
        }
        PropertyAnimation{
            target: image
            properties: "visible"
            to:"false"
        }
        PropertyAnimation{
            target: gameWindow
            properties:"state"
            to:"gameover"
        }

    }
//hand the action of fire and create bomb

    function handleInputAction(action) {
        if (action === "fire") {

            // this is the point that we defined in Boat.qml for the rocket to spawn
            var imagePointInWorldCoordinates = mapToItem(
                        gameScene, image.imagePoints[0].x, image.imagePoints[0].y)
            console.debug("imagePointInWorldCoordinates x",
                          imagePointInWorldCoordinates.x, " y:",
                          imagePointInWorldCoordinates.y)

            // create the bomb at the specified position with the rotation of the boat that fires it
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("Bomb.qml"), {
                            x: imagePointInWorldCoordinates.x,
                            y: imagePointInWorldCoordinates.y
                        })
        }
    }
}
