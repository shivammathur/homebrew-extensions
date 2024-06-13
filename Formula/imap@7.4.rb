# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e67b7a23f95e4d239f624a151e2be14102b94a87.tar.gz"
  version "7.4.33"
  sha256 "e8ae3ae4351b0924d048567eb729ff908dcb3121a835800a8e26acfcb6020c3f"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "74d7eee703f8cfb7a380e8faed9438f10dba0383e96d5a62174d2e04d11d072a"
    sha256 cellar: :any,                 arm64_ventura:  "7cefd7b6962d566ebff4f4544b035fc2e0c83a2aedb7169303ea8442b1185c21"
    sha256 cellar: :any,                 arm64_monterey: "0a18508efbd72b4ad503c61bd3c0e2addcac1dc9054e70e0f324ad1671faf215"
    sha256 cellar: :any,                 ventura:        "a5debc624d797e220f3172582df7c51207898f36aab30bbf31cf4ed34f73507a"
    sha256 cellar: :any,                 monterey:       "8bc5e79a89179658b4095b52678c6a9f1623beba93da2fe9e27de97184803cae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7ad0f1961c1491eb9c34d8e4aea44ea0ef048cdbe1bd1dad83b37018d8e3e35b"
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
