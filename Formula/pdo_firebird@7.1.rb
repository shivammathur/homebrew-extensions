# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19db02dfc0c93c3dcddf34df282ee6db125203df.tar.gz"
  version "7.1.33"
  sha256 "053573e6077d61663bb95d2130b661efa52c5b10f9379243fcbdac9ce01b1e99"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    manifest_sha256 "0c31e3162d58d2cc140bf45f0fa8fe7da5338a98c492538f109dac07b6bde502"
    sha256 cellar: :any, arm64_golden_gate: "c3c6936645d30161bcb7b78a84ebb4b2d203b63bbf2cf12ee2a1045f1adbf141"
    sha256 cellar: :any, arm64_tahoe:       "ef0c947bd23d9d60d258dc7bee5d6e09ebbdc5c7a555a0b622ea9247b5fbb02d"
    sha256 cellar: :any, arm64_sequoia:     "8f2129e7f616564c4753292e9631a3bdb94fee1abcf4347a946e765c3e0649ab"
    sha256 cellar: :any, arm64_linux:       "37b62a3f724d11e1a85d2f5b4150c66cdbbcf40ff81df705a151985f18961f3f"
    sha256 cellar: :any, x86_64_linux:      "53c5142ee38fc59f2a0df35397e2f457e8947f63635b8c70887744680edae14a"
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
