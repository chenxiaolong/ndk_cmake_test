LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := main.cpp
LOCAL_MODULE := main
LOCAL_LDLIBS := -latomic
include $(BUILD_EXECUTABLE)
