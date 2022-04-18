# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fbb73939976222bb8e9a3bd8a589381360a38621.tar.gz?commit=fbb73939976222bb8e9a3bd8a589381360a38621"
  version "8.2.0"
  sha256 "c7ac3a8b38143adbb4dba4de651871afa593c7cac34314d1b75dd598f63a92b8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 46
    sha256 cellar: :any,                 arm64_monterey: "1fbd43b2b4818ae3e8831e5b07dcc0cca0568b09bdce6d0ca75a3d0c77a00fce"
    sha256 cellar: :any,                 arm64_big_sur:  "23db37d906f6220c54a3e5ce436091321ec44de3890bfad95d81dbb25367ede3"
    sha256 cellar: :any,                 monterey:       "fdb18160430bbbb5a7586d7adfeccb04896e4f0b7e712b6d650e9215174d39cd"
    sha256 cellar: :any,                 big_sur:        "b2ed214dcdd84e73e4b6443f353ea7c0897248e4b823165872bcbbfe9536e018"
    sha256 cellar: :any,                 catalina:       "92a2c9866d73d22f93dbfac0f9585c46944b057679a8dd667f9d11af62b4cf45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4332497bd333d5f6f0ee3ecde51740aee7b85687b55b7dc4df63e83e70a7fe3d"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
