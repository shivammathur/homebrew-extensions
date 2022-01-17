# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "d83ee85604c574458d093808018f6037c542c8e34391efce86fb8060599ee159"
    sha256 cellar: :any,                 big_sur:       "8558480652263dae072654e0736f5eb82bb0600f08cafab775a9487a7612871c"
    sha256 cellar: :any,                 catalina:      "d4047aa913cef4425573c0afd1811c8d419565ece386fa816afeeb4002a0ebbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30980c313ecf9e7482cf8b6f28f50a4b56975c71e575d7636d60c2c77db51666"
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
