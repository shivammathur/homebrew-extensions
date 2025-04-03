# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45fa214ea3a98e645b5a26c53a61b5fee9c39d13.tar.gz"
  version "7.4.33"
  sha256 "4019629d3fe91b18586676eb8feefabc15ed4530d15fd227f405ab62a7e3b526"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "7e66373de473972ba453ee033c7fc5fad09fa262018cd8edd7677cf17105b0c9"
    sha256 cellar: :any,                 arm64_sonoma:  "18721c32b74caae2f0cfce68f172b8bc5d5da4900d795bf2939a16e56f31ebbc"
    sha256 cellar: :any,                 arm64_ventura: "b00feecdf1a76feed5b1e4a75544df7427ec67ea30496c914c2e84edb2231837"
    sha256 cellar: :any,                 ventura:       "b41ee288422faaca8e3008de82df1fb07779a71fe44ff5bbe96a0f0482b24543"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80ab6c09a150e1504b2ef83d9f5063314f9a96475af997dc5fa13c34337559dc"
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
