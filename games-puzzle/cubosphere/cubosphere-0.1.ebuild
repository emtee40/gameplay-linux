# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: games-puzzle/cubosphere/cubosphere0.1.ebuild frostwork Exp $

EAPI="3"

inherit eutils games flag-o-matic

DESCRIPTION="game similar to the PSX game Kula World / Roll Away"
HOMEPAGE="http://cubosphere.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_beta_${PV}_unix.tar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/lua
	virtual/jpeg
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/glew
	virtual/opengl
	virtual/glu"

src_prepare() {
	# respect ${GAMES_DATADIR}
	sed -i -e "s:llua5.1:llua:g" -i Makefile
	sed -i -e "s:PREFIX=/usr/local":PREFIX=/usr":g" -i Makefile
	sed -i -e "s:BINDIR=\$(PREFIX)/bin:BINDIR=\$(PREFIX)/games/bin:g" -i Makefile
	sed -i -e "s:DATADIR=\$(PREFIX)/share/cubosphere:DATADIR="${GAMES_DATADIR}"/"${PN}":g" -i Makefile
	sed -i -e "s:install\: all:install\::g" -i Makefile
}
