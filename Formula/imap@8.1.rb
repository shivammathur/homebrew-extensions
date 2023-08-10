# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.22.tar.xz"
  sha256 "9ea4f4cfe775cb5866c057323d6b320f3a6e0adb1be41a068ff7bfec6f83e71d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0df180d0c24129f086ec449301ffbe6dba825c18d0529e4511c427a70dd6a005"
    sha256 cellar: :any,                 arm64_big_sur:  "a9415715459864cea51a0d065c9c57c01a7cc9725829d1830e5c1b2fbde66752"
    sha256 cellar: :any,                 ventura:        "a760809feb528f155a5af9a23d136469f25727256031828cabcb2184830597c9"
    sha256 cellar: :any,                 monterey:       "1b83aa9dd3a020e90d3196bc954645a7165b106329fd013f54ad6d59b78dc779"
    sha256 cellar: :any,                 big_sur:        "2c5f4743d4d6f544c9b7223b85b890de3596f8539aa36c5691f7f5a1f7d91bd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b782abb5078ffbc66a71c2b1c262c377572eee381931adcbea599a7f2601aa01"
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
