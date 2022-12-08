# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/11b612af6dbe9fdd60edb58d37e441c97bff79e0.tar.gz?commit=11b612af6dbe9fdd60edb58d37e441c97bff79e0"
  version "8.3.0"
  sha256 "db5b92e1a7b37135b5adec23be397a0fc264b3e43e567280eece8a6a845afa03"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_monterey: "8f86f60b2a3de927b69f6b0cdbd75b983006014e1cf6503bf235dad7d7ec9c86"
    sha256 cellar: :any,                 arm64_big_sur:  "b2b58a17bae7977a3ff8d13fc05e3cf92a7f936718c482b5c77d046b4607e601"
    sha256 cellar: :any,                 monterey:       "dad7d20efd6074291d6eb69fc51039bcec65d46138c9edd40c14a9445cca6ff7"
    sha256 cellar: :any,                 big_sur:        "14523efed53959b7f00e3a737a2e562957f9330971a6ea2b0e3f82a6fc3a2e23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af23f8b64f962df29f482bd71522f3cf5f98aeefbb2862d67b24413332546a61"
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
