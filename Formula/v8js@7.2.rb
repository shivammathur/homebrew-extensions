# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT72 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_monterey: "9f0e680e9867198c89812cbe5a849e562907184596d985c8d56e1b28f011ea7a"
    sha256 arm64_big_sur:  "22e1acd50125a9294a61a4a8063b6f654b1905a0062002e89cf4f7b04c9155c2"
    sha256 ventura:        "72c2e43b4796460061f8a3375444076958a08bc15a9e2285b254affbe4530d7c"
    sha256 monterey:       "6d029f4115e6c1f2137db432a965e8af5987aa8cd9a069d719d99d6a3a0e313a"
    sha256 big_sur:        "8c62952fd47c0c7c1fec75906ef3a6754587afc30be333083c3eb0088f881aef"
    sha256 x86_64_linux:   "5b6ae89c5dc1182404fec230155c1fcd1de4ef6c1a6184425979f4e7a0cde413"
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
