IF (ANDROID)
  ADD_LIBRARY(qfield SHARED
    main.cpp
    ${CMAKE_SOURCE_DIR}/src/qml/qml.qrc
    ${CMAKE_SOURCE_DIR}/images/images.qrc
    ${CMAKE_SOURCE_DIR}/resources/resources.qrc
    ${CMAKE_SOURCE_DIR}/i18n/translations.qrc
  )
#  ADD_DEPENDENCIES(qfield
#    assets
#  )
ELSE ()
  ADD_EXECUTABLE(qfield
    main.cpp
    ${CMAKE_SOURCE_DIR}/src/qml/qml.qrc
    ${CMAKE_SOURCE_DIR}/images/images.qrc
    ${CMAKE_SOURCE_DIR}/resources/resources.qrc
    ${CMAKE_SOURCE_DIR}/i18n/translations.qrc
  )
ENDIF ()

INCLUDE_DIRECTORIES(SYSTEM
  ${QGIS_INCLUDE_DIR}
)

INCLUDE_DIRECTORIES(
  ${CMAKE_SOURCE_DIR}/src/core
  ${CMAKE_SOURCE_DIR}/src/core/utils
  ${CMAKE_SOURCE_DIR}/src/qgsquick
)

TARGET_COMPILE_DEFINITIONS(qfield
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
TARGET_LINK_LIBRARIES(qfield
  qfield_core
  ${QGIS_CORE_LIBRARY}
)

INSTALL(TARGETS qfield
  RUNTIME DESTINATION ${QFIELD_BIN_DIR}
  LIBRARY DESTINATION ${QFIELD_LIB_DIR}
  ARCHIVE DESTINATION ${QFIELD_LIB_DIR}
  FRAMEWORK DESTINATION ${QFIELD_FW_SUBDIR}
  PUBLIC_HEADER DESTINATION ${QFIELD_INCLUDE_DIR}
)
