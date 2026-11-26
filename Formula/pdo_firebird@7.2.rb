# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b9324026a97a5255ffa24107c48c6e2a9c0a8b.tar.gz"
  version "7.2.34"
  sha256 "c68605c387149e04a20b193fcb93c8b65a859b7ab3f4b77b12339f83d6583319"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "2da28a551511c6c6a59ee3111549f1b17328243f530ea1002f45862e5948b571"
    sha256 cellar: :any, arm64_tahoe:       "033432841d086eb383e9b1cdd8940cd36ed66022f84c95050cbc3454b904fc2b"
    sha256 cellar: :any, arm64_sequoia:     "d5a2c19a9d45f1f050bbb030163f3b2ac9c37133b07aa4e53aa29ca4e66ce410"
    sha256 cellar: :any, arm64_linux:       "cd4c2ccbd11a32d1e9cadc8bf493df563a36f3bc16008bf4bd43c8109bd033e5"
    sha256 cellar: :any, x86_64_linux:      "d5fcb7c92e7f3ae30955244d6709f312c91e7914c9f4c2c30f224b8cc5493452"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
