# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT80 < AbstractPhpExtension
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
    sha256 arm64_monterey: "9c90ff816685dd1a6d0ac0b30664610118772cbc8f365f62942543c539787726"
    sha256 arm64_big_sur:  "fff99a1950f12530fd06e123fcc33c4e64d370123c11f1fe62dc818cb8429274"
    sha256 ventura:        "a5d15208b1915214d5a58c00aa6561f11982b188c9654137778548acc352500b"
    sha256 monterey:       "06e335d241b0b28aff984071d41ffbfb12836e2b3498d070462f9629c34f0785"
    sha256 big_sur:        "956907a1149250ade570fa1aaa96cc327d4a43be41c4c8ab189d02cb7bb6d634"
    sha256 x86_64_linux:   "e8e228f86f338377e762f7baa97eebbfa4f4332df1fb7628ef1d21b8cd2d293a"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
