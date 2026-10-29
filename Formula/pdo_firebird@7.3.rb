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
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "13750a0b727961706c286fac0491333bcacba0fe9b50aaf2b16b71e11f978131"
    sha256 cellar: :any, arm64_tahoe:       "da2ee4a7791905921a20f3ed8a3c54b5948160b0da0c8ebf2619b3ee1854dee3"
    sha256 cellar: :any, arm64_sequoia:     "7cb020ccb20c977323adb21b3656cb5e2761d73fc2d8bd741fa0f8bf8a07d506"
    sha256 cellar: :any, arm64_linux:       "014ae4ded00ecace01ea0b41aab33f3aebaddbf8c26a2a5189ba28150982d1be"
    sha256 cellar: :any, x86_64_linux:      "4bcaf1be25cbc0610670dbf00387490164a17a3350f772f53935e78271e533b6"
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
