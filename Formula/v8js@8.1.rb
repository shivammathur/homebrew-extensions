# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT81 < AbstractPhpExtension
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
    sha256 arm64_sonoma:   "d9daebacded0ae1f346b6ee61c89d3c89af0691bc10ba058b7403b0222c0a3f7"
    sha256 arm64_ventura:  "3fff108a232d63d6d180e09b0f239593c87e4f9038857e009b7fbc0cf95dd6cd"
    sha256 arm64_monterey: "6fabd6c5deac7df3b2a988aed2727287015465148dd04e34dad14a3470a19c92"
    sha256 ventura:        "6636552e07de1e5f3a060ab124415ac9e2aa74ecb714b0c38a28ee66a77ee56d"
    sha256 monterey:       "dbd9a8080093c89fcfbf6500ed48d88191f2c92f2e0a978e5c4dea609f5685c4"
    sha256 x86_64_linux:   "c7fc140c96a2eb1d1ffd69f4ffaa1d544be4d2de23f89650a457fafd053c63d1"
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
