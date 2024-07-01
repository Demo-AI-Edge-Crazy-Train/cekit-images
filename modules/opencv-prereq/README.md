# Fedora Base Image with OpenCV

## Compiling OpenCV with FFmpeg

Install pre-requisites.

```sh
sudo dnf install -y mock rpmdevtools
sudo usermod -aG mock $(id -un)
rm -f $HOME/rpmbuild
mkdir -p $HOME/rpmbuild/{RPMS,SRPMS,SPECS,SOURCES}
```

Download OpenCV and prepare sources.

```sh
cd $HOME/rpmbuild/SRPMS
sudo dnf download --source opencv
rpm -ivh opencv-*.fc39.src.rpm
cd $HOME/rpmbuild
sed -i.bak -r 's/^(Release:\s*).*/\11+crazytrain%{?dist}/g' SPECS/opencv.spec
spectool -g -R SPECS/opencv.spec
rpmbuild -bs --define 'dist .fc39' SPECS/opencv.spec
```

Compile it for x86_64.

```sh
mock -r fedora-39-x86_64 --with ffmpeg -a http://download1.rpmfusion.org/free/fedora/releases/39/Everything/$(uname -m)/os/ -a http://download1.rpmfusion.org/free/fedora/updates/39/$(uname -m)/ -a https://codecs.fedoraproject.org/openh264/39/$(uname -m)/os/ SRPMS/opencv-*+crazytrain.fc39.src.rpm
cp /var/lib/mock/fedora-39-x86_64/result/*crazytrain*.rpm artifacts/usr/local/src/opencv/
```

Compile it for arm64 (on an ARM64 server).

```sh
mock -r fedora-39-aarch64 --with ffmpeg -a http://download1.rpmfusion.org/free/fedora/releases/39/Everything/$(uname -m)/os/ -a http://download1.rpmfusion.org/free/fedora/updates/39/$(uname -m)/ -a https://codecs.fedoraproject.org/openh264/39/$(uname -m)/os/ SRPMS/opencv-*+crazytrain.fc39.src.rpm
cp /var/lib/mock/fedora-39-aarch64/result/*crazytrain*.rpm artifacts/usr/local/src/opencv/aarch64
```

Enable Git LFS, track RPM files and add them.

```sh
git lfs install
git lfs track '*.rpm'
git add artifacts
```

## List of RPMs to be installed

```
opencv-java
opencv-aruco
opencv-bgsegm
opencv-bioinspired
opencv-calib3d
opencv-core
opencv-dnn
opencv-face
opencv-features2d
opencv-flann
opencv-img_hash
opencv-imgcodecs
opencv-imgproc
opencv-ml
opencv-objdetect
opencv-phase_unwrapping
opencv-photo
opencv-plot
opencv-structured_light
opencv-text
opencv-tracking
opencv-video
opencv-videoio
opencv-wechat_qrcode
opencv-ximgproc
opencv-xphoto
```

Cleanup procedure:

```sh
find artifacts -iname '*-debuginfo*.rpm' -o -iname '*.src.rpm' -o -iname '*-debugsource*.rpm' -o -iname '*-doc*.rpm' | xargs rm
```
