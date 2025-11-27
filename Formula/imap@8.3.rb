# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.28.tar.xz"
  sha256 "25e3860f30198a386242891c0bf9e2955931f7b666b96c3e3103d36a2a322326"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fa62ba17fc57b4fbe864c789984cdf3373093a5852f8e0f13306512363d66b94"
    sha256 cellar: :any,                 arm64_sonoma:  "a6003560ab14d945b5526241fa6034a10698b666e20fb376b84a01c72fce1ab8"
    sha256 cellar: :any,                 sonoma:        "8650b34c4207f16da9f8aafcd5f41efd190b40620abe48116fc91231bb6bb2fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eea3ef1bdc002b803f2145cd62644843b5658f1d402045b6dcf14e18d29bcac2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7de0a93124db3e7b4c43659e745ebce64a8f0d32d61a353d1947c7a5b1ddaf3"
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
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
