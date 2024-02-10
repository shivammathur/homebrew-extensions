# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "59f910df7477d0667e40909b88c0f4490a235671596d906561b8d236a52af309"
    sha256 cellar: :any,                 arm64_ventura:  "a3543003aa07274f75aa796c0820c24dfa21a0815c01bde0ce338d63d048130c"
    sha256 cellar: :any,                 arm64_monterey: "7cee51bbd12401a9ac9d090224b5136ee85eeb513deeccb52ddc5d63c1937e15"
    sha256 cellar: :any,                 ventura:        "0e821023d43ea21715c1e01211ae88ec478e95d40a5cdf4aedea9bae1b0cd673"
    sha256 cellar: :any,                 monterey:       "a293266e80e1886c2f10c0d527a414ec6286bccb3fe02bf5a99cc2b632dda402"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8c54ff8a096ce820aa4fc4c04c4bfc67a0c251cfe73e8f730a0070c137000ef"
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
