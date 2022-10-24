import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick3D 1.15
import QtStudio3D.OpenGL 2.5
import QtQuick.Controls 2.15
import QtCharts 2.3

ApplicationWindow
{

id: root

    width: 1920
    height: 1080
    visible: true
    //visibility: "FullScreen"


    Studio3D
    {

        id: studio3D
        visible: true
        anchors.fill: parent

        property double roll: 0.0
        property double yaw: 0.0
        property double pitch: 0.0

        //Presentation settings
        ViewerSettings
        {
            scaleMode: ViewerSettings.ScaleModeFill
        }

        Presentation
        {

            id: pres
            source: "qrc:/UAV-view/bplaView.uia"


            //input data to presentation
            DataInput
            {

                name: "bplaAngles"
                value: Qt.vector3d(studio3D.roll, -studio3D.yaw+158.5, studio3D.pitch)

            }

        }
    }

    RoundButton
    {

            id: menuBtn
            x: parent.width/2 - 50
            y: parent.height*3/4

            width: 100
            height: 100

            visible: true

            onClicked: app.receiveFromQml()

            contentItem: Text
            {

                text: qsTr("Read")
                    font.pointSize: 20
                    font.family: "Tahoma"
                    color: "#ffffff"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

             }

            background: Rectangle
            {

                border.width: 1
                radius: 50
                color: "#99000000"

            }
    }

    CustomChart
    {
        id: heightChartP

        x: root.width - heightChart.width;
        y: 0;

        width: 600
        height: parent.height / 3
        lblText: "Тангаж: "

        chartColor: "red"

    }
    CustomChart
    {
        id: heightChartR

        x: root.width - heightChart.width;
        y: heightChartR.height;

        width: 600
        height: parent.height / 3
        lblText: "Крен: "

        chartColor: "blue"

    }
    CustomChart
    {
        id: heightChartY

        x: root.width - heightChart.width;
        y: 2*heightChartY.height;

        width: 600
        height: parent.height / 3
        lblText: "Курс: "

        chartColor: "green"

    }




    function add_value(time, value, value1, value2)//, lineNumber, lineColor )
        {
            heightChartP.add(time, value);
            heightChartR.add(time, value1);
            heightChartY.add(time, value2);
        }

    Connections
    {

        target: app

        function onSendToQml(count)
        {

            var a = count;
            studio3D.pitch = a[0];
            studio3D.roll = a[1];
            studio3D.yaw = a[2];

        }

        function onPlotting(count)
        {
            var a = count;
            add_value(a[0], a[1], a[2], a[3]);
        }
    }


}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.33}
}
##^##*/
