
export ROS_VERSION=kinetic # or indigo for ubuntu-14.0
export SKIP_ROSDEP_INIT=yes # if you've already initilized rosdep, set this to "yes"; otherwise set it to "no".

if [ $# != 3 ]; then
echo
echo usage:
echo $0  \<path/to/bin/cmake\>  \<path/to/andorid.toolchain.cmake\> \<path/to/ndk\>
echo
echo for example, if you\'ve installed your android sdk in \$\{ANDROID_SDK_DIR\}, usually your command line should be like this:
echo $0  \$\{ANDROID_SDK_DIR\}/cmake/\$\{CMAKE_VERSION\}/bin/cmake \$\{ANDROID_SDK_DIR\}/ndk-build/build/cmake/android.toolchain.cmake \$\{ANDROID_SDK_DIR\}/ndk-build
echo
exit 0
fi

script_dir=$(cd "$(dirname "$0")"; pwd)
echo script_dir: ${script_dir}


build_dir=${script_dir}/output
if [ -e $build_dir ]; then
echo find directory \"$build_dir\"
else
echo directory \"$build_dir\" not exist, creating \"$build_dir\" ...
mkdir -p $build_dir
fi
echo build_dir: ${build_dir}


export CMAKE_CMD_PATH=$(cd "$(dirname "$1")"; pwd)
export RBA_TOOLCHAIN=$2
export ANDROID_NDK=$3
export PATH=${CMAKE_CMD_PATH}:${PATH}
export BOOST_ROOT=${build_dir}/target

echo
echo need super user permissoin to pre-install python-lxml, please input the passwd.
sudo apt-get install python-lxml -y

cd ${script_dir}
./do_everything.sh ${build_dir}
