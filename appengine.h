#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>

#include <QSerialPortInfo>
#include <QString>
#include "serreceiver.h"

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = 0);

signals:
    // Сигнал для передачи данных в qml-интерфейс
    void sendToQml(QVector<double> count);
    void plotting(QVector<double> count);

public slots:

    void readData();

    void receiveFromQml();

private:

    QString port_name;

    serReceiver *receiver;
};

#endif // APPCORE_H
