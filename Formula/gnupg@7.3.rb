# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "c054db298fa77ef88df3796085a411e520d3d02627a4aa3329fc34594073c523"
    sha256 cellar: :any,                 big_sur:       "92a9d9bf6f58871c1299e385b8d64356ebd7e5ac2b585cf1cd28ea44c5cbc069"
    sha256 cellar: :any,                 catalina:      "b9844d73cdabc613934c91c744924cfed7af31638e10d3649e5a225f67b5dd0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af93f447443e4e0710fbc822195bb20ad0eb3f7fca231dbbdc2a77918ed3d627"
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
