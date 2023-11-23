# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d7d3a1c66e090489779eb43ffba18297d22d4893.tar.gz?commit=d7d3a1c66e090489779eb43ffba18297d22d4893"
  version "8.4.0"
  sha256 "16724ee970c9f58556d3e4ab30277d6074e45f1630a553ec7f37602a9843d776"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sonoma:   "8b2f83d9501ff27320499e91fe802ce9e6fc7b98144c69e51e328317c189b207"
    sha256 cellar: :any,                 arm64_ventura:  "c30911eb042f7669a02b4498e8de606ec2c76473cdfeec399ad35046076bda17"
    sha256 cellar: :any,                 arm64_monterey: "20cf264bd2b71086c181055a4b7a3d7fc52f683dfd9d8afb3e2287e0b472d6c7"
    sha256 cellar: :any,                 ventura:        "207b85e7b28d77eca6e43f64eef419119755632e11f0e92ab32f853216fe1fb2"
    sha256 cellar: :any,                 monterey:       "8587d897b4c5e8e92fce38828535d14d0392c48e45f886b7e0e4d78a5d3a2860"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f5f5c81dade0d2ffdee7c8146157457cd684c1a641d7133c7149756400272efd"
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
