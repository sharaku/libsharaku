#!/bin/sh
# ----------------------------------------------------------------------------
#
#  MIT License
#  
#  Copyright (c) 2018 Abe Takafumi
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

# ---------------------------------------------------------------------------
# デプロイ先を用意する
# ---------------------------------------------------------------------------
rm -rf ${DEF_DEPROYPATH}
mkdir -p ${DEF_DEPROYPATH}/
mkdir -p ${DEF_DEPROYPATH}/include/libsharaku
mkdir -p ${DEF_DEPROYPATH}/lib/libsharaku
mkdir -p ${DEF_DEPROYPATH}/bin/libsharaku
mkdir -p ${DEF_DEPROYPATH}/include/libgame
mkdir -p ${DEF_DEPROYPATH}/lib/libgame
mkdir -p ${DEF_DEPROYPATH}/bin/libgame

# makeを行う
#  arg1		ビルド対象
_copy()
{
	lib_path=$1
	cp -pR ${BASE_PATH}${lib_path}/include ${DEF_DEPROYPATH}
}


# ---------------------------------------------------------------------------
# コピーする
# ---------------------------------------------------------------------------
for _target in "${BUILD_TARGET[@]}"
do
	_copy ${_target}
done

cp -pR ${BASE_PATH}/libs/pool/libsharaku.pool.*.a ${DEF_DEPROYPATH}/lib/libsharaku/
cp -pR ${BASE_PATH}/libs/debug/libsharaku.debug.*.a ${DEF_DEPROYPATH}/lib/libsharaku/
cp -pR ${BASE_PATH}/libs/game/pzl/libgame.pzl.*.a ${DEF_DEPROYPATH}/lib/libgame/
cp -pR ${BASE_PATH}/libs/game/wslg/libgame.wslg.*.a ${DEF_DEPROYPATH}/lib/libgame/

cp -pR ${BASE_PATH}/libs/debug/logvewer ${DEF_DEPROYPATH}/bin/libsharaku/

exit 0
