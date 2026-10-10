# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/64ca21fc4a956b8d2c151943dc22dbedb889f01d.tar.gz"
  version "7.3.33"
  sha256 "ffe700b4ddaf86b580bd5176bdbd2bfae785b9eb6786dde06afe6ce77e665ca7"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3d068dbeed56c06d1394d2d1c8ab6f9a4ccfa065afd6bce1a74f4c79fc198e1d"
    sha256 cellar: :any, arm64_tahoe:       "958ae2eb4df8275583d83f1d94d7ac93e62ad946199f8d52da535f2c79b43c66"
    sha256 cellar: :any, arm64_sequoia:     "2a34996d50c139bc19f7df8756e6d7f2060fc713b7d430c6ec2be9fe9be3d659"
    sha256 cellar: :any, arm64_linux:       "410fbf3f0dab3e6c2ad28cbb34725d4073cbcdc00d0a1ceb3fddad702dbd28d0"
    sha256 cellar: :any, x86_64_linux:      "72e43229674980e681de2dc84d74b4ed42b4331b3b6a871a1552e884fcbb3a25"
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
