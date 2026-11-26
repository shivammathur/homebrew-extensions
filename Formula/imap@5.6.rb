# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT56 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  revision 1
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "c68df5c4c1fb9fc86d8cbc8670464ddc42af772146068d2bb44cd249117aa7c4"
    sha256 cellar: :any, arm64_golden_gate: "33cc39ce02ac40db194c767edb659ae85a5d42c6a5843b5249bc1f730f72ed2f"
    sha256 cellar: :any, arm64_tahoe:       "e34a4225a1b12ab70f39a75d95b7bcfc385db0ace98cf84e6d129e2fb5e52890"
    sha256 cellar: :any, arm64_sequoia:     "33ad0ffd8a95d5e28aa682306dc89bc0a909490e77dc987e202b7cb5f625a664"
    sha256 cellar: :any, arm64_linux:       "df533e4e28baa11b9c79f3947ca14961ee9d34c51651677c45488c27e995595d"
    sha256 cellar: :any, x86_64_linux:      "35b3a9cff0c07e7f43fd3dee959ebffafea5a0ef99b932822eddbfae7ae06b3a"
  end

  depends_on "krb5"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@4")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
