# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9be705297bf0148ed84bf643949972475bef2deb.tar.gz?commit=9be705297bf0148ed84bf643949972475bef2deb"
  version "8.6.0"
  sha256 "1e70965ef3cc0d73223c88d20ea184638ec8a45576db3d8e6d6ff70980167cc6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any, arm64_tahoe:   "1bdd5a70f2c7f60006c63172521492f27e214def7105372ba23b0b8981c56637"
    sha256 cellar: :any, arm64_sequoia: "102bd671752f12f40bf5649e71b3e9936fde038266381024298143b4199298f9"
    sha256 cellar: :any, arm64_sonoma:  "e04ddb806845e29ef7b5203d2ac4476f71180dd364ad1038226cec46450d9472"
    sha256 cellar: :any, sonoma:        "970ccc71d2d39ae8b38b5ea3198909029f049707dcfa7dbee100c1577d6d738f"
    sha256 cellar: :any, arm64_linux:   "0ae1faf4b0729e14983bb4a4d2ac7e00cfdbe88eb928a610001bbee3aab57806"
    sha256 cellar: :any, x86_64_linux:  "bba5b9a82f4ebca5e94be2903ae79f555654684049e1f3a2a8350e8db2099859"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
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
