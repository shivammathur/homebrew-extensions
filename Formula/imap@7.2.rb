# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/544a07491c9c2348296d8a46a665f60df7c52576.tar.gz"
  version "7.2.34"
  sha256 "eec2ff1ec4af286fa11207ba0efdc5ce34222c6b3572ab2f994cd0c74f225bb0"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "7e0bc8913d77c9b221485f5f05c2ccca7779c10f7e14b80f8897c098b3a1303d"
    sha256 cellar: :any,                 arm64_sonoma:  "8de67b932b68397203029f60cd7f919210e3474ad2aafa4a851036501ce480a1"
    sha256 cellar: :any,                 arm64_ventura: "c4e0290ddc33374bea1c4af70b953903b011bf11fe485e99fc9e82f329ce62e7"
    sha256 cellar: :any,                 ventura:       "8c9e429cb337013422fecf52cc5e06cafd2742c7a828652670e3f9e018184326"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a733f34203310b19600adecdf2e3453ffa1e32fce358238c9cb81b8f628d30d"
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
