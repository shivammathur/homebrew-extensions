# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/dbabbe180b157eeaac5002276667f1f56f0b4def.tar.gz?commit=dbabbe180b157eeaac5002276667f1f56f0b4def"
  version "8.5.0"
  sha256 "f8958c69269db31174b44b0f07b800600b07634df3ee30430db4663c92c2a4b5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 28
    sha256 cellar: :any,                 arm64_sequoia: "a50e0332400e4f74deed8213917bac1b1cfba91bbd1720af611d3a142ff8f012"
    sha256 cellar: :any,                 arm64_sonoma:  "1eb18d819c7c01f418e6b41b5a08e61d50b71952fde74adf147c3d67c1508c0f"
    sha256 cellar: :any,                 arm64_ventura: "8fc3554501644513d30ed7423caaa0cfc0b93f98e694af9e84f5d887d467784c"
    sha256 cellar: :any,                 ventura:       "6cd7b0c0b5926df38a076e77472d59ccd65befe8969e2d432e99d949ea7f82bc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0c244860e448c18b70df5c1c7ce80ce95be2bad65dc7b3b2d6a8f5ee33f75cde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0672647f56b2b6f63b4ed0a0a3a2725efb58a8959d60c5c15fb30779bbbc9c93"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
