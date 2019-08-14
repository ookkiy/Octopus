import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.13
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import MyPlugins 1.0

Rectangle {
    id: rect1
    anchors.fill: parent
    color: "lightgray"
    
    ListView {
        id: frame
        clip: true
        anchors.fill: parent
        delegate: bubble
        model: chatListModel.model

        ScrollBar.vertical: ScrollBar {
            id: vbar
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Vertical
//            size:  rect1.height/frame.height
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        Component.onCompleted:  {
            chatListModel.shouldPositionView.connect(shouldPositionView)
        }

        function shouldPositionView() {
            positionViewAtEnd()
        }
    }

    Component {
        id: bubble
        Loader {
            id: itemDisplay
            width: parent.width
            height: children[0].height
            sourceComponent: selector()

            function selector() {
                console.log(Content, FileName)
                if (Type == "image") {
                    if (From == me.userid) {
                        return imageMsgRight
                    } else {
                        return imageMsgLeft
                    }
                } else {
                    if (From == me.userid) {
                        return textMsgRight
                    } else {
                        return textMsgLeft
                    }
                }
            }

            Component {
                id: imageMsgRight
                Item {
                    id: row1
                    width: parent.width
                    height: children[0].height

                    BorderImage {
                        height: content.height + 30
                        width: content.width + 40
                        border { left: 26; top: 27; right: 27; bottom: 21 }
                        horizontalTileMode: BorderImage.Stretch
                        verticalTileMode: BorderImage.Stretch
                        source: "qrc:/bubble.png"
                        anchors.right: parent.right

                        Item {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            MyImage1 {
                                id: content
                                anchors.centerIn: parent
                                source: socket.cachedFilePath(FileName)
                                width: imageSize.height < 300 ? (imageSize.width > frame.width ? frame.width*0.7 : imageSize.width) : height/imageSize.height * imageSize.width
                                height: imageSize.height < 300 ? (width / imageSize.width * imageSize.height) : 300
                            }

                            MouseArea {
                                anchors.fill: parent
                                onDoubleClicked: {
                                    socket.viewImage(socket.cachedFilePath(FileName))
                                }
                            }
                        }
                    }
                }
            }

            Component {
                id: imageMsgLeft
                Item {
                    id: row1
                    width: parent.width
                    height: children[0].height

                    BorderImage {
                        height: content.height + 30
                        width: content.width + 40
                        border { left: 26; top: 27; right: 27; bottom: 21 }
                        horizontalTileMode: BorderImage.Stretch
                        verticalTileMode: BorderImage.Stretch
                        source: "qrc:/bubbleLeft.png"
                        anchors.left: parent.left

                        Item {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10

                            MyImage1 {
                                id: content
                                anchors.centerIn: parent
                                source: socket.cachedFilePath(FileName)
                                width: imageSize.height < 300 ? (imageSize.width > frame.width ? frame.width*0.7 : imageSize.width) : height/imageSize.height * imageSize.width
                                height: imageSize.height < 300 ? (width / imageSize.width * imageSize.height) : 300
                            }
                            MouseArea {
                                anchors.fill: parent
                                onDoubleClicked: {
                                    socket.viewImage(socket.cachedFilePath(FileName))
                                }
                            }
                        }
                    }
                }
            }

            Component {
                id: textMsgRight
                Item {
                    id: row1
                    width: parent.width
                    height: children[0].height

                    BorderImage {
                        height: content.paintedHeight + 30
                        width: content.paintedWidth + 40
                        border { left: 26; top: 27; right: 27; bottom: 21 }
                        horizontalTileMode: BorderImage.Stretch
                        verticalTileMode: BorderImage.Stretch
                        source: "qrc:/bubble.png"
                        anchors.right: parent.right

                        Item {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            //TextEdit {
                            TextArea{
                                id: content
                                width: row1.width * 0.8
                                font.pixelSize : 20

                                textFormat :TextEdit.PlainText
                                selectByMouse :true
                                selectByKeyboard :true
                                antialiasing: true
                                readOnly: true
                                wrapMode: TextEdit.Wrap
                                text: Content ? Content : ""
                            }
                        }
                    }
                }
            }

            Component {
                id: textMsgLeft
                Item {
                    id: row1
                    width: parent.width
                    height: children[0].height

                    BorderImage {
                        height: content.paintedHeight + 30
                        width: content.paintedWidth + 40
                        border { left: 26; top: 27; right: 27; bottom: 21 }
                        horizontalTileMode: BorderImage.Stretch
                        verticalTileMode: BorderImage.Stretch
                        source: "qrc:/bubbleLeft.png"
                        anchors.left: parent.left

                        Item {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            anchors.topMargin: 10
                            anchors.bottomMargin: 10
                            //TextEdit {
                            TextArea{
                                id: content
                                width: row1.width * 0.8
                                font.pixelSize : 20

                                textFormat :TextEdit.PlainText
                                selectByMouse :true
                                selectByKeyboard :true
                                antialiasing: true
                                readOnly: true
                                wrapMode: TextEdit.Wrap
                                text: Content ? Content : ""
                            }

                        }
                    }
                }
            }
        }
    }


}