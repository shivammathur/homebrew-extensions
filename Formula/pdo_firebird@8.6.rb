# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3d857e6158c0922510ca26c642ed15b2998fae8a.tar.gz?commit=3d857e6158c0922510ca26c642ed15b2998fae8a"
  version "8.6.0"
  sha256 "1cb4aae7a6c640b637bf0e8ebf01ff45ad7931a442ad69cbab39086c3d04e5ed"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3e43961522bf407679d96a7af4b2c4ca432ed0ac7caeec08b925c4470dbbd7cd"
    sha256 cellar: :any, arm64_tahoe:       "d83cee5ce2f4fdb194f1347eaa30c5dce4ea9589a309ec636ebb636f8c8abbad"
    sha256 cellar: :any, arm64_sequoia:     "c4fd1912d18a0c073c06edc856d32bde6cb033ca0d5ef37c26a6f48946d0ca55"
    sha256 cellar: :any, arm64_linux:       "4f3d015e95001c0cdef4297a315704431d8288b2d885eb3439894fb3ec6a2c11"
    sha256 cellar: :any, x86_64_linux:      "efc9ac3c7e9ec8c037f646d15cb0e10843c89866db15def09f55b05bab86b97a"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
