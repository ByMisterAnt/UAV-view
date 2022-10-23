#include "SerialPort.cpp"
#include "serreceiver.h"
#include <QTimer>

#define DATA_LENGTH 32

serReceiver::serReceiver(QObject *parent) :
    QThread { parent }
{
        timer = new QTimer(this);

        connect(timer, SIGNAL(timeout()), this, SLOT(go_plot()));

        timer->start(200);

        QTimer *secTimer = new QTimer(this);
        connect(secTimer, SIGNAL(timeout()), this, SLOT(update()));
        secTimer->start(200);
}

void serReceiver::set_port_name(QString port_name)
{

    port = port_name;

    qDebug() << port;

}

void serReceiver::go_plot()
{
    if ( ready_plot )
    {
        emit plot_msg(QVector<double>{static_cast<double>(time), static_cast<double>(-pitch), static_cast<double>(-roll), static_cast<double>(-yaw)});
    }
}

void serReceiver::update()
{
    time += 0.2;
}

void serReceiver::run()
{
    std::string S("\\\\.\\");

    S += port.toStdString();

    SerialPort *board;

    char receivedString[DATA_LENGTH];

    board = new SerialPort(S.c_str());

    std::vector<int> v;

while (board->isConnected())
{
      int hasRead = board->readSerialPort(receivedString, DATA_LENGTH);

      if (hasRead)
      {
        ready_plot = 1;

        std::string S(receivedString);

        //std::replace(S.begin(), S.end(), ',', ' ');

        std::stringstream ss(S);

        copy(std::istream_iterator<int>(ss), {}, back_inserter(v));

        sscanf(receivedString, "%f %f %f\n", &roll, &pitch, &yaw);

        if ( ( roll > 90 || roll < -90 || pitch > 90 || pitch < 90 ) )
        {
            emit com_msg({static_cast<double>(pitch), static_cast<double>(roll), static_cast<double>(yaw), time});
        }

        v.clear();

      }

}
board->closeSerial();
}
