# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "efb0165550864e71b4b15541a99412d3425392716a7f31811a9f2635ea04ae3a"
    sha256 cellar: :any,                 big_sur:       "f534d9c4da9577da315d6ba81cfea06223856511b120a75d3ef61083a79c9054"
    sha256 cellar: :any,                 catalina:      "9c7fb38f3c6b4d2d0c424a8e1b66e97a12b5c79642381445b962018b158518fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ee7fe3ce7b3802b18d69f07a990133d04ea8bfda52f868000bfa39d250e002c"
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
