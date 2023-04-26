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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "7995f81dde6308236dd49fada7fbd6a3b31456c5922a2d116309bfef70d00cca"
    sha256 cellar: :any,                 arm64_big_sur:  "ce0cf5e80a3bf09ee899460d2e83fe952c933fa92c117aa9b14962888b72aa88"
    sha256 cellar: :any,                 ventura:        "9122750f28d9f9b833c6819507a713bf04b38541174f13a86f9f75f5f9ab29fc"
    sha256 cellar: :any,                 monterey:       "34aba2a96bcd90514f75ae65ae4c9d572e2ba22fd83c4f7ab8a3acc2f938d11f"
    sha256 cellar: :any,                 big_sur:        "38734d25bba972d42d9581ae0fb2470829faeeab27e485dda641855d8c2d4956"
    sha256 cellar: :any,                 catalina:       "bc9ca005d1417015c2956ca51eadd5641924bb28ed55a62089194297d8f753db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "128e72de8df2bcb298fbd346075f4476ef95f59a7a5a8b2772b716a753f946ac"
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
