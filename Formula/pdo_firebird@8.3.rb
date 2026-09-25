# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.35.tar.xz"
  sha256 "ff4630fbbbd94359134b7d3c223db59329905bdc4f5a9ef93d257b48e358619a"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d9b726602e654b00d3cd625c1a65f971c6c4822d54f7489104bb2c41fc276fcc"
    sha256 cellar: :any, arm64_tahoe:       "9b5fa1e745003ecc45303b35ddea37b42c942a5234b6878649472c99a85f32e4"
    sha256 cellar: :any, arm64_sequoia:     "1260a6d3bf789c70254b7fc28a3b016ba6759aafc1ad31b8ff18e9d7c0426e6b"
    sha256 cellar: :any, arm64_linux:       "ad0e384915a16ecfcbf3c7a204d83f6ad437096aca82c8accf5075d2a96aa34a"
    sha256 cellar: :any, x86_64_linux:      "bd90131ac7b060a28c028bbed8cd96cb8fcc8f60bfe0de20410b0792225515c8"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
