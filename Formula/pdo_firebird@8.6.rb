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
    rebuild 7
    sha256 cellar: :any, arm64_golden_gate: "90225d99a7183d1d4a924b56d2daba6283a40daa8e06547df824c085aed45ac9"
    sha256 cellar: :any, arm64_tahoe:       "a57494ebdf434d34373043b3533bc8ce97bcfe463bdf7db19dcb386d61ebfaf6"
    sha256 cellar: :any, arm64_sequoia:     "28355bbe826f73386d4591eabd42c296735d4e27f01b9af758780f4ddcdee08c"
    sha256 cellar: :any, arm64_linux:       "d31db3967e8106c3d7fcf8f5f2051eb41102f1489a5dfa95e53118887faba90a"
    sha256 cellar: :any, x86_64_linux:      "871325902433c098c78d604bb3f0c403a2ca4714f597c7662e1d8f3fab4a7fdc"
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
