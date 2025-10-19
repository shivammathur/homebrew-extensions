# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT74 < AbstractPhpExtension
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
    sha256 arm64_sonoma:   "9ca6ce241cee0ae51884a1c029f0b954d55676c217b236a92efcc07a0da8db73"
    sha256 arm64_ventura:  "6428553062b0b4a1fc3267030951c4a3bd5678a928edb1d3ff3e3f77676e61fc"
    sha256 arm64_monterey: "9b42e0ea6cf29b52a5b8965611bd4fcb4f8e9f10b03a28a0e1d0ba22e54789d0"
    sha256 ventura:        "c0679921e7234bb572221105a820794d79b0c19b0041bec20745f9699a665dc9"
    sha256 monterey:       "a13bd8d4726431e16eb73d9e09017b2c51e7bcff8ca741eeb76fe0734ee4d436"
    sha256 x86_64_linux:   "79bbab59a609978cb0c5fee04b27582b7f1a3e4cfc49777e058b0d3936add597"
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
