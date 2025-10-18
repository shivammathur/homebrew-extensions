# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.29.tar.xz"
  sha256 "475f991afd2d5b901fb410be407d929bc00c46285d3f439a02c59e8b6fe3589c"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "eb7a074a08f692d197c705cc73b7d63e1f1b6aa51d81725f17b81390b41b4e43"
    sha256 cellar: :any,                 arm64_sonoma:  "ba0b11f9edf452a89d5469c681c98bf459f70d74ab7d38497413b4438cc6955b"
    sha256 cellar: :any,                 arm64_ventura: "043fd72592a673a485d34d6504ac998f05fbb967afc740866b34bd3853ef538f"
    sha256 cellar: :any,                 ventura:       "b7d2d69cddc1a0291e80b358e4423ed14fce280aec43c736fb5f0ce4d79410f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e8c03513ad59d3717943caef152a1c2fae912e7fa7dce61e88ba00f1dd05f4ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d3fe34d94226d3d46d135ace99fe6af4da69a2d636d446683f7189b11795a89"
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
