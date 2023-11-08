

# NOTE: This file is generated by m4! Make sure you're editing the .m4 version,
# not the generated version!

FFMPEG_VERSION=6.0

FFMPEG_CONFIG=--prefix=/opt/ffmpeg \
	--target-os=none \
	--enable-cross-compile \
	--disable-x86asm --disable-inline-asm \
	--disable-runtime-cpudetect \
	--cc=emcc --ranlib=emranlib \
	--disable-doc \
	--disable-stripping \
	--disable-programs \
	--disable-ffplay --disable-ffprobe --disable-network --disable-iconv --disable-xlib \
	--disable-sdl2 --disable-zlib \
	--disable-everything


build/ffmpeg-$(FFMPEG_VERSION)/build-%/libavformat/libavformat.a: \
	build/ffmpeg-$(FFMPEG_VERSION)/build-%/ffbuild/config.mak
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-$* && $(MAKE)

# General build rule for any target
# Use: buildrule(target name, configure flags, CFLAGS)


# Base (asm.js and wasm)

build/ffmpeg-$(FFMPEG_VERSION)/build-base-%/ffbuild/config.mak: \
	build/ffmpeg-$(FFMPEG_VERSION)/PATCHED build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c \
	configs/%/ffmpeg-config.txt | \
	build/inst/base/cflags.txt
	test ! -s configs/$(*)/deps.txt || $(MAKE) `sed 's/@TARGET/base/g' configs/$(*)/deps.txt`
	mkdir -p build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*) && \
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*) && \
	emconfigure env PKG_CONFIG_PATH="$(PWD)/build/inst/base/lib/pkgconfig" \
		../configure $(FFMPEG_CONFIG) \
                --disable-pthreads --arch=emscripten \
		--optflags="$(OPTFLAGS)" \
		--extra-cflags="-I$(PWD)/build/inst/base/include " \
		--extra-ldflags="-L$(PWD)/build/inst/base/lib " \
		`cat ../../../configs/$(*)/ffmpeg-config.txt`
	sed 's/--extra-\(cflags\|ldflags\)='\''[^'\'']*'\''//g' < build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*)/config.h > build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*)/config.h.tmp
	mv build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*)/config.h.tmp build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*)/config.h
	touch $(@)

part-install-base-%: build/ffmpeg-$(FFMPEG_VERSION)/build-base-%/libavformat/libavformat.a
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-base-$(*) ; \
	$(MAKE) install prefix="$(PWD)/build/inst/base"

# wasm + threads

build/ffmpeg-$(FFMPEG_VERSION)/build-thr-%/ffbuild/config.mak: \
	build/ffmpeg-$(FFMPEG_VERSION)/PATCHED build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c \
	configs/%/ffmpeg-config.txt | \
	build/inst/thr/cflags.txt
	test ! -s configs/$(*)/deps.txt || $(MAKE) `sed 's/@TARGET/thr/g' configs/$(*)/deps.txt`
	mkdir -p build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*) && \
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*) && \
	emconfigure env PKG_CONFIG_PATH="$(PWD)/build/inst/thr/lib/pkgconfig" \
		../configure $(FFMPEG_CONFIG) \
                --enable-pthreads --arch=emscripten \
		--optflags="$(OPTFLAGS)" \
		--extra-cflags="-I$(PWD)/build/inst/thr/include $(THRFLAGS)" \
		--extra-ldflags="-L$(PWD)/build/inst/thr/lib $(THRFLAGS)" \
		`cat ../../../configs/$(*)/ffmpeg-config.txt`
	sed 's/--extra-\(cflags\|ldflags\)='\''[^'\'']*'\''//g' < build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*)/config.h > build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*)/config.h.tmp
	mv build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*)/config.h.tmp build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*)/config.h
	touch $(@)

part-install-thr-%: build/ffmpeg-$(FFMPEG_VERSION)/build-thr-%/libavformat/libavformat.a
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-thr-$(*) ; \
	$(MAKE) install prefix="$(PWD)/build/inst/thr"

# wasm + simd

build/ffmpeg-$(FFMPEG_VERSION)/build-simd-%/ffbuild/config.mak: \
	build/ffmpeg-$(FFMPEG_VERSION)/PATCHED build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c \
	configs/%/ffmpeg-config.txt | \
	build/inst/simd/cflags.txt
	test ! -s configs/$(*)/deps.txt || $(MAKE) `sed 's/@TARGET/simd/g' configs/$(*)/deps.txt`
	mkdir -p build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*) && \
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*) && \
	emconfigure env PKG_CONFIG_PATH="$(PWD)/build/inst/simd/lib/pkgconfig" \
		../configure $(FFMPEG_CONFIG) \
                --disable-pthreads --arch=x86_32 --disable-inline-asm --disable-x86asm \
		--optflags="$(OPTFLAGS)" \
		--extra-cflags="-I$(PWD)/build/inst/simd/include $(SIMDFLAGS)" \
		--extra-ldflags="-L$(PWD)/build/inst/simd/lib $(SIMDFLAGS)" \
		`cat ../../../configs/$(*)/ffmpeg-config.txt`
	sed 's/--extra-\(cflags\|ldflags\)='\''[^'\'']*'\''//g' < build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*)/config.h > build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*)/config.h.tmp
	mv build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*)/config.h.tmp build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*)/config.h
	touch $(@)

