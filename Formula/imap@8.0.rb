# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/88664f288c699b0d63f324ef96340af335d23672.tar.gz"
  sha256 "790dd5d5a0d72a312239d77f04c42c7cb6b425aa22086fbc17879edab9ba9475"
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia: "be028f7c49329e38c125902e0697383b62f774ee33ead8c8890c70e20ebd4e56"
    sha256 cellar: :any,                 arm64_sonoma:  "8c4109d9256728867e304b4f3999c61e2ffc9187eb20d809750f6479d1c1224b"
    sha256 cellar: :any,                 sonoma:        "6164d982bec902db502aed65dd608e2b7a9153618fa3dcb71b08ef2ac44ecb91"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e3e9f03662f04924b4d66dc5b4b117f8498138acc622221572a5ca71291f83f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4d16acef6a00996aab47f8f16bd00923c5d703adefbb8d8654dd00e31a80895"
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
