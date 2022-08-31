# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT83 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c4ef64c3ae44ba9a7e562c3a177860398b0719d6b8e107714614d74b5fccd9bd"
    sha256 cellar: :any,                 arm64_big_sur:  "6fc4878bdef2b098eb6772749ffcd96cef7119bc779b49c9699138286962b1f1"
    sha256 cellar: :any,                 monterey:       "51e0f7f6f208b5c0c918b033fefe22a2cbf54cd94d4a3bb01f514e04afbb9ada"
    sha256 cellar: :any,                 big_sur:        "a26352774b57bc5af3dbead8f1d5c2cf21b8736ca45fb8d6837ef662707cbe02"
    sha256 cellar: :any,                 catalina:       "b7f130c513119180c006ca5e252d024047fccbb077f9b4e1bfb336c32858c10a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6816002b5cf111e8dc6ed9391c99b0398e2b65dc30dbb3dac3b06c31fca31921"
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
