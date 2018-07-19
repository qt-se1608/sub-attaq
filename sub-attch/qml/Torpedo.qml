//Write by xudan.The first time to write is 7.1
//徐露修改了torpedo的发射，torpedo不会突然暂停，7月17号
import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: entity
    entityType: "Torpedo"

    BoxCollider {
        id: boxCollider
        width: 15
        height: 60

        anchors.centerIn: parent

        density: 0.02//密度
        friction: 0//摩擦力
        restitution: 0//弹力
        body.bullet: true
        // we prevent the physics engine from applying rotation to the torpedo, because we will do it ourselves
        body.fixedRotation: true

        linearVelocity.y:-8*32

        fixture.onBeginContact: {
            var fixture = other
            var body = other.getBody()
            var otherEntity = body.target

            // get the entityType of the colliding entity
            var collidingType = otherEntity.entityType

            if ( collidingType === "wall" || collidingType === "Boat" || collidingType === "bomb") {
                entity.removeEntity()

                return
            }

            //applyForwardImpulse()
        }
    }

    Image {
        id: img
        source: "../assets/torpedo.png"
        width: boxCollider.width
        height: boxCollider.height
    }

}
