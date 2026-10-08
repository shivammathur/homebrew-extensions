# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/60702faf6af0b0f93fc1f2cc27318acf8b359f7d.tar.gz?commit=60702faf6af0b0f93fc1f2cc27318acf8b359f7d"
  version "8.6.0"
  sha256 "45067d857d688b1e7abd91619221cf067ae4987d12c878454157739c39fa088d"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "95004dd00aebde83d2e65fb8898f5dbbb4f52117f2d3615401e1f9f85199e901"
    sha256 cellar: :any, arm64_tahoe:       "b849c38b80746f69dcbfbb9a2fc3ae8ba1682d34e1f41770584208f9c9561c33"
    sha256 cellar: :any, arm64_sequoia:     "212e2b663b3125a1754a9d88c1d85ab34328db9f4b6f138d55d8becda4600226"
    sha256 cellar: :any, arm64_linux:       "d70bea51b0375741db49e9baf3f3d68d39c9fe22cb048102e42dcd51a12a2ad8"
    sha256 cellar: :any, x86_64_linux:      "0f19c3053a09162c02d96cf886869721c5299480eb34d6ea7ad68fe1cb1193bc"
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
