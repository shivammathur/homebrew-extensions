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
    rebuild 5
    sha256 arm64_sonoma:   "42a94b2c354e9cc65c2d0eab0f8baa876fcf9cfdcb55bfb67192513247a72bb5"
    sha256 arm64_ventura:  "d1d24c6342082fea28115fcf7b7dd7f175ca1fdb0131901fd0c599a7534c6d0e"
    sha256 arm64_monterey: "8d1ff9ebd8c7b88334eccf7cdff155f4517698f78fbe1f5916abe35b2ad9784a"
    sha256 ventura:        "196f04524947b42d7f5b5ddbe35fac435f3ed2ec971cee43a9cff48c2ba17103"
    sha256 monterey:       "525d65fa800dd5108105e16180e0d3c3a8804a28d856d08001a670a1122c8d61"
    sha256 x86_64_linux:   "e7501bb0154139d205e175aa34cf5d2c059917d06f36ac5a4a1f3010b3727230"
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
