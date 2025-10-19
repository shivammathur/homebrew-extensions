# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT71 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/shivammathur/v8js"
  url "https://github.com/shivammathur/v8js/archive/1777ce3d774747075432672977ca4e034813575a.tar.gz"
  version "2.1.2"
  sha256 "1064d6ec32c5e8699928f541607f709e3bf1da959ec0cd8bedb62b4a87dca8b7"
  head "https://github.com/shivammathur/v8js.git", branch: "php7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_sonoma:   "39ad9dcf324a36d2429ac1f4fe320722483647ec303a1f06c5fc875fe0da6b25"
    sha256 arm64_ventura:  "4305f4015e0f34df596db52de7801af0f9762ca5d5f276396d09fbba00acf37b"
    sha256 arm64_monterey: "16441bb1914544a580b224f52653c2b662b5714b3a18b8f75356200cd9bbd583"
    sha256 ventura:        "39a0c526bd547d1b38cedd532541e0926d8d6a16bacf27a092e1516033288c08"
    sha256 monterey:       "e146a2de86facae1e70b470ca50aeeb0b0af1c6e4b03a23d16927ce72cad17a7"
    sha256 x86_64_linux:   "0e64ccab64d503720658b8d1f33c6a22839a0ff906a469d726cf05bc63f806d2"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    inreplace "config.m4", "c++17", "c++20"
    inreplace "v8js_object_export.cc", "info.Holder()", "info.This()"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
