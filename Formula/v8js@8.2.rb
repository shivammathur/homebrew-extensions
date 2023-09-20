# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT82 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/7c40690ec0bb6df72a2ff7eaa510afc7f0adb8a7.tar.gz"
  version "2.1.2"
  sha256 "389cd0810f4330b7e503510892a00902ca3a481dc74423802e06decff966881f"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_ventura:  "cc0904db3f6d5267777e4610d834f773ce996dca512e594d7b077541637e11f7"
    sha256 arm64_monterey: "77c32466af926702bc5ecf7fab10cb2c59d88f6d94830277b2d3316390ca7a30"
    sha256 arm64_big_sur:  "c64c26f9558526aa7a0b84eebb177d51232adeb4de5a02edaf1a5326334aa8a0"
    sha256 ventura:        "da415136a1c524e227ba2076c55d54c0394f7a571db351b689e31ecd3ccd8ff9"
    sha256 monterey:       "a1e5759c4a1c85122012aa1fc005721f4e3cf0ec45e86c730589e82f0cded524"
    sha256 big_sur:        "e097f5ac8427e950ae73a0c4330544332689d809f526efaa5688d75cf5e12729"
    sha256 x86_64_linux:   "de5b78fe5d8664035d43c85a4962357637698fad6f37469f69a111a9dfdb8746"
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
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
