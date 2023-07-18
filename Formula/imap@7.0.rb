# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/01620e1ea421be6f10360fefc1127e96a9c80467.tar.gz"
  version "7.0.33"
  sha256 "6f801b4bea2dc7025bb09144eb2c63493ab3013c7010d069d8464e88528d29a3"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "37163389b6c0c8a67b2dee4d3797dd2a2aeae30ec8f70fc4b9e2a6ca92217c0c"
    sha256 cellar: :any,                 arm64_big_sur:  "0e7ada52f1c99eeda2056ee482dc3bac8980437121b8b4ff3d990a95691bda5c"
    sha256 cellar: :any,                 ventura:        "22a88e7eff511e7acb6b918da78dcc74a30033418287b5ff3d58dce5c99249d1"
    sha256 cellar: :any,                 monterey:       "e2ab5f93b8781cba979af9736334a28fe656b1aee96d94d10a3b40d727d087dd"
    sha256 cellar: :any,                 big_sur:        "a698f47d16a1b561639b348ba067098498335caaa421c74d577a42a99dba6d23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f66b7a5de9d133c86d23564b433c0d26690fcda35eb9e5ac0d8ea915eabfd390"
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
