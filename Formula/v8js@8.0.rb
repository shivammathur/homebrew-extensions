# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT80 < AbstractPhpExtension
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
    rebuild 6
    sha256 arm64_tahoe:   "9b379d22e214f5b187c0f0f4da865be85eba4f379371f33f7215c502c94ccdd7"
    sha256 arm64_sequoia: "4eb544aab77516d693b7332858f2666a0c62705a9447720970b0e440be96a74e"
    sha256 arm64_sonoma:  "fc0dfbedec58a3f5ef8ae75f5a60dc8e8a2ca80af594b3dbf36a1259e7cdb137"
    sha256 sonoma:        "087e9871367cede2a731686b78fdeb0cfd4c8a38e1b0343a5af9b51bc623b57a"
    sha256 arm64_linux:   "0be530087b613ec59a63ed905a60f3d2307f27a1afd62f0d702564858b2c6e6a"
    sha256 x86_64_linux:  "06dfe23900ffe27ee34e948e5082e3f86eed239e1e84c7f935ffcadfa33a23a9"
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
