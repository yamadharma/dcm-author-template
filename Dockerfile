FROM ubuntu:22.04

WORKDIR /root

RUN su -; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl wget perl xz-utils tar ca-certificates fontconfig sudo git vim make locales; \
    apt-get upgrade curl wget perl xz-utils tar ca-certificates fontconfig sudo git vim make; \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8; \
    update-locale LANG=en_US.UTF-8

RUN set -eux; \
    wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
    zcat < install-tl-unx.tar.gz | tar xf -; \
    cd install-tl-*; \
    perl ./install-tl --no-interaction; \
    cd /; \
    rm -rf /root/*

RUN set -eux; \
    latest="$(ls -1 /usr/local/texlive | grep -E '^[0-9]{4}$' | sort -n | tail -1)"; \
    ln -sfn "/usr/local/texlive/${latest}" /usr/local/texlive/current; \
    arch="$(uname -m)"; \
    case "$arch" in \
      x86_64) platform="x86_64-linux" ;; \
      aarch64|arm64) platform="aarch64-linux" ;; \
      *) echo "Unsupported arch: $arch"; exit 1 ;; \
    esac; \
    echo "export PATH=/usr/local/texlive/current/bin/${platform}:\$PATH" > /etc/profile.d/texlive.sh; \
    chmod +x /etc/profile.d/texlive.sh

RUN cd /usr/share/fonts; \
    mkdir Source_Sans_3; \
    mkdir Source_Sans_3/static/; \
    mkdir Source_Serif_4; \
    mkdir Source_Serif_4/static; \
    wget -O Source_Serif_4/static/SourceSerif4-ExtraLight.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjipdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-Light.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjiklqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-Regular.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjihdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-Medium.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjiiVqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-SemiBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjisltrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-Bold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjivBtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-ExtraBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjipdtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-Black.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUHf6OAVIJmeUDygwjir5trhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-ExtraLight.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjipdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-Light.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjiklqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-Regular.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjihdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-Medium.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjiiVqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-SemiBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjisltrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-Bold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjivBtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-ExtraBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjipdtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-Black.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvU7f6OAVIJmeUDygwjir5trhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-ExtraLight.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjipdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-Light.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjiklqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-Regular.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjihdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-Medium.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjiiVqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-SemiBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjisltrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-Bold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjivBtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-ExtraBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjipdtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-Black.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUbf2OAVIJmeUDygwjir5trhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-ExtraLight.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjipdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-Light.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjiklqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-Regular.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjihdqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-Medium.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjiiVqrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-SemiBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjisltrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-Bold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjivBtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-ExtraBold.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjipdtrhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-Black.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEFy2_tTDB4M7-auWDN0ahZJW3IX2ih5nk3AucvUPf2OAVIJmeUDygwjir5trhxXD-wGvjU.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-ExtraLightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98pxl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-LightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98pGF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-Italic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98pRl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-MediumItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98pdF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-SemiBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98pmFhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-BoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98poVhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-ExtraBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98pxlhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4-BlackItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_US2D2QYxoUKIkn98p71hdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-ExtraLightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98pxl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-LightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98pGF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-Italic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98pRl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-MediumItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98pdF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-SemiBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98pmFhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-BoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98poVhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-ExtraBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98pxlhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_18pt-BlackItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb8kS2D2QYxoUKIkn98p71hdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-ExtraLightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98pxl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-LightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98pGF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-Italic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98pRl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-MediumItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98pdF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-SemiBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98pmFhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-BoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98poVhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-ExtraBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98pxlhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_36pt-BlackItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb-kSGD2QYxoUKIkn98p71hdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-ExtraLightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98pxl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-LightItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98pGF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-Italic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98pRl9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-MediumItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98pdF9dC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-SemiBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98pmFhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-BoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98poVhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-ExtraBoldItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98pxlhdC84DrjXEXw.ttf; \
    wget -O Source_Serif_4/static/SourceSerif4_48pt-BlackItalic.ttf https://fonts.gstatic.com/s/sourceserif4/v13/vEF02_tTDB4M7-auWDN0ahZJW1ge6NmXpVAHV83Bfb_0SGD2QYxoUKIkn98p71hdC84DrjXEXw.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-ExtraLight.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Kw461EN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-Light.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Kzm61EN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-Regular.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Ky461EN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-Medium.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8KyK61EN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-SemiBold.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Kxm7FEN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-Bold.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Kxf7FEN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-ExtraBold.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8Kw47FEN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-Black.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpBtKy2OAdR1K-IwhWudF-R9QMylBJAV3Bo8KwR7FEN_io6npfB.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-ExtraLightItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqDlO9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-LightItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqOdO9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-Italic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqLlO9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-MediumItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqItO9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-SemiBoldItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqGdJ9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-BoldItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqF5J9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-ExtraBoldItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqDlJ9C4Ym4fB3Ts.ttf; \
    wget -O Source_Sans_3/static/SourceSans3-BlackItalic.ttf https://fonts.gstatic.com/s/sourcesans3/v18/nwpDtKy2OAdR1K-IwhWudF-R3woAa8opPOrG97lwqBBJ9C4Ym4fB3Ts.ttf; \
    fc-cache -f -v; \
    cd /root

ENV PATH="/usr/local/texlive/current/bin/x86_64-linux:${PATH}"

CMD ["bash", "-lc", "tlmgr --version && echo 'TeX Live is ready' && bash"]
