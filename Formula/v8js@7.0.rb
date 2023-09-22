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
    rebuild 4
    sha256 arm64_ventura:  "cc5b5808b2825c031c0e8155e29f3d15f2ee8844fd8601d77e7c218f482fcddd"
    sha256 arm64_monterey: "501acc48066a5ba87be8eab23e1f2d47ba62ca1272b97af9428b2dcc2bdb400d"
    sha256 arm64_big_sur:  "483a684a6ec52f5884f3b3d2a673a394d59f904f6c6d1ce6fd92817e5631b673"
    sha256 ventura:        "b1ce204de65539feb2ff26657f0b20df2d14b6fb0a754e5ded7b13b392a352f3"
    sha256 monterey:       "4173ced8bfb57d87b87931530ff3a595fdb86afa3acd440f4ef2d2c72777f7e3"
    sha256 big_sur:        "ab0bbf1acd684dc949a41904c43569c1dbb37d3e9e85d5a1d30d902abcd479c9"
    sha256 x86_64_linux:   "50da7c034f56727ab161fe616e6261450f5c0d84b27032a7bd27d1cd2cfbb022"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
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
