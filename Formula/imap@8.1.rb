# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.32.tar.xz"
  sha256 "c582ac682a280bbc69bc2186c21eb7e3313cc73099be61a6bc1d2cd337cbf383"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "cc0e573b048db9b09100dff462d887b377fb36ddcf11737fc790fc9a2e5f343c"
    sha256 cellar: :any,                 arm64_sonoma:  "5f31ff1bad0f9a771b5488bfe38b2c7b85f920e8b825b3519e29ae25b2bfda51"
    sha256 cellar: :any,                 arm64_ventura: "7804e365815168e2427d839f541f4570dd36eff75045e3122ed6b9845f378c45"
    sha256 cellar: :any,                 ventura:       "dd6da58fa1ce8322417939d32e20be72f97feac6574bc0de548578c0fd6e6339"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f74295dbc9e1ea65e5a4d577013cb82962658315f72781dde1d51161e2d89836"
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
