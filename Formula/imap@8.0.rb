# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c56202b2b1f37a474c0f779253487420311f2f42.tar.gz"
  sha256 "091e70a151ec18206aa15a69d774ea661b0d43d4ba3fbbb3f794a5e81773ffce"
  version "8.0.30"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_sequoia: "ac0123e92d3020ad2bee27a2c661c4f0a954fe77686e182de400470bd7db8054"
    sha256 cellar: :any,                 arm64_sonoma:  "5b42cc4746310165de80b35c958b4d9e512f78fb58cdc605a3b77429ead44b25"
    sha256 cellar: :any,                 arm64_ventura: "2d8fb598085214dd43b3773d5c2d88b25c53cabe0a6fe6ae9240533798c12330"
    sha256 cellar: :any,                 ventura:       "537b202cf33181007d6ddc771e853b530f901b617718f77d0afa2840f3626489"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3bb494a4a63ccd0c51763a024a3e40fa9a6d9c83425f6e6283c16ccbdbfb9ce7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "205743d0d1f8d82b773397229f2a2f9c53217825eb48cb06934a2467f9102e96"
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
