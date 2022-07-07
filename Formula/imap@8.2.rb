# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d9c49ae1c13d428298dd21c1f34a32deabe9cae7.tar.gz?commit=d9c49ae1c13d428298dd21c1f34a32deabe9cae7"
  version "8.2.0"
  sha256 "c8323726a402e894603d08c0080f07f5e07abd25a0e69947bffbd945bc823fb6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 61
    sha256 cellar: :any,                 arm64_monterey: "8958fc4762d3fc8c26def0cfafc1465211e015e80140b52ee4608d15f9124bfc"
    sha256 cellar: :any,                 arm64_big_sur:  "c391b08b22f35b56f44a9c0144dca80d6cb60c0f11029eff29c15af590212365"
    sha256 cellar: :any,                 monterey:       "bc2f10c31b8187e348a7962ad07ea0ae2fe449f064f65e42d24646b344a5d189"
    sha256 cellar: :any,                 big_sur:        "847038accfbd56f87fe805a69896ef2de9e36ef624ba61d51696b49333d55f33"
    sha256 cellar: :any,                 catalina:       "2d053d7d05122369113681883a9b7eb85f30aca70f9b1f88ce58bb7db17791dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffb918f08934bee64ebf663bdc9550be8fcf88774e895a45191ce82ef3ff770d"
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
