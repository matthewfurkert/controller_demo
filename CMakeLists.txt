cmake_minimum_required(VERSION 3.16)

project(controller_stmp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appcontroller_stmp
    main.cpp
)

qt_add_qml_module(appcontroller_stmp
    URI controller_stmp
    QML_FILES
        Main.qml
        QML_FILES Sidebar.qml
        QML_FILES home/Home.qml
        QML_FILES gpio/Gpio.qml
        RESOURCES go_fonts/Go-Bold-Italic.ttf go_fonts/Go-Bold.ttf go_fonts/Go-Italic.ttf go_fonts/Go-Medium-Italic.ttf go_fonts/Go-Medium.ttf go_fonts/Go-Regular.ttf go_fonts/README
        RESOURCES assets/BrushedMetal.jpg
        QML_FILES can/Can.qml
        QML_FILES i2c/I2c.qml
        RESOURCES assets/dial_no_background.png assets/dial_original.jpg assets/dial_svg.svg
        SOURCES gpio/igpio.h
        SOURCES gpio/gpio.h gpio/gpio.cpp
        SOURCES gpio/mockgpio.h
        SOURCES gpio/realgpio.h gpio/realgpio.cpp
        SOURCES gpio/lightshow.h gpio/lightshow.cpp
)

target_include_directories(appcontroller_stmp PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/home
    ${CMAKE_CURRENT_SOURCE_DIR}/gpio
    ${CMAKE_CURRENT_SOURCE_DIR}/i2c
    ${CMAKE_CURRENT_SOURCE_DIR}/can
)

option(USE_REAL_DEV "Use real libgpiod (requires libgpiod-dev on target/desktop)" OFF)

if(USE_REAL_DEV)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(LIBGPIOD REQUIRED libgpiod)
    target_link_libraries(appcontroller_stmp PRIVATE ${LIBGPIOD_LIBRARIES})
    target_include_directories(appcontroller_stmp PRIVATE ${LIBGPIOD_INCLUDE_DIRS})
    target_compile_definitions(appcontroller_stmp PRIVATE USE_REAL_DEV)
    message(STATUS "Building with REAL GPIO (libgpiod)")
else()
    message(STATUS "Building with MOCK GPIO (perfect for Windows/WSL desktop)")
endif()

target_link_libraries(appcontroller_stmp
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appcontroller_stmp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
