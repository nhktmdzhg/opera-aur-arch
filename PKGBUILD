pkgname=opera-stable-bin
_pkgname=opera
pkgver=113.0.5230.62
pkgrel=1
pkgdesc="A fast and secure web browser"
url="https://www.opera.com/"
options=(!strip !zipman)
license=('custom:opera')
backup=("etc/$_pkgname/default")
arch=('x86_64')
conflicts=('opera')
depends=('gtk3' 'qt6-base' 'qt5-base' 'alsa-lib' 'libnotify' 'curl' 'nss' 'libcups' 'libxss' 'ttf-font' 'desktop-file-utils' 'shared-mime-info' 'hicolor-icon-theme')
optdepends=(
    'opera-ffmpeg-codecs: playback of proprietary video/audio'
    'upower: opera battery save'
)
source=(
    "https://get.geo.opera.com/ftp/pub/${_pkgname}/desktop/${pkgver}/linux/${_pkgname}-stable_${pkgver}_amd64.deb"
    "https://get.geo.opera.com/ftp/pub/${_pkgname}/desktop/${pkgver}/linux/${_pkgname}-stable_${pkgver}_amd64.deb.sha256sum"
    "opera"
    "default"
    'eula.html'
    'terms.html'
    'privacy.html'
)

sha256sums=('SKIP'
            'SKIP'
            '508512464e24126fddfb2c41a1e2e86624bdb0c0748084b6a922573b6cf6b9c5'
            '4913d97dec0ddc99d1e089b029b9123c2c86b7c88d631c4d1111b119b09da027'
            '7eeb500cd0ad552e02483dbc56bd493755254ff63a4aa1bc72a08c65e5bc152a'
            '1472b417c7a338d176984866ce775cafd8055907996010ce4a60a454bdfb18d5'
            '4c92cab6658580bcdb9ab72dd1c4262a54ffeeb799ba4339be4d201c18e882ce')

prepare() {
    sed -e "s/%pkgname%/$_pkgname/g" -i "$srcdir/opera"
    sed -e "s/%operabin%/$_pkgname\/$_pkgname/g" \
        -i "$srcdir/opera"

}

check() {
    cd "$srcdir"

    # add filename to checksum file
    echo "$(cat ${_pkgname}-stable_${pkgver}_amd64.deb.sha256sum)  ${_pkgname}-stable_${pkgver}_amd64.deb" > "${_pkgname}-stable_${pkgver}_amd64.deb.sha256sum.withname"

    # check sha256sum of the deb file
    sha256sum -c "${_pkgname}-stable_${pkgver}_amd64.deb.sha256sum.withname"
}

package() {
    tar -xf data.tar.xz --exclude=usr/share/{lintian,menu} -C "$pkgdir/"

    # get rid of the extra subfolder {i386,x86_64}-linux-gnu
    (
        cd "$pkgdir/usr/lib/"*-linux-gnu/
        mv "$_pkgname" ../
    )
    rm -rf "$pkgdir/usr/lib/"*-linux-gnu

    # suid opera_sandbox
    chmod 4755 "$pkgdir/usr/lib/$_pkgname/opera_sandbox"

    # install default options
    install -Dm644 "$srcdir/default" "$pkgdir/etc/$_pkgname/default"

    # install opera wrapper
    rm "$pkgdir/usr/bin/$_pkgname"
    install -Dm755 "$srcdir/opera" "$pkgdir/usr/bin/$_pkgname"

    # license
    install -Dm644 \
        "$pkgdir/usr/share/doc/${_pkgname}-stable/copyright" \
        "$pkgdir/usr/share/licenses/$_pkgname/copyright"

    # eula
    install -Dm644 \
        "$srcdir/eula.html" \
        "$pkgdir/usr/share/licenses/$_pkgname/eula.html"

    # terms
    install -Dm644 \
        "$srcdir/terms.html" \
        "$pkgdir/usr/share/licenses/$_pkgname/terms.html"

    # privacy
    install -Dm644 \
        "$srcdir/privacy.html" \
        "$pkgdir/usr/share/licenses/$_pkgname/privacy.html"
}
