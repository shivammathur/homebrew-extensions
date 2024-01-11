# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8d7364f0bbb9a6d53dd812202d11fca2da5f37d8.tar.gz?commit=8d7364f0bbb9a6d53dd812202d11fca2da5f37d8"
  version "8.4.0"
  sha256 "a4b63efb0e1c53d089620c9f42495bfc0f8678fdd8bb2249f03788249bb9e2eb"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_sonoma:   "4f18e892eb6b0f4a73f34c8b8f0d52cbe457a863cbc799952e84aa1068c1c693"
    sha256 cellar: :any,                 arm64_ventura:  "b9d424b373a4e18e2aa3bd91bd576e85a051d40204dee5e6616252bfd34232d4"
    sha256 cellar: :any,                 arm64_monterey: "32fcec5010b8ac147c29d727faed496b9fc652191611dcf93b18c0750b5f482c"
    sha256 cellar: :any,                 ventura:        "596147d5ad3795355b558b99b961468172be82d88d67cb68701ee3823e530d97"
    sha256 cellar: :any,                 monterey:       "02e8fa7e03616d209c7469171c1125473efba874febece7a13074948688b5793"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "da9945ffddbbb09ac77d641fa3635c2f04ba675119f84649c2b68977fdb9c14c"
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
