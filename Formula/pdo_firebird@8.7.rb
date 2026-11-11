# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3d857e6158c0922510ca26c642ed15b2998fae8a.tar.gz?commit=3d857e6158c0922510ca26c642ed15b2998fae8a"
  version "8.7.0"
  sha256 "1cb4aae7a6c640b637bf0e8ebf01ff45ad7931a442ad69cbab39086c3d04e5ed"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any, arm64_golden_gate: "a9edab7e271ba6d7560e3b967a04cddbeff0c074b372eff528bc112ad2109bf7"
    sha256 cellar: :any, arm64_tahoe:       "7817d7cf5a1d0ffe505d53690b979377ed6c1cee7aedb64c598a066b11f7cb6d"
    sha256 cellar: :any, arm64_sequoia:     "6426b2cd7249c51d9df95fa5492a164e0472e6e3c5b3a302b41a7acf4a9bdeea"
    sha256 cellar: :any, arm64_linux:       "1d4ff85bae32cc04a7b5a4082b805a1dacd01de34e789b61d5acd39ff288b45c"
    sha256 cellar: :any, x86_64_linux:      "e2deed5b038fdf266a2c69105f0aa4bafa5b22fece7be63a172a018d044201b7"
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
