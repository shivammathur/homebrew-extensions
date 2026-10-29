# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT73 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/34456d7558a6a1741fab48074c0c42d89b4834ac.tar.gz"
  version "7.3.33"
  sha256 "14d7086d3098273da345e1917ca44b6aee8f2f12db230ed09e03e5bfeaf5fab4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "9087688ae6465fbcdc2c3296dd0e41b418e6ccbe268289f3349b0101e537099a"
    sha256 cellar: :any, arm64_tahoe:       "7ccd12dc6bf0328df5edb6d8dfba0762d62c7d45f5ca13eb19050a0aca50e9aa"
    sha256 cellar: :any, arm64_sequoia:     "419292eb2a9c04f922c79b5265f6bb078d430a9a7de3879d419fd531d8a27e7a"
    sha256 cellar: :any, arm64_linux:       "f1ed60a91918b4f7edb073df73b5f32d0470e8c306c1a481c3494a580cabfb5b"
    sha256 cellar: :any, x86_64_linux:      "449e83ccc568505bbd7c009655a9c33e196876dc7609a02603ed740ec25e5243"
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
