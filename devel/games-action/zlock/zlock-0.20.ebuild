# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit d-games

MY_PN=z-lock
MY_PV=${PV//./_}

DESCRIPTION="jumpei isshiki's HelloWorldProject (2006/09/09) "
HOMEPAGE="http://homepage2.nifty.com/isshiki/prog_win_d.html"
SRC_URI="http://homepage2.nifty.com/isshiki/${MY_PN}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/mesa
	media-libs/sdl-mixer
	dev-libs/bulletss"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

src_prepare(){
	epatch "${FILESDIR}"/${P}.diff
	mv src/reflection.d src/reflection.d-OFF
	sed -i \
	-e 's:"\(title.bmp[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(next.bmp[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(gameover.bmp[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(edificio.bmp[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/main.d \
	-e 's:"\(se_[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(voice_[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(zlock[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(bullet[^"]*\)":"'${GAMES_DATADIR}'/'${PN}'/\1":g' -i src/init.d \
	-e 's:"\(config.dat[^"]*\)":"'${GAMES_STATEDIR}'/'zlock-'\1":g' -i src/gctrl.d \
	-e 's:"\(score.dat[^"]*\)":"'${GAMES_STATEDIR}'/'zlock-'\1":g' -i src/gctrl.d \
		|| die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	local datadir="${GAMES_DATADIR}"/${PN}
	dodir "${GAMES_STATEDIR}"
	insinto "${GAMES_STATEDIR}"
	doins "${FILESDIR}"/zlock-score.dat  || die
	doins "${FILESDIR}"/zlock-config.dat  || die
	fperms 660 "${GAMES_STATEDIR}"/zlock-score.dat
	fperms 660 "${GAMES_STATEDIR}"/zlock-config.dat

	dodir ${datadir}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r *.xml *.bmp *.ogg *.wav || die
	newicon "${FILESDIR}"/${PN}.png ${PN}.png
	make_desktop_entry ${PN} ${PN}
	dodoc readme*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
