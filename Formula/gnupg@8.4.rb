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
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "7bd7d1d42c093cc12953577e591dc0552aaa8a559c93a96e9b27e1db0090c4c3"
    sha256 cellar: :any,                 arm64_ventura:  "6e17883801f224ee5d7347c07d7e75cac10370471262686c266e424e9deffa45"
    sha256 cellar: :any,                 arm64_monterey: "b65c1bc81ac557d84c7db9ceebb1a1b4f618eb93dd1825f887b39c65b5a1d530"
    sha256 cellar: :any,                 ventura:        "888d9103eb85b6dce96a5775749201adf40f8c1539c88bdacac506b3865a25bd"
    sha256 cellar: :any,                 monterey:       "25b3c9649245c67f7943cbdeda4a9510b192f7f3862f9c5d1ee31ea85d993f3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8edff226abf4f62e357c86557ac708133809d4752beb9cc2e86ebadff103f5cf"
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
