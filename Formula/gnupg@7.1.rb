# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "76e69503df4a90815799a6722861ac745b5d074d8d92f154a559d5565d7152e8"
    sha256 cellar: :any,                 big_sur:       "2118ed8b6d9d705c6ac8111bfb37cbd362c9537ddb9a17c22decf92e637af539"
    sha256 cellar: :any,                 catalina:      "1de36d1e0e468e95097bcbd9c138132c89139b1d16904152d5ff24cd04ac9fd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "def2fbd8d30f409d5a0d454775e2e5d4a5c28a824d84a0a371d9c7b8a5f29ccd"
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
