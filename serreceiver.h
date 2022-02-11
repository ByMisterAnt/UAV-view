#ifndef SERRECEIVER_H
#define SERRECEIVER_H

#include <QObject>
#include <QString>
#include <QSerialPortInfo>

#include <iostream>
#include <string>
#include <sstream>

#include <QDebug>
#include <QThread>

#include <QVector>

#include "control.h"

class serReceiver : public QThread
{
    Q_OBJECT

public:

    explicit serReceiver(QObject *parent = nullptr);

    void run();

    void set_port_name(QString port_name);

    QString port;

signals:

    void com_msg(QVector<double> yaw);
/*
private:

    Integral I_yaw, I_pitch, I_roll;

    double _err_measure = 0.8;  // примерный шум измерений
    double _q = 0.1;   // скорость изменения значений 0.001-1, варьировать самому

    double simpleKalman(double newVal, double &_err_estimate, double &_last_estimate, double _err_measure, double _q);*/
};

#endif // SERRECEIVER_H
