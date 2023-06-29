# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/961e57eb6047e0970aad3ac77f9f634593412558.tar.gz?commit=961e57eb6047e0970aad3ac77f9f634593412558"
  version "8.3.0"
  sha256 "3b0320df722465b5ebfbba2255c86767a69857c0837db08f3d49e391e8474236"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 42
    sha256 cellar: :any,                 arm64_monterey: "f53e3f917b6c179af4cff3848f09b08ac540bccaeef9de0ded018642024b8e87"
    sha256 cellar: :any,                 arm64_big_sur:  "bf2673688b9b5d8c3adb98e5e2b56e58542f22517d115ea827b4fe9275636787"
    sha256 cellar: :any,                 ventura:        "db08d9fdb0d1e40dc123dedbd035bae58c80ac6a737a1d864e541a95ef5b4a66"
    sha256 cellar: :any,                 monterey:       "0126370c80df3a01e2afd74755a922b2b907666c82f2cf5d310df2e860703633"
    sha256 cellar: :any,                 big_sur:        "1c88836b617291fbe91bda3c6624dce3ed0251ea00397982376901c5a9a14cd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ea9fe1c22955870d5b2ec388018d9066d3a07021778e4ccc58a720b21410e5a"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
