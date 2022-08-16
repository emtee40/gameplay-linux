# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Rally game focused on closed rally tracks with possible stunt elements."
HOMEPAGE="http://stuntrally.tuxfamily.org/"

SLOT="0"
LICENSE="GPL-3"
IUSE="dedicated +game editor"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tgz"

DEPEND="
	game? (
		dev-games/ogre[cg,boost,ois,freeimage,opengl,zip,-double-precision]
		dev-games/mygui[ogre,plugins]
		media-libs/libsdl2[haptic]
		media-libs/libvorbis
		media-libs/libogg
		media-libs/openal
		sci-physics/bullet[extras]
	)
	dev-libs/boost
	net-libs/enet:1.3
"
RDEPEND="${DEPEND}
	~games-sports/stuntrally-tracks-${PV}
"
PDEPEND="${LIVE_PDEPEND}"

REQUIRED_USE="editor? ( game )"

PATCHES=(
	"${FILESDIR}/${P}_gcc6-fix.patch"
)

DOCS=(Readme.txt)

src_configure() {
	local mycmakeargs=(
		-DBUILD_MASTER_SERVER=$(usex dedicated)
		-DBUILD_GAME=$(usex game)
		-DBUILD_EDITOR=$(usex editor)
		-DBUILD_SHARED_LIBS=OFF
		-DSHARE_INSTALL="share/stuntrally"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
