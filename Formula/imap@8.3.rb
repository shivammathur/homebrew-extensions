# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.26.tar.xz"
  sha256 "2f522eefa02c400c94610d07f25c4fd4c771f95e4a1f55102332ccb40663cbd2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c9019e05b5f96ff7389206fd49ee207390edd714cbde1a9e4bd2cbd27ff50c4b"
    sha256 cellar: :any,                 arm64_sonoma:  "010ab18bcd0365decade2031ef1094e9323942048adeb1993c55458c339345f1"
    sha256 cellar: :any,                 sonoma:        "744f1f42bc29d3a477479799e3781bf9ba7b274b4ba303b1d857e0200b0ec2f8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "10ff0485b0b3aef98a7abb63a26011dee1425816b753eaa8aa6a41a8e1a92e6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8f87c75f489f690075455c9a85c45bf7d309be1eb81bc793ed6ad423a57a4f4"
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
