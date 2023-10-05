# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT84 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3a4091c388f75e89b9f6b163dfd30d8760b2ab11.tar.gz?commit=3a4091c388f75e89b9f6b163dfd30d8760b2ab11"
  version "8.4.0"
  sha256 "3a45c1935c119fee34781a0c2aa43407020e940c09a78d547bc7f665835197eb"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "2002e948516abe4a36864e917dbcfb24194b2295ec66ace0afa68b20bc122f0a"
    sha256 cellar: :any,                 arm64_ventura:  "3cf43d5bc460a8315539914437bbff1d71cb3240257069cca07dce3a52973b4b"
    sha256 cellar: :any,                 arm64_monterey: "63c377448d3e618500d0c1cf1fa90532eaa98282d9dc3feec20c781ffce5628f"
    sha256 cellar: :any,                 ventura:        "c73dda035dc0c544ab61eec03dd3f821c4a6d883a2773a7ea53ba33072b31e1e"
    sha256 cellar: :any,                 monterey:       "f1ed1252e09a7b986fd800c2aa5ca6e4c8ceb5b1b73d3ed5d535779267b9edd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ed750276fd2758784bf123f49d31729017933c01a661b9227c486eeca11a217b"
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
