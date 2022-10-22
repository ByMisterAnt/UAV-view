QT += core printsupport gui quick quickwidgets widgets studio3d serialport charts

CONFIG += c++11

SOURCES += \
        SerialPort.cpp \
        appengine.cpp \
        main.cpp \
        serreceiver.cpp

RESOURCES += qml.qrc \
    UAV-scene.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    SerialPort.h \
    appengine.h \
    control.h \
    serreceiver.h

DISTFILES +=
