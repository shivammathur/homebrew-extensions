# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/241845d24ddbbccddc9be4006c103d9ddaf3b724.tar.gz"
  version "5.6.40"
  sha256 "836bc6985113313d2a9cfc14864f9506b0c752c24cc9bf0a66454e890921b9d5"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 28
    sha256 cellar: :any, arm64_sequoia: "ef173a8050068a23e0d043c3e5158183b46ee6288885ee07806b140963704c06"
    sha256 cellar: :any, arm64_sonoma:  "16cae654fdc402a526124dc7200384b12aee4ff552778afdba2bcf20564459e3"
    sha256 cellar: :any, sonoma:        "96c50bbbf4b01b9301aafeb5de9cce9b694ac1af8b53402334ff190aa9779912"
    sha256 cellar: :any, arm64_linux:   "c9cca7205124931b9c78b35f2880fb75f87e4c271c408543f2e8fb65514a0abd"
    sha256 cellar: :any, x86_64_linux:  "61ca717777a5b0b3fbaa71715d56bdb9f922da8d6614fc1011059e6e8d3d9987"
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
