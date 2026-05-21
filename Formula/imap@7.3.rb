# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/17961920bc943802ee35637d0ed2269df3acb313.tar.gz"
  version "7.3.33"
  sha256 "348e8c7a07899abcb9e31aeebf082ce9c47178ad274879abbd88e632830d1d16"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.3-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "d0fc9083d641df780c366876f4eb9157a25ebde8996a62a6252bf6866a0ba914"
    sha256 cellar: :any,                 arm64_sonoma:  "ae23db92c23980ba05ec0657fd5dce438c56165a57099459d47f00aed3a1da82"
    sha256 cellar: :any,                 sonoma:        "376a0903a14cd96bcb35e02f567f3e4eea2ca24959d8233f9bcb1b1cb4ab1437"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "002de08771cb828fee20df970a1d8e387b6bcf0cc624d51c1235564167140fb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c2843414ccda160eb0de5ce6e95eb7b1056646fbea6b9094c469d205417a975"
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
