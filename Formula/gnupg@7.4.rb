# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT74 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "ce786e3646356a9b957a9d08e3a5c4964be4621948fe00602a109ef848a1d049"
    sha256 cellar: :any,                 big_sur:       "de85329c3ba6dfff3d40cc70f535fec90184eee60b1bfcd3e94216ae1f3995cd"
    sha256 cellar: :any,                 catalina:      "8935f0a9becd1439eaed00938afb9b7fff55b8d7dd7fa08af801b7f99fbb2b88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91135f2f0aee73eed5ece48e89ad60ed2e4899b5904b108877f103161842393c"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
