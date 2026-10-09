# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  revision 1
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "bb4cff3faab4f233d1086ab4714d807da3cb9155a94d6be8025e944c48b67678"
    sha256 cellar: :any, arm64_tahoe:       "8fb39ff7bc2f0568830f78c6932a2bed1b92e7a2cd0c5039d2a0b903b5a5dcaa"
    sha256 cellar: :any, arm64_sequoia:     "dc7d435fd33895d2135f93c442ed1504f256eac72d430f61e4af3a5bd1cb5af0"
    sha256 cellar: :any, arm64_linux:       "54be3bb04e464a04972afd74c02c35a729b8667104c16673833c827a641129af"
    sha256 cellar: :any, x86_64_linux:      "288065c343815679c0e4823b6b570f276f80470c138947f28df8941e351c75a6"
  end

  depends_on "krb5"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "imap-#{version}"
    inreplace "php_imap.c", "0, Z_L(0)", "Z_L(0)"
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
