# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0f5d9302be5a18cfbeddd76ee604e97fe5b2c909.tar.gz?commit=0f5d9302be5a18cfbeddd76ee604e97fe5b2c909"
  version "8.2.0"
  sha256 "84199539d67aea08ba2f45545aeeff1263721174993325d89b30e596d0ea26af"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 51
    sha256 cellar: :any,                 arm64_monterey: "b26a638d10f8a207381eb3301026aa7cffd2d55e35658314768b0f9153d91c97"
    sha256 cellar: :any,                 arm64_big_sur:  "59fa618ab3db83827bf7589dcaf6f680282059e64010191066e1a2138799372d"
    sha256 cellar: :any,                 monterey:       "d5f93da0edc069488f07cbc6a83aa7b27787d1bab16c233249fa7d3540e82b19"
    sha256 cellar: :any,                 big_sur:        "b7978a8a128fef1e28b3f6889f477bc6494f6c4b1c8ccb31f19fad968260b782"
    sha256 cellar: :any,                 catalina:       "93b146d8b248e6eb8e176bd54f19bb1abd80ac714166abc02dc83006774876d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c5d67326375771b09ecf54e1637191786415b16b9a7c3a72bf050af72da3807"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
