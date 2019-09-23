#!/bin/bash
# ----------------------------------------------------------------------------
#
#  MIT License
#  
#  Copyright (c) 2017 Abe Takafumi
#  
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#  
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#  
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE. *
#
# ----------------------------------------------------------------------------

. `dirname $0`/build-target

cd `dirname $0`
readonly OBJ_PATH=`pwd`
readonly BASE_PATH=${OBJ_PATH}/../../../
readonly DEF_RESULTPATH=${BASE_PATH}/result
readonly DEF_DEPROYPATH=${BASE_PATH}/deproy

_clean()
{
	local lib_path=$1

	if [ -f ${BASE_PATH}${lib_path}/Makefile ]; then
		rm -rf ${DEF_RESULTPATH}
		rm -rf ${DEF_DEPROYPATH}
		make -C ${BASE_PATH}${lib_path} clean
	fi
}

for _target in "${BUILD_TARGET[@]}"
do
	_clean ${_target}
done
