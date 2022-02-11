#include "SerialPort.cpp"
#include "serreceiver.h"

#define DATA_LENGTH 30

serReceiver::serReceiver(QObject *parent) :
    QThread { parent }
{}

void serReceiver::set_port_name(QString port_name)
{

    port = port_name;

    qDebug() << port;

}

void serReceiver::run()
{

    qDebug() << port << "ggg";

    std::string S("\\\\.\\");

    S += port.toStdString();

    float yaw = 0, pitch = 0, roll = 0;

    SerialPort *board;

    char receivedString[DATA_LENGTH];

    board = new SerialPort(S.c_str());

    std::vector<int> v;

while (board->isConnected())
{

      int hasRead = board->readSerialPort(receivedString, DATA_LENGTH);

      if (hasRead)
      {

        std::string S(receivedString);

        std::replace(S.begin(), S.end(), ',', ' ');

        std::stringstream ss(S);

        copy(std::istream_iterator<int>(ss), {}, back_inserter(v));

        sscanf(receivedString, "%f,%f,%f\n", &roll, &pitch, &yaw);

        v.clear();

        emit com_msg({static_cast<double>(pitch), static_cast<double>(roll), static_cast<double>(yaw)});

      }

}
board->closeSerial();
}
