# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.27.tar.xz"
  sha256 "479e65c3f05714d4aace1370e617d78e49e996ec7a7579a5be47535be61f0658"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "31042642e73ccb9f83de7756f351656f88c36e56772a2d2fad724c7bd0f3e4a4"
    sha256 cellar: :any,                 arm64_ventura:  "355a6d536b89a63ddb119d9a87490e1263794d96ed1b40daaa8ddf060e324a39"
    sha256 cellar: :any,                 arm64_monterey: "1f9bb876e6c990cc97a9a7b8e8306689073da1dfa882a942e227b187437cbfcc"
    sha256 cellar: :any,                 ventura:        "5bb0fbffae4d45bb53cbc8aea7c8023d76a62791a33196e3cec3649a65c64a2e"
    sha256 cellar: :any,                 monterey:       "2723b1331dd3ff7b6ccc940e48334843c3b0b503f909e38a3a5482ce478d7791"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a0c3013a83151d5f24a5c3d6c645f600d443fcc8430f13a64e7f1ef8b8797812"
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
