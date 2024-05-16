# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.7.tar.xz"
  sha256 "d53433c1ca6b2c8741afa7c524272e6806c1e895e5912a058494fea89988570a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "0a5566b1f0413836603f8609ffeeebe674904ea5d563eb9e082fc7e3d7253bbf"
    sha256 cellar: :any,                 arm64_ventura:  "9e099dab856a7bb0228563cbfe8b85ce61c8c85cb01458a85936ac36354e0aa5"
    sha256 cellar: :any,                 arm64_monterey: "19ce9d1ec11633fbef9c8c9c3c139e76b0eac59d05c6765176b81551cd0574d6"
    sha256 cellar: :any,                 ventura:        "c09caa966c4ab6610962c486d9f11af615d12a3332e7dc0950149d5af304c391"
    sha256 cellar: :any,                 monterey:       "7bbb528fd8c6de815a70deebdb3c277e902174a036751f41ff4a41bc7eda60c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "404424c806b7a8f821d2a816dbabaed4effa6ff521082eca55f4fa7f689a25c5"
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
