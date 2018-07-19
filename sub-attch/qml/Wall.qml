//Write by xudan.The first time to write is 7.1
import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: entity
    entityType: "wall"

    preventFromRemovalFromEntityManager: true
    BoxCollider {
        id: boxCollider
        bodyType: Body.Static
    }

    Rectangle {
        anchors.fill: parent
        color: "red"
        visible: false
    }
}
