# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/421d8fd17a77fbb7c6c9dd4effeccd904025872d.tar.gz"
  version "7.0.33"
  sha256 "7d75d172343920cbd1ae1a8f02556b290180db94eb0fc308c09a2c926ef601bf"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "85c762ae9b51ca7f8baebf63be6e4ea704e6cfed77fecfda23ec2e131fa376c5"
    sha256 cellar: :any, arm64_golden_gate: "ec75f8c724a79b9f30d9c3785eb9e70735a50639836ec367bc9e852033d0bbd5"
    sha256 cellar: :any, arm64_tahoe:       "6602c1a26289d7ac82517843212f1014b51c08b73dbcfc752581baf3564559db"
    sha256 cellar: :any, arm64_sequoia:     "b7379dbbda197e9e9be04de1ec382ca2dcfcffff542ee12b3428c38306f25496"
    sha256 cellar: :any, arm64_linux:       "11b0bc78df41b38967e09525320058e40a116ebcfd4e352388cc2f4b32259dbc"
    sha256 cellar: :any, x86_64_linux:      "4e5282866376343d27e5b54a98348a99f0802d415c7f57d2d1e5319aedce48b4"
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
