# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91f3b4e4ff74ed2432010dca9ae9ce5de781670.tar.gz"
  version "7.0.33"
  sha256 "2d80d4186c14aa7e75cca38105359eda808a512a57824462e84e96d5b1be6b5c"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "38db25a49e426214215ee0bb30233e06e429e592c0b8d2de3dc1daf86e1c79cb"
    sha256 cellar: :any,                 arm64_sonoma:  "a2f46b545cb595d0e94d1ecf3424cdeee23e86bc35f45e921e2fcfc4958a0eee"
    sha256 cellar: :any,                 arm64_ventura: "a2c1bdbb131fdaa0d751e8e0ef378af8b244eb6cf8c7161174b5fe61d7c895a8"
    sha256 cellar: :any,                 ventura:       "ee70eb4fc8f957f79243693530a4bd579f546985086a612bc316124618bdd124"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1f198fcf92dff2ed8c2a9465756b0e670933c415551ba8ddaa87939aa3bd738a"
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
