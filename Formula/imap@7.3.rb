# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e1ccf67c96d54e0f1db4ac5fc6b8c2134e48f199.tar.gz"
  version "7.3.33"
  sha256 "4924cb54e5ecd0c84a6fe723f5eb05141cad9cd210abee42a1dab564867c9cc8"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia:  "4cbdf491115877c61c4352358bf06c1ee3a1793b08c054ab27c98616da051776"
    sha256 cellar: :any,                 arm64_sonoma:   "288583ab5fa8998b5e96af00480d174ffb3eb40179d95c5aefeab8c96ae031f3"
    sha256 cellar: :any,                 arm64_ventura:  "286bd0972aafffcf5dc172072ad5f2f04a23c40107d999f48b3e929e2020438a"
    sha256 cellar: :any,                 arm64_monterey: "f7cc97b8a052b1e3d6cb9223024a58e5d688708c97300e3fe2234ed1a63a1748"
    sha256 cellar: :any,                 ventura:        "8b925b1fd4fca5e5bd2d2374ce691c0c0ffb5c5c31b918a3d23e2e76bdbc61df"
    sha256 cellar: :any,                 monterey:       "63e7199026159462d9f2656b9069183724256ddd78597eca969505966c82e68b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e1734fcceeed5d7ebaa0022c478fc27925fd8c3f40a9ff0516f71ff198116e9"
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
