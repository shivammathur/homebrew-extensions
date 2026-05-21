# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/29e84585e66b01b94f8dc0059dedcc8c55820018.tar.gz"
  version "7.0.33"
  sha256 "87e056213c805ea6c4e6f5527dfa526bbdc74e93d4e64d2d972eb3dd33aa6ba0"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "c1e77e11ad4dd5dcf6504858cd1e2b3f2243e36ea4196b2a653a36bdf127b695"
    sha256 cellar: :any,                 arm64_sonoma:  "187f05be74fe8cf2564084cc02b591eb744e549234963a22858754c2790586c8"
    sha256 cellar: :any,                 sonoma:        "92c7f6093b339f17d3fc111424bfc922661a3d5186b6747843814789e8d91683"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "486e7893df4be9216164b9a06e20255db91b4efb5cfc3e9ba9d6cdd1dd794722"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8f180f262e6aa14d13ae25df2058ecac47607ef6d3e73be8e451a003b357aa6"
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
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
