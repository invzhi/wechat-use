FROM jlesage/baseimage-gui:debian-13-v4.15.1

# Install WeChat.
RUN set -eux; \
	add-pkg \
		fonts-noto-cjk \
		fonts-noto-color-emoji \
		fonts-noto-core \
		libasound2 \
		libatk-bridge2.0-0 \
		libatomic1 \
		libcairo2 \
		libcups2t64 \
		libegl1 \
		libfontconfig1 \
		libgl1 \
		libglib2.0-0t64 \
		libgssapi-krb5-2 \
		libice6 \
		libjack0 \
		libnss3 \
		libpango-1.0-0 \
		libpulse0 \
		libsm6 \
		libvlccore9 \
		libx11-6 \
		libx11-xcb1 \
		libxcb-glx0 \
		libxcb-icccm4 \
		libxcb-image0 \
		libxcb-keysyms1 \
		libxcb-randr0 \
		libxcb-render-util0 \
		libxcb-render0 \
		libxcb-shape0 \
		libxcb-sync1 \
		libxcb-xfixes0 \
		libxcb-xkb1 \
		libxcomposite1 \
		libxdamage1 \
		libxext6 \
		libxfixes3 \
		libxkbcommon-x11-0 \
		libxrandr2 \
		libxrender1 \
		libxtst6 \
	; \
	add-pkg --virtual .build-deps \
		ca-certificates \
		curl \
	; \
	arch="$(dpkg --print-architecture)"; arch="${arch##*-}"; \
	case "$arch" in \
		'amd64') \
			url='https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb'; \
			;; \
		'arm64') \
			url='https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_arm64.deb'; \
			;; \
	esac; \
	curl -#Lo WeChat.deb "$url"; \
	version="$(dpkg -I WeChat.deb | grep 'Version: ' | grep -oP '\d+(\.\d+)*')"; \
	dpkg -i WeChat.deb; \
	rm WeChat.deb; \
	del-pkg .build-deps; \
	set-cont-env APP_NAME "WeChat"; \
	set-cont-env APP_VERSION "$version"

# Install AT-SPI2.
RUN set -eux; \
	add-pkg at-spi2-core; \
# Setup environment variables.
	set-cont-env QT_ACCESSIBILITY 1; \
	set-cont-env QT_LINUX_ACCESSIBILITY_ALWAYS_ON 1

# Install RIME.
RUN set -eux; \
	add-pkg \
		ibus-rime \
		librime-data-double-pinyin \
		librime-data-emoji \
		librime-data-luna-pinyin \
	; \
# Setup environment variables.
	set-cont-env GTK_IM_MODULE "ibus"; \
	set-cont-env QT_IM_MODULE "ibus"; \
	set-cont-env XMODIFIERS "@im=ibus"

COPY rootfs /

# Fix shared object dependencies.
RUN ldconfig

ENV LANG=zh_CN.UTF-8
ENV TZ=Asia/Shanghai
ENV WEB_AUDIO=1

VOLUME ["/config/.xwechat", "/config/xwechat_files"]
