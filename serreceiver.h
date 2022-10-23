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
#include <QTimer>

#include "control.h"

class serReceiver : public QThread
{
    Q_OBJECT

public:

    explicit serReceiver(QObject *parent = nullptr);

    void run();
    void set_port_name(QString port_name);

    QString port;
    QTimer *timer;

    double time = 0;
    float yaw = 0;
    float pitch = 0;
    float roll = 0;

    bool ready_plot = 0;

signals:

    void com_msg(QVector<double> yaw);
    void plot_msg(QVector<double> yaw);

public slots:

    void go_plot();
    void update();

};

#endif // SERRECEIVER_H
