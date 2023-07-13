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
    rebuild 2
    sha256 arm64_monterey: "6480593ee7c37db5e3960b42616e688a33bd0508d5252c2f9fac4b92341ce7a8"
    sha256 arm64_big_sur:  "4b70f6db221453d91be84ccca39fb0c0a4944079c266d6d08ffd915a14794580"
    sha256 ventura:        "45678dbaf65ea2e79683e1338876c93b61c154f23e2df88245ebf17e17ea32fe"
    sha256 monterey:       "d86798696f4e362d9b22442ba60232387da0d3dde15a4c8f16550efdb4884a70"
    sha256 big_sur:        "aa5cedf0071a08930c9c8d2bdfaab73b341e0f14fab839bef5a1321bf925c3db"
    sha256 x86_64_linux:   "fc5d90408ac512a50226d48afc3b3df59d07ded63934d63b18261bad22faa0d3"
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
