#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Required!
DEVICE=kenzo
VENDOR=xiaomi

# Load extractutils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

CM_ROOT="$MY_DIR"/../../..

HELPER="$CM_ROOT"/vendor/cm/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

 PRODUCT_PACKAGES += \\
    ims \\
    imssettings
include \$(CLEAR_VARS)
LOCAL_MODULE := ims
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/priv-app/ims/ims.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
LOCAL_PROPRIETARY_MODULE := true
include \$(BUILD_PREBUILT)

include \$(CLEAR_VARS)
LOCAL_MODULE := imssettings
LOCAL_MODULE_OWNER := $VENDOR
LOCAL_SRC_FILES := proprietary/vendor/app/imssettings/imssettings.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
LOCAL_PROPRIETARY_MODULE := true
include \$(BUILD_PREBUILT)


# Initialize the helper
setup_vendor "$DEVICE" "$VENDOR" "$CM_ROOT"

# Copyright headers and guards
write_headers

# The blobs
write_makefiles "$MY_DIR"/proprietary-files.txt

# We are done!
write_footers
