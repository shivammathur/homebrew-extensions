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
    rebuild 25
    sha256 cellar: :any,                 arm64_sequoia: "0c703c83cb66b4ce288c1ac1a580fd1c334349fb79e16f80decd408cc5bd7a5f"
    sha256 cellar: :any,                 arm64_sonoma:  "dd38ff249dee5ec46d1697334a9951ed5e7e073a62798049c27ab3b0c28c0450"
    sha256 cellar: :any,                 arm64_ventura: "6b074f35ec12fe8e6977d60077f4b2bf2c65a8b1ac06eddfdc4cc7e09883cc45"
    sha256 cellar: :any,                 ventura:       "4a2aad97b4890c5bece66ecb0acca007a3f3d76b50d82dc6b058bf1c355c9d9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "61030caf2b16e8ed4aec475d8d4c5d9dfb7baf786834e895206103b04d1c0bc1"
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
