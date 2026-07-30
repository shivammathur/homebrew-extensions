# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.33.tar.xz"
  sha256 "e293ed620cec74651bb4a071317892a478aa6840fab22db45c72d77cd42f9676"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_sequoia: "816aef7c8f92a70e683b147cd94a2f33ab6bf3bc83ee6d42a535ff1d7937c64a"
    sha256 cellar: :any, arm64_sonoma:  "4ac472ec3f5d294e72e9b2cfda9837a7b879ed6996cd7685c6a0e2875717215c"
    sha256 cellar: :any, sonoma:        "f8819bf117d7eec58a469a780f6a12bac1c37fc723610a3f630194e562f5d381"
    sha256 cellar: :any, arm64_linux:   "c301542670e8fb7d489b86c89050d83f14592f1a1d7c182b52e79fea1367e0dd"
    sha256 cellar: :any, x86_64_linux:  "5f7ab15a59c066442d3c35b2a82c1cfdf5db91cb65caf4e66f55a45dc6c0e2d7"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
