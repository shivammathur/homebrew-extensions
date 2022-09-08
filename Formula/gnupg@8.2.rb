# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT82 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "cdb76d035e8348f0147ed13c63048d547ca4c5e2174475f6f4a2c8ef942b0113"
    sha256 cellar: :any,                 arm64_big_sur:  "3eadf1cbd7c3dff153b4d54f86d5f38234a24436c6e9a926dd6133b8a131f4a0"
    sha256 cellar: :any,                 monterey:       "1f34475486274a6d4c53d1889a139fa8d5c02bff5881258d61dde0dab9cd7b4b"
    sha256 cellar: :any,                 big_sur:        "a5e2ff3124bf9638b4769bf957c9ea2497909a30c403817a8dc0657ccbba1965"
    sha256 cellar: :any,                 catalina:       "888b35ea1a041ec4afa29965e77f8c61ba564b75dcfb423ed071c8e7a085c971"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8beb403b2c78b585d5f13fa107e570713be4adea8abf0c7f85e8d89bc294dde8"
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
