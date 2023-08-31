# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT83 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8f4738f41df7d876195449fb7ea83d6ffd700afa.tar.gz?commit=8f4738f41df7d876195449fb7ea83d6ffd700afa"
  version "8.3.0"
  sha256 "af4e1eeabae1bfa72b93cea6fe23de40693259f42a997c713a1ade9cd1a74560"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "472b61db2f4f8baf1c5beaaa7f472f0cc5d95c2f7a8cb5e4e49304fd21346516"
    sha256 cellar: :any,                 arm64_big_sur:  "35bbbd0267df53d1b01b1435e98f71299a4886bfe919572b025c51c6d2ad2c48"
    sha256 cellar: :any,                 ventura:        "968213dfa2b968ca903433cd3b334f412f3696a7ee90e6f4e325765c0e046bbc"
    sha256 cellar: :any,                 monterey:       "996956af97756723e1e0bb51da6fb01a5a16c14283cdd5af5dd8a89172e7c31b"
    sha256 cellar: :any,                 big_sur:        "03881c9070fb5e9f7259eba3aea8d968753fd6c8dbaaa08eadf1dc98a0c03ab9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9909e84d3f18a62f7e68986541937270bb2805ec2c517b3b08369d990d44332e"
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
