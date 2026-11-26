# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0fb074d860346877aa33eee8131a6eaf4a932608.tar.gz?commit=0fb074d860346877aa33eee8131a6eaf4a932608"
  version "8.7.0"
  sha256 "a8f694482347f3d4d4b710de5782cb395ac66cd1743a285bb62fbc10388dfbb3"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "f5de4c68be32d82d3c200e82f7250076177814649d7abc476eb07e7cb95e787b"
    sha256 cellar: :any, arm64_tahoe:       "4c34942d777919895447211db970fe3c0db634b199279fbae51054ee1c18ddb4"
    sha256 cellar: :any, arm64_sequoia:     "69aa96f9a457c36bde75b84273335438354b7d5f2d4f56668aba9a5ceadd8eaa"
    sha256 cellar: :any, arm64_linux:       "a49485f8e1e706ca8e6e3943110b2f3e981706f5f8bf0c76025d482aa75da62c"
    sha256 cellar: :any, x86_64_linux:      "4be3f7f3a0c36122f715d170572f29f1f86344434f2af3a030d11c9df73528cb"
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
