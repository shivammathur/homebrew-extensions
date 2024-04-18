# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/bb2ce3eec92a574a46b709ea36604b2564b8c94d.tar.gz"
  version "5.6.40"
  sha256 "85e5ebda9e374c7f2970fb79804858ae30c92913c93520848b8cd2e7571aeb7e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sonoma:   "ba17b183b79a4bd0416ea72a0e39ea69527007d998a3c79c0e0bae06c0fde400"
    sha256 cellar: :any,                 arm64_ventura:  "92b799609f6faf17ee838f984d3b8615650fb99670f1c3cce071a0987cb81324"
    sha256 cellar: :any,                 arm64_monterey: "64e19d9dff773c0852fcce37254c86f0129159252440a4e137620f7e5953a69e"
    sha256 cellar: :any,                 ventura:        "9d43f7e2a4b234c771445119f55e51db9e2e33631e1d9363948a8b868a41ef38"
    sha256 cellar: :any,                 monterey:       "e8c3729ee9940ef54186d09e6762bfb9f18e44c416be728989e76969a0f07a5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e35b452457317480a2560711acccc5ba76f64bc7c24cdb774d76f537f87c2769"
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
