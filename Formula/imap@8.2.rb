# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.16.tar.xz"
  sha256 "28cdc995b7d5421711c7044294885fcde4390c9f67504a994b4cf9bc1b5cc593"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "64c137b5a09027c25c75223b74b383fcb1f99609cf5e6671c76b51d734c2dee8"
    sha256 cellar: :any,                 arm64_ventura:  "4d3203e1ea7acb3477764664b4745dd2c24cb0854aeb51db713091a6a4b7e72a"
    sha256 cellar: :any,                 arm64_monterey: "20af2a78f003f70f89099c5d4f41768aa0882b809486cfe301e85afdeae41842"
    sha256 cellar: :any,                 ventura:        "66cbe42fd8febd0e40d030efae30c2956112b6d0f52cc376aa511f2b99121871"
    sha256 cellar: :any,                 monterey:       "a40d0e5ed4ff9789f6ca19f17f9dc18a2a248b6a891a944162e33efaee0a4024"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "238d99fc59637231fe1d42af77b7a649f6a5c2272815fbd59060d034fa3e86f6"
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
