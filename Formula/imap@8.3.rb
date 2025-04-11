# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.20.tar.xz"
  sha256 "f15914e071b5bddaf1475b5f2ba68107e8b8846655f9e89690fb7cd410b0db6c"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4d7866353de3e3abad239ad719390c54e2d92e0bc99b6193fed9f72645ea95e4"
    sha256 cellar: :any,                 arm64_sonoma:  "63914d05cfe15ad310dea82df9ef5191604e2cff63d278e8fda8131b1eae47ff"
    sha256 cellar: :any,                 arm64_ventura: "e0a195e7ab8e3471ca7437f548ab08d11a9bf65ea556c538daa11b447779d41e"
    sha256 cellar: :any,                 ventura:       "ddbb35df1c8f3c1ac595178056867aec80f3c4af00e7b22b118a3a7dc8c37395"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "526b2f8b161952783d23a2aa963034c5bfaaef5a514dd6cdfa215dd4d967bdfe"
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
