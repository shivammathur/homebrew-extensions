# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT85 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/pecl-mail-imap"
  url "https://pecl.php.net/get/imap-1.0.3.tgz"
  sha256 "0c2c0b1f94f299004be996b85a424e3d11ff65ac0a3c980db3213289a4a3faaf"
  head "https://github.com/php/pecl-mail-imap.git", branch: "main"
  license "PHP-3.01"
  revision 2

  livecheck do
    url "https://pecl.php.net/rest/r/imap/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "2fe1457cde11cd485e41bbea1481c1cbf0f45a03503e644c68e3c1c41d265f40"
    sha256 cellar: :any, arm64_tahoe:       "7ce5d586a7749c2856bbad93db161cede8c5559db5f043b143067ec32dd72856"
    sha256 cellar: :any, arm64_sequoia:     "736905fe9c7a972ad77da44b7710b8099ab347c701b646d03802f26921f323e1"
    sha256 cellar: :any, arm64_linux:       "920c68c7e0dff10d1c0a2489dd4194d5b24461500cc16f668e5917bf16634402"
    sha256 cellar: :any, x86_64_linux:      "cba737e5d4eb3d840e9b6c689bf661ad17d02c601625b5b8f37b73690619dff0"
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
