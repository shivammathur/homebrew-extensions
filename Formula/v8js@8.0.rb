# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT80 < AbstractPhpExtension
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
    sha256 arm64_monterey: "9834f830855637926154dfada5d048634fe13757099c7eda5648376347babdd9"
    sha256 arm64_big_sur:  "833448c54f7053f76002e3fd8e011d24e45766a82674b62f05db70079957fd9a"
    sha256 monterey:       "8a178054f8a3dddb9a4fee7f70355c0ad39e0460a7f6ebdeffb12bf26325f844"
    sha256 big_sur:        "bec0fe3d7866253e8a71ab7f0e841be86e9337dfd4c9e1cff6f9679787e1a1e8"
    sha256 catalina:       "09276c9df847f917e340704d8ea94bfd4b3a8d19edb830b6ddb41d86ab59f51c"
    sha256 x86_64_linux:   "2475a08dcdbd4f84e4206ae95ebebd72d62b7710993f5ca2ab78f306ee08c788"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
