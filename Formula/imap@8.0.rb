# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any, arm64_sequoia: "9dd5a19c406a85183921fdf061e104c7813dbb536488155d9bf522319a98eee3"
    sha256 cellar: :any, arm64_sonoma:  "7dcfdd367319fb648d24f3485759026d7e25b3eb0c0d0cb0a73f7e19d3dfaa7b"
    sha256 cellar: :any, sonoma:        "cc253b755395b75ab0e78c69c19e3ce8edd3b2fe467a49ee3e4732a084a1182e"
    sha256 cellar: :any, arm64_linux:   "e37b14977f423c24b754770336b02059308f59ff5add3687a7a878c3f6de864b"
    sha256 cellar: :any, x86_64_linux:  "fa237778a25c370afd1d59f5927f7f40ce3d83c7c1755a8c55daf7185d62c0b7"
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
