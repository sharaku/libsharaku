#!/bin/sh
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


cd `dirname $0`
readonly OBJ_PATH=`pwd`
readonly BASE_PATH=${OBJ_PATH}/../../../
readonly DEF_RESULTPATH=${BASE_PATH}/result

build_target=$1

# ----------------------------------------------------------------------
# ログディレクトリ作成
# ----------------------------------------------------------------------
mkdir -p ${DEF_RESULTPATH}


# 静的チェックを行う
#  arg1		ビルド対象
_cppcheck()
{
	lib_path=$1
	lib_name=`basename ${lib_path}`

	if [ -d "${BASE_PATH}${lib_path}/include" ]; then
		rm -f ${DEF_RESULTPATH}/cppcheck.${lib_name}.include.xml
		find ${BASE_PATH}${lib_path}/include \
		     \( -name \*.c -or -name \*.h -or -name \*.cpp -or -name \*.hpp \) | \
		while read _target_file
		do
			cppcheck --enable=all --xml ${_target_file} 2> ${DEF_RESULTPATH}/cppcheck.${lib_name}.$(basename ${_target_file}).include.xml
		done
	fi
	if [ -d "${BASE_PATH}${lib_path}/src" ]; then
		rm -f ${DEF_RESULTPATH}/cppcheck.${lib_name}.src.xml
		find ${BASE_PATH}${lib_path}/src \
		     \( -name \*.c -or -name \*.h -or -name \*.cpp -or -name \*.hpp \) | \
		while read _target_file
		do
			cppcheck --enable=all --xml ${_target_file} 2> ${DEF_RESULTPATH}/cppcheck.${lib_name}.$(basename ${_target_file}).src.xml
		done
	fi
	if [ -d "${BASE_PATH}${lib_path}/example" ]; then
		rm -f ${DEF_RESULTPATH}/cppcheck.${lib_name}.example.xml
		find ${BASE_PATH}${lib_path}/example \
		     \( -name \*.c -or -name \*.h -or -name \*.cpp -or -name \*.hpp \) | \
		while read _target_file
		do
			cppcheck --enable=all --xml ${_target_file} 2> ${DEF_RESULTPATH}/cppcheck.${lib_name}.$(basename ${_target_file}).example.xml
		done
	fi
}

cat ${OBJ_PATH}/build-target | while read _target
do
	_cppcheck ${_target}
done
