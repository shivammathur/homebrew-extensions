# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.26.tar.xz"
  sha256 "54747400cb4874288ad41a785e6147e2ff546cceeeb55c23c00c771ac125c6ef"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "39205afe48b11960b6eabdee9db0fb8f3a445f73736ee68e17eb28514b075556"
    sha256 cellar: :any,                 arm64_sonoma:   "4eb3602bcf87f11f488d4358ede35104a48a1fef149b16480f4875557c2af6f7"
    sha256 cellar: :any,                 arm64_ventura:  "16c8e9b62720713681c0ad88f2903869b3887b96da388d504658e15ce36b5a8b"
    sha256 cellar: :any,                 arm64_monterey: "4fe78c61494c52139f9dba3ff28dd2cfa145356632f93a5da7e777085b13318d"
    sha256 cellar: :any,                 ventura:        "56fd18dc8c4eb02c9a6b84ea1b8c5d9f58872e001486b37b1369fc4378dd25a2"
    sha256 cellar: :any,                 monterey:       "962ad3e79e1f2bc0e672ce0ba96bf95bd3384d424ea20d55d83e7614db949566"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "10172c4317ddd72f5731025d9fc5b966a77d28d9d280e081de45783d1827a0e0"
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
