#include "appengine.h"

AppCore::AppCore(QObject *parent) : QObject(parent)
{
    receiver = new serReceiver;

    connect(receiver, &serReceiver::com_msg, this, &AppCore::sendToQml);
    connect(receiver, &serReceiver::plot_msg, this, &AppCore::plotting);

}

void AppCore::readData()
{
    foreach (const QSerialPortInfo &serial_Info, QSerialPortInfo::availablePorts())
        {
            port_name = serial_Info.portName();
        }

        if (port_name != "")
        {
            receiver->set_port_name(port_name);

            receiver->start();
        }
}

void AppCore::receiveFromQml()
{
    readData();
}
