# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any, arm64_sequoia: "321c215021d8c9756381b4c721a4b0a523633602ccd90e43f91de907f46ede58"
    sha256 cellar: :any, arm64_sonoma:  "6748bc46fa37a08b423b2474badfacce9a1968f23f1ea2032de149ef1ae9b444"
    sha256 cellar: :any, sonoma:        "9e4da375ffd51781f4ffbfedbbb7b952639802b87713c40eaa801e09c952c999"
    sha256 cellar: :any, arm64_linux:   "c5e6a226b17156d965ede6c5c56d7883224406335b53c9215c169f24f4a79578"
    sha256 cellar: :any, x86_64_linux:  "8941b0abef9695dc53e4a86a0788ab5f29719df399555d7fc15ce30e3fe3d18c"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
