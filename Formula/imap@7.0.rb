# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a39dc7ab765a65cc77b7a7ff2fe3dfe2cbba5c4f.tar.gz"
  version "7.0.33"
  sha256 "4f218a72364843aeceee8e7f170d20775ba2e9ae9fc0bb82a210e9bdd226705d"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "1ee86998bd8119fc0833a6cbcf4c607d5575a74adc90638e19065e6b5ebf5077"
    sha256 cellar: :any,                 arm64_sonoma:  "66bd8d3e78118417f3231e436e6647eb5659e89db51a05ec8ca231f1b1faba26"
    sha256 cellar: :any,                 arm64_ventura: "6729875ea664756fdbb27cfce4265d46b87bd2da35fe15045b2dc483604806bb"
    sha256 cellar: :any,                 ventura:       "2c37458f707ac459181e1ff82c9b386ee642c6065304b3deedbfcbc9d881ee94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a4bffa57a704926b4dfa330681372e620dcfe917d1bc33f1be4de4ae8c4fed9"
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
