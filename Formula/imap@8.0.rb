# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3df78fd9f89e8356b78353e133fc05a6101b7237.tar.gz"
  sha256 "4a6a9f30a9652f6d44df10c994fc640e48a9744ab91a0ceb990a19d2cd88e1a3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "dc2c8cf490712cbc3d944429649f12206856d48a950b5b34a74e79d523d07df0"
    sha256 cellar: :any,                 arm64_ventura:  "7fe6e514c3208cd83b97b391b9fbda1e54babef2dd183587d3307b3659effe65"
    sha256 cellar: :any,                 arm64_monterey: "451d43a6f5c201f48aa61e4b779f46db21e427f23d2cef3af22d013a5081e499"
    sha256 cellar: :any,                 ventura:        "c0b1d60c1c1b34f9a891e2925f64fcadb844db5f98e3a81d22a08b63f6ad5ff6"
    sha256 cellar: :any,                 monterey:       "f6de82b11665b8ef7bfdfca7cb323f895b8a322aafe0d6e7387d41029fb3cc85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "95beb387a970df723cf5318471136e0164dbf75dcea05a01f56173de053c1490"
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
