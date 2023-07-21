# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/b132b7ab7efb40628dedf2eae1cf7d6949684bcb.tar.gz?commit=b132b7ab7efb40628dedf2eae1cf7d6949684bcb"
  version "8.3.0"
  sha256 "6543ba2ba14df85657e0821edc232f000dc73d1330e8b7c2802d23d21c22f4af"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "dfcdf2240c10bdaf52744ff79f332b94ffbf49b41c457294074e320aae13c911"
    sha256 cellar: :any,                 arm64_big_sur:  "e59baa8660af0bdd5ba11b31097e960857a5976a71673172770aec51d29ec007"
    sha256 cellar: :any,                 ventura:        "f9b34f3286f8f4a9435377a13639a28b7da53f52782f4796fa25b78a8898188b"
    sha256 cellar: :any,                 monterey:       "44b65dfe87a4a1bfbd9ce54458a289eae8efebf13801ec93adc5d232ffb8ced0"
    sha256 cellar: :any,                 big_sur:        "e5c6af5883b87b9aca72ba19639ac49d51e6329a8338d5947216e022489cf74a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "023d74e3b5ea3d018f24911971806f46856ea62ff6f305a786ff14a298d6ce71"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
