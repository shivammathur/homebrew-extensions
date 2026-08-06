# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a576d8eb53e44aff3af9259cfd29e599f604471.tar.gz"
  version "7.4.33"
  sha256 "d82887f2166e8526ea9b1cfd8c5ecf5649718f0b6e341380d333eba8066429a4"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.4-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any, arm64_sequoia: "e9af2805cea46e153375d6586d90004d6d76311955ce178944efc0167d7acc6a"
    sha256 cellar: :any, arm64_sonoma:  "6fb9438ea90eaf9eecd5725cd4ddf87535a6bf9e0bb7017a368737a4c0348373"
    sha256 cellar: :any, sonoma:        "51a8e632057de98d68d2ffb2ed42a60442a47da1b3db122377c8478f02c85bff"
    sha256 cellar: :any, arm64_linux:   "9bfff80fc51a70f73f32628ddbcb727cdb45a124e5fe2b40a71c1a6adc5e5317"
    sha256 cellar: :any, x86_64_linux:  "f2a2eab0f099bceac2159e983b902fa0b75821681ba77977bf2779fb3475d7c4"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
