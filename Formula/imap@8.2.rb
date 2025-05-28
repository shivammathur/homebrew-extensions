# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.28.tar.xz"
  sha256 "af8c9153153a7f489153b7a74f2f29a5ee36f5cb2c6c6929c98411a577e89c91"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0373eafb26a2fadbc1c113b2c36b912ed4a1101016a967a9ed1a184d4a81e7d3"
    sha256 cellar: :any,                 arm64_sonoma:  "dd4e131600684f32a02aa57e32032f5dc0c42f0a1774016ac21eb18cf5c2ed8c"
    sha256 cellar: :any,                 arm64_ventura: "39b5b302d6a720ef32fa0a5a8bc1931a2eeeef884c8d0e220a2d21e3290a3d71"
    sha256 cellar: :any,                 ventura:       "313763acb1a182475d99ed09e5d7e49d101f84e693c3a57f9df3aa05e2ead676"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0d42a2e21aac3a063adf73ef28a42dfec03259dbf6b78840a920dbd1f733c53f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2ebaecf7dee80613b72f359543d1ec9b447e57097391796481b79084dc1e610"
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
