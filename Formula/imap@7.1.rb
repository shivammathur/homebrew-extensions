# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT71 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/184152acf9810b92f4b0042c291a9701183ba412.tar.gz"
  version "7.1.33"
  sha256 "38b1bf128e03da65f3b61266d3e674ab941d4d4fb215a5ecc7cf114eea478900"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "265ef1f8075713acaf6c2893e5f04c38f655329480eb2c3afbee8db75acd93dc"
    sha256 cellar: :any,                 arm64_ventura:  "0973bcaebc6054e47849f9c981bde0720925f4e8470b1e09630d7f6301222fda"
    sha256 cellar: :any,                 arm64_monterey: "f79985c5e8733dfc3a0088f6fa11024cd629706f137fb65e2f7ccdfe5745e5c5"
    sha256 cellar: :any,                 ventura:        "28017b986d4d8060ba4ae19bf05bd879f8761b634179fbd51f78f0331e0397ac"
    sha256 cellar: :any,                 monterey:       "9b1cd5d0f9424f7e09c7522bb9d28c7e53651b3e399efd8d33ba8d43e8551a4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b8c38a57503b0f2db03d23b7de08dc970062e484a75a7b39a98e28ed368dcdb"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
