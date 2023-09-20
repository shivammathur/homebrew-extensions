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
    rebuild 3
    sha256 arm64_ventura:  "03140994b8112e36a11113a8aa00f6fd360a67e8ddb9bff73dfd82e7b24a4d40"
    sha256 arm64_monterey: "dcd161534ac37367c3b3f6015b967a910d67bb30e5b824346f26d4464815d803"
    sha256 arm64_big_sur:  "d17bed66ccac1eef2590d45ceeb58bd81f145a44e9d3ca2d5a7e75fe23de7d94"
    sha256 ventura:        "8d5d4b04e204619cea16811e37fea992e7cde0bedb4a73e17ad39eb0f2a23fc8"
    sha256 monterey:       "e9cb0f7f08292a376283e41dce60a082b588b9fcf19410a6161502183e9087cf"
    sha256 big_sur:        "44bdd6fd9f9b70ac5eae242a8cabd83a2afb9d0fd79cd3360b3d47d17d81ca89"
    sha256 x86_64_linux:   "502ea1d64e4a6d3549f337b07f5cc415a02880d0aa71cc3462b1d5fee898d578"
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
