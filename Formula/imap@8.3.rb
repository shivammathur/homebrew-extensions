# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.22.tar.xz"
  sha256 "66c86889059bd27ccf460590ca48fcaf3261349cc9bdba2023ac6a265beabf36"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9e2fdbf630f2d79c599e0d03b178a676cd6ba07c624f3a0109dcec3d3cc854e7"
    sha256 cellar: :any,                 arm64_sonoma:  "65b31931ee0c895b21bb508c4acdd6b6761c1587cf203500343fa667557c12b4"
    sha256 cellar: :any,                 arm64_ventura: "2e3014837d1eb7c5ca4d3d1c50d6995a7bd014c72d366b81ace68b285407f15b"
    sha256 cellar: :any,                 ventura:       "abb40ae417e995800a95b84c26f83b8afcc83598a3b4ed086e681559583aadf0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "20423d995f96e5491896eaa18f90b491bf96507546296902cd18850b48218c30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf8d773c5767ae42cf9fe7ef6f71843446f00f710df7c77be62dcbc72a66f800"
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
