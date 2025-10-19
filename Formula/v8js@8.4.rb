# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT84 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/dde1c5a87bf702a6e43a432cd6295abd9867af2b.tar.gz"
  version "2.1.2"
  sha256 "aa392706a4b5672954a1efb4ef8c13136253043257b575abe472a3eb848a7446"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_tahoe:   "1d3934db2fe6752d87f16c0d44781e76875e377c8da468079ddce608bfee8d2b"
    sha256 arm64_sequoia: "2ea2ce7dea4421a6a27aee76ce19a6f782f412306e2c38cf26193b2af9d13fb8"
    sha256 arm64_sonoma:  "137d10d73a7b41bc07090568067c9fd6b2078eac25cf899e174b95853b99427b"
    sha256 sonoma:        "49d3ff6f07287f87483f82c7986babf32ef2792edc39e8b0f3ca2433cacb493a"
    sha256 arm64_linux:   "dff6673952dca0029c8c2de0b62539db25f41dca0abf12b42644a9aa1ea590fe"
    sha256 x86_64_linux:  "097efbe8fb697cb6cd9cbb254eb2ad984e3a1fd1c2f3f2a3ab23355cf09f3310"
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
