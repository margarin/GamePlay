QT += core gui widgets
TARGET = gameplay-editor
TEMPLATE = app
CONFIG += c++11
CONFIG(debug, debug|release): DEFINES += _DEBUG

SOURCES += \
    src/EditorWindow.cpp \
    src/SceneSortFilterProxyModel.cpp \
    src/SceneView.cpp \
    src/ProjectView.cpp \
    src/ProjectTreeView.cpp \
    src/GameView.cpp \
    src/PropertiesView.cpp \
    src/PropertiesTransform.cpp \
    src/ProjectWizard.cpp \
    src/ProjectWizardItemDelegate.cpp \
    src/Project.cpp \
    src/ProjectSortFilterProxyModel.cpp \
    src/DockWidget.cpp \
    src/DockWidgetManager.cpp \
    src/PropertiesCamera.cpp \
    src/PropertiesComponentEditor.cpp \
    src/PropertiesLight.cpp \
    src/main.cpp

HEADERS += \
    src/EditorWindow.h \
    src/ProjectTreeView.h \
    src/ProjectView.h \
    src/ProjectWizard.h \
    src/ProjectWizardItemDelegate.h \
    src/PropertiesView.h \
    src/PropertiesTransform.h \
    src/SceneSortFilterProxyModel.h \
    src/SceneView.h \
    src/GameView.h \
    src/Project.h \
    src/ProjectSortFilterProxyModel.h \
    src/DockWidgetManager.h \
    src/DockWidget.h \
    src/PropertiesCamera.h \
    src/PropertiesLight.h \
    src/PropertiesComponentEditor.h

FORMS += \
    src/EditorWindow.ui \
    src/ProjectView.ui \
    src/PropertiesView.ui \
    src/PropertiesTransform.ui \
    src/ProjectWizard.ui \
    src/SceneView.ui \
    src/PropertiesCamera.ui \
    src/PropertiesLight.ui \
    src/PropertiesComponentEditor.ui

RESOURCES += gameplay-editor.qrc

INCLUDEPATH += src
INCLUDEPATH += ../gameplay/src
INCLUDEPATH += ../external-deps/include

win32 {
    DEFINES += _WINDOWS WIN32
    INCLUDEPATH += ../external-deps/include/compat/msvc
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../gameplay/Debug/debug/ -lgameplay
    CONFIG(release, debug|release): LIBS += -L$$PWD/../gameplay/Release/release/ -lgameplay
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../external-deps/lib/windows/x86_64/Debug/ -lgameplay-deps
    CONFIG(release, debug|release): LIBS += -L$$PWD/../external-deps/lib/windows/x86_64/Release/ -lgameplay-deps
    LIBS += -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32 -limm32 -limagehlp -lversion -lwinmm -lxinput
    LIBS += -L$$(VULKAN_SDK)/Lib -lvulkan-1
    QMAKE_CXXFLAGS_WARN_ON -= -w34100
    QMAKE_CXXFLAGS_WARN_ON -= -w34189
    QMAKE_CXXFLAGS_WARN_ON -= -w4302
    QMAKE_CXXFLAGS_WARN_ON -= -w4311
    QMAKE_CXXFLAGS_WARN_ON -= -w4244
    RC_FILE = gameplay-editor.rc
}

linux {
    DEFINES += __linux__
    QMAKE_CXXFLAGS += -lstdc++ -pthread -w
    INCLUDEPATH += /usr/include/gtk-2.0
    INCLUDEPATH += /usr/lib/x86_64-linux-gnu/gtk-2.0/include
    INCLUDEPATH += /usr/include/atk-1.0
    INCLUDEPATH += /usr/include/cairo
    INCLUDEPATH += /usr/include/gdk-pixbuf-2.0
    INCLUDEPATH += /usr/include/pango-1.0
    INCLUDEPATH += /usr/include/gio-unix-2.0
    INCLUDEPATH += /usr/include/freetype2
    INCLUDEPATH += /usr/include/glib-2.0
    INCLUDEPATH += /usr/lib/x86_64-linux-gnu/glib-2.0/include
    INCLUDEPATH += /usr/include/pixman-1
    INCLUDEPATH += /usr/include/libpng12
    INCLUDEPATH += /usr/include/harfbuzz
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../gameplay/Debug/ -lgameplay
    CONFIG(release, debug|release): LIBS += -L$$PWD/../gameplay/Release/ -lgameplay
    LIBS += -L$$PWD/../external-deps/lib/linux/x86_64/ -lgameplay-deps
    LIBS += -lrt -ldl -lX11 -lpthread -lgtk-x11-2.0 -lglib-2.0 -lgobject-2.0 -lxcb
    LIBS += -L$$(VULKAN_SDK)/lib/ -lvulkan
}

macx {
    DEFINES += VK_USE_PLATFORM_MACOS_MVK
    INCLUDEPATH += $$(HOME)/vulkansdk-macos-1.0.69.0/macOS/include
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../gameplay/Debug/ -lgameplay
    CONFIG(release, debug|release):LIBS += -L$$PWD/../gameplay/Release/ -lgameplay
    LIBS += -L$$PWD/../external-deps/lib/macos/x86_64/ -lgameplay-deps
    LIBS += -L$$PWD/../external-deps/lib/macos/x86_64/ -lgameplay-deps
    LIBS += -L/usr/lib -liconv
    LIBS += -F$$(HOME)/vulkansdk-macos-1.0.69.0/MoltenVK/macOS -framework MoltenVK
    LIBS += -F/System/Library/Frameworks -framework Metal
    LIBS += -F/System/Library/Frameworks -framework MetalKit
    LIBS += -F/System/Library/Frameworks -framework GameKit
    LIBS += -F/System/Library/Frameworks -framework IOKit
    LIBS += -F/System/Library/Frameworks -framework ForceFeedback
    LIBS += -F/System/Library/Frameworks -framework OpenAL
    LIBS += -F/System/Library/Frameworks -framework CoreAudio
    LIBS += -F/System/Library/Frameworks -framework AudioToolbox
    LIBS += -F/System/Library/Frameworks -framework QuartzCore
    LIBS += -F/System/Library/Frameworks -framework Carbon
    LIBS += -F/System/Library/Frameworks -framework Cocoa
    LIBS += -F/System/Library/Frameworks -framework Foundation
    QMAKE_MACOSX_DEPLOYMENT_TARGET=10.13
    QMAKE_CXXFLAGS += -x c++ -x objective-c++ -stdlib=libc++ -w -arch x86_64
    QMAKE_INFO_PLIST = gameplay-editor.plist
    ICON = gameplay-editor.icns
    res.files = res
    res.path = Contents/Resources
    QMAKE_BUNDLE_DATA += res
}

DISTFILES += \
    game.config