part-install-simd-%: build/ffmpeg-$(FFMPEG_VERSION)/build-simd-%/libavformat/libavformat.a
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-simd-$(*) ; \
	$(MAKE) install prefix="$(PWD)/build/inst/simd"

# wasm + threads + simd

build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-%/ffbuild/config.mak: \
	build/ffmpeg-$(FFMPEG_VERSION)/PATCHED build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c \
	configs/%/ffmpeg-config.txt | \
	build/inst/thrsimd/cflags.txt
	test ! -s configs/$(*)/deps.txt || $(MAKE) `sed 's/@TARGET/thrsimd/g' configs/$(*)/deps.txt`
	mkdir -p build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*) && \
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*) && \
	emconfigure env PKG_CONFIG_PATH="$(PWD)/build/inst/thrsimd/lib/pkgconfig" \
		../configure $(FFMPEG_CONFIG) \
                --enable-pthreads --arch=x86_32 --disable-inline-asm --disable-x86asm --enable-cross-compile \
		--optflags="$(OPTFLAGS)" \
		--extra-cflags="-I$(PWD)/build/inst/thrsimd/include $(THRFLAGS) $(SIMDFLAGS)" \
		--extra-ldflags="-L$(PWD)/build/inst/thrsimd/lib $(THRFLAGS) $(SIMDFLAGS)" \
		`cat ../../../configs/$(*)/ffmpeg-config.txt`
	sed 's/--extra-\(cflags\|ldflags\)='\''[^'\'']*'\''//g' < build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*)/config.h > build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*)/config.h.tmp
	mv build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*)/config.h.tmp build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*)/config.h
	touch $(@)

part-install-thrsimd-%: build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-%/libavformat/libavformat.a
	cd build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-$(*) ; \
	$(MAKE) install prefix="$(PWD)/build/inst/thrsimd"


install-%: part-install-base-% part-install-thr-% part-install-simd-% part-install-thrsimd-%
	true

extract: build/ffmpeg-$(FFMPEG_VERSION)/PATCHED build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c

build/ffmpeg-$(FFMPEG_VERSION)/PATCHED: build/ffmpeg-$(FFMPEG_VERSION)/configure
	cd build/ffmpeg-$(FFMPEG_VERSION) && ( test -e PATCHED || patch -p1 -i ../../patches/ffmpeg.diff )
	touch $@

build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c: patches/jsfetch.c \
	build/ffmpeg-$(FFMPEG_VERSION)/configure
	cp $< $@
	touch $@

build/ffmpeg-$(FFMPEG_VERSION)/configure: build/ffmpeg-$(FFMPEG_VERSION).tar.xz
	cd build && tar Jxf ffmpeg-$(FFMPEG_VERSION).tar.xz
	touch $@

build/ffmpeg-$(FFMPEG_VERSION).tar.xz:
	mkdir -p build
	curl https://ffmpeg.org/releases/ffmpeg-$(FFMPEG_VERSION).tar.xz -o $@

ffmpeg-release:
	cp build/ffmpeg-$(FFMPEG_VERSION).tar.xz libav.js-$(LIBAVJS_VERSION)/sources/

.PRECIOUS: \
	build/ffmpeg-$(FFMPEG_VERSION)/build-base-%/libavformat/libavformat.a \
	build/ffmpeg-$(FFMPEG_VERSION)/build-base-%/ffbuild/config.mak \
	build/ffmpeg-$(FFMPEG_VERSION)/build-thr-%/libavformat/libavformat.a \
	build/ffmpeg-$(FFMPEG_VERSION)/build-thr-%/ffbuild/config.mak \
	build/ffmpeg-$(FFMPEG_VERSION)/build-simd-%/libavformat/libavformat.a \
	build/ffmpeg-$(FFMPEG_VERSION)/build-simd-%/ffbuild/config.mak \
	build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-%/libavformat/libavformat.a \
	build/ffmpeg-$(FFMPEG_VERSION)/build-thrsimd-%/ffbuild/config.mak \
	build/ffmpeg-$(FFMPEG_VERSION)/PATCHED \
	build/ffmpeg-$(FFMPEG_VERSION)/libavformat/jsfetch.c \
	build/ffmpeg-$(FFMPEG_VERSION)/configure
