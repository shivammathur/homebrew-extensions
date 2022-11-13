# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT70 < AbstractPhpExtension
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
    rebuild 1
    sha256 arm64_monterey: "7a6d17487e124f69e1ef16083344209f0529cb1e7fc6f01f52b914fc7340f298"
    sha256 arm64_big_sur:  "736217ee20bb32f783dbc02efb21706d2fbefe849343c5308fb4f2d389ee32d3"
    sha256 monterey:       "faa4e3eba9da8a4d2d7fa5d7d31635216e06ef78770575f3e8678505d537d738"
    sha256 big_sur:        "be5e1697f85aff8df892be44bfc7b6fa9b007e734fd74afafc1b4aa4cb26f703"
    sha256 catalina:       "a0cff584d933aa5882432ab4add7b254aae564966a3debe3d4e15b89f19d303c"
    sha256 x86_64_linux:   "83871d846856706fc136c8e898d46d48368a5a7a9e0279271429085b4c496470"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing -Wno-deprecated-register -Wno-register"
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
