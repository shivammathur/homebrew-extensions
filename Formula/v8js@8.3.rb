# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT83 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/461230be276dc423d8eebf0c9ea769c71d47b7f6.tar.gz"
  version "2.1.2"
  sha256 "61effd3cde61dc002e9ddda28fbea86654a8fcfe70f0a895e8a46f27b914cc78"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_monterey: "d10237ee3a1f52348e5dce3c85f4223c71cd6c06012ae9e697d30e8a53a30058"
    sha256 arm64_big_sur:  "a897ae087a2796bd7445587410851bd64896a95e48a8e154e85da6825bf78751"
    sha256 monterey:       "aa4f3774af1e513782601dd5db81d31ca8757f85d37df01db3130c8c4b74bc22"
    sha256 big_sur:        "dec948089c93e9eddae96a5c0ef069e68f939143bfa798c94c5d621138855429"
    sha256 catalina:       "f1be206aa26564ce91946ae8cfc2653426c7ba362aadf13cf05a40ab5b970db1"
    sha256 x86_64_linux:   "d46d75e6ee8fa38eb3fd563bd5fe81bd0b146d6b9bb6071c1653f92f32fe4db1"
  end

  depends_on "v8"

  patch do
    url "https://patch-diff.githubusercontent.com/raw/phpv8/v8js/pull/490.patch"
    sha256 "2590f7ba4df798078e6c3a9a73a9ec3028d7e2e66b49f5561e40bdc1577536cd"
  end

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
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
