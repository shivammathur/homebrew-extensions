# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2caa81b25793a7c1878530ed80a289b070cfa44f.tar.gz"
  version "5.6.40"
  sha256 "b3397170680a3fe9f1ba36298794af232f76c1eb6d647cd0fe5581a5f233ffc3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any,                 arm64_sequoia: "71a9df81dceb50e6000af015d8c0bff2b5f1b57e4e4fc663c2bcf8d94425c987"
    sha256 cellar: :any,                 arm64_sonoma:  "b52aed28a944df37872e326237c287ec7105886a198728bf557bfd1022e5dc6a"
    sha256 cellar: :any,                 arm64_ventura: "743256614c13fa191097d599afa5677282056894d35b5e7cbce531d0f945cbd2"
    sha256 cellar: :any,                 ventura:       "9dac50bc797f824228db6aa19abdd9e85aa023ef449c64c7c7f3c2548fc1b5c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "120b188a9a9a5796dd8b6c49a47372aec45e5ad7c3245a738a2b538cc885ef51"
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
