
#
# Use QMAKE_HOST.arch for platform detection
#
# http://qt-project.org/doc/qt-4.8/qmake-variable-reference.html
# http://qt-project.org/faq/answer/how_can_i_detect_in_the_.pro_file_if_i_am_compiling_on_a_32_bit_or_a_64_bi
#

contains(QMAKE_HOST.arch, armv7l) {
  message("The great $$QMAKE_HOST.arch")
}

contains(QMAKE_HOST.arch, x86_64) {
  message("You are on $$QMAKE_HOST.arch")
}

message("This is your first time?")
message("$$QMAKE_HOST.arch")

error("done")
