# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT81 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.3.1.tgz"
  sha256 "9093a1f8d24dc65836027b0e239c50de8d5eaebf8396bc3331fdd38c5d69afd9"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "bdd425563374ed0f6a1767906aca56dbce64a67ff3fc79ad4a6853de76efceb4"
    sha256 cellar: :any,                 big_sur:       "d7c0c7e4555bafa5e810705fb2f4b49a70fcf74dc6eefd3e493c5608d8613b63"
    sha256 cellar: :any,                 catalina:      "225484d4b44729f29a476c5b132f8993b8283571adaab3a2962de7b879e966d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3720965232e87177a96da76044b11e96cb71009bd63454e263ea64c2af56fc07"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
