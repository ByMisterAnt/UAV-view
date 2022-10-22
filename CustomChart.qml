import QtQuick 2.15
import QtCharts 2.3
import QtGraphicalEffects 1.0


Item
{
    property string chartTitle: chartTitle
    property color chartColor: "#87CEFA"

    property double xValues: xValues
    property double yValues: yValues

    property string valueAxisXtext: " "
    property string valueAxisYtext: " "

    property int gg: 0

    Rectangle
    {
        //width: parent.width
        //height: parent.height
        anchors.fill: parent
        color: "black"


        Text {
            id: plotValue

            x: plotValue.width + 4
            y: plotValue.height / 2


            color: chartColor
            text: "0"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 28
            minimumPointSize: 34
            minimumPixelSize: 34
        }
    Glow {
        id:glow
        anchors.fill: chartView
        radius: 9
        samples: 22
        color: chartColor
        source: chartView
        transparentBorder: true;
    }
    Glow {
        id:glowText
        anchors.fill: plotValue
        radius: 9
        samples: 22
        color: chartColor
        source: plotValue
        transparentBorder: true;
    }

    RadialBlur {
        anchors.fill: chartView
        source: chartView
        angle: 360
        samples: 20
    }
    ZoomBlur {
        anchors.fill: chartView
        source: chartView
        length: 2
        samples: 20
    }

    ChartView
    {
        id:chartView

        //width: parent.width
        //height: parent.height
        anchors.fill: parent
        backgroundColor: "transparent"
        legend.visible: false

        antialiasing: true
        //animationDuration : 290
        //animationOptions: ChartView.AllAnimations;

        /*layer.enabled: true
        layer.effect: OpacityMask
        {
            maskSource: Item
            {
                width: chartView.width
                height: chartView.height

                Rectangle
                {
                    radius: 15
                    anchors.fill: parent
                }
            }
        }*/

        ValueAxis
        {
            id: valueAxisY

            visible: false
            titleFont.pointSize: 20
            titleFont.family: "Verdana"

            gridLineColor: "black"
            titleText: valueAxisYtext
            min: -1
            max: 1
            labelsFont.pointSize: 15
        }

        ValueAxis
        {
            id: valueAxisX

            visible: false
            titleFont.pointSize: 20
            titleFont.family: "Verdana"

            titleText: valueAxisXtext
            min: 0
            max: 1
            labelsFont.pointSize: 15
            gridLineColor: "black"
        }

        SplineSeries
        {
            id: seriesY

            color: chartColor
            axisX: valueAxisX
            axisY: valueAxisY
            width: 4
        }
    }

             Component.onCompleted:
             {
                 /*for (var i = 0; i <= 50; i++)
                 {
                     seriesY.append(i, Math.random() + Math.random());

                 }*/
             }

             MouseArea
             {
                 anchors.fill: parent

                 onClicked:
                 {
                     valueAxisX.max += 1

                     for (var i = 0; i <= 2; i++)
                 {
                     seriesY.append(parseFloat("23.0, 23, -44"),parseFloat("23.0, 23, -44"));
                     //seriesY.append(i+valueAxisX.max-1, Math.random() + Math.random());

                 }
            }
        }

    }

    function add(x, height)//, size)
    {
        //valueAxisX.max += 1;

        if (height >= valueAxisY.max)
        {
            valueAxisY.max = height * 1.1;
        }
        if (height < valueAxisY.min && height < 0)
        {
            valueAxisY.min = height * 1.1;
        }
        if (x >= valueAxisX.max)
        {
            valueAxisX.max = x;
        }

        //seriesY.append(valueAxisX.max-1, height);
        seriesY.append(x, height);
        gg = height;
        plotValue.text = gg;
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
