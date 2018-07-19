//Write by xudan.The first time to write is 7.2
//The modify by xudan,xulu  at 7.3
import QtQuick 2.0

import VPlay 2.0

EntityBase {
    id: entity
    entityType: "bomb"

    Component.onCompleted: {
        console.debug("bomb.onCompleted, width:", width)

        applyForwardImpulse()
    }


    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size; this is important as it specifies the mass of the body! it is in respect to the world size
        width: 10
        height: 10

        anchors.centerIn: parent

        density: 0.02
        friction: 0
        restitution: 0.5
        body.bullet: true
        // we prevent the physics engine from applying rotation to the bomb, because we will do it ourselves
        body.fixedRotation: true

        property var lastWall: null

        fixture.onBeginContact: {
            var fixture = other
            var body = other.getBody()
            var otherEntity = body.target

            // get the entityType of the colliding entity
            var collidingType = otherEntity.entityType

            if (collidingType === "Boat" || collidingType === "wall" || collidingType === "Submarine") {
                entity.removeEntity()
                return
            }
            if(collidingType === "Torpedo"){
                bombImage.running=true
            }


            // it's important to clear the old velocity before applying the impulse, otherwise the bomb would get faster every time it collides with a wall!
           // boxCollider.body.linearVelocity = Qt.point(0,0)

            applyForwardImpulse()
        }
    }

    Image {
        id: image
        source: "../assets/bomb.png"
        anchors.centerIn: parent
        width: boxCollider.width
        height: boxCollider.height
    }

//the animation of bomb when the bomb meet the torpedo
    SequentialAnimation{
        id:bombImage
        running: false
        PropertyAnimation{
            target: image
            properties: "source"
            to:"../assets/explosion/boat/step2.png"
        }
        PropertyAnimation{
            target: image
            properties: "visible"
            to:"false"
        }
    }

//speed and the direction of fire
    function applyForwardImpulse() {
        boxCollider.body.applyLinearImpulse(Qt.point(0,220),boxCollider.body.getWorldCenter())

    }
}
