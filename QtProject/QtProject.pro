# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = QtProject

CONFIG += sailfishapp

SOURCES += src/QtProject.cpp

DISTFILES += qml/QtProject.qml \
    qml/Bit.qml \
    qml/cover/CoverPage.qml \
    qml/pages/About.qml \
    qml/pages/Board.qml \
    qml/pages/Game.qml \
    qml/pages/Menu.qml \
    rpm/QtProject.changes.in \
    rpm/QtProject.changes.run.in \
    rpm/QtProject.spec \
    rpm/QtProject.yaml \
    translations/*.ts \
    QtProject.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/QtProject-de.ts
