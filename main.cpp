
//switch when build portable version
#include <QtStudio3D/qstudio3dglobal.h>
//#include <qstudio3dglobal.h>
#include <QQmlContext>
#include "appengine.h"

#include <QtWidgets/QApplication>
#include <QtQuick/QQuickView>
#include <QQmlApplicationEngine>

#ifdef USE_EMBEDDED_FONTS
#include <QtGui/QFontDatabase>
#include <QtCore/QDebug>
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);

    QSurfaceFormat::setDefaultFormat(Q3DS::surfaceFormat());

    QQmlApplicationEngine engine;

    AppCore appCore;

    engine.rootContext()->setContextProperty("app", &appCore);

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
