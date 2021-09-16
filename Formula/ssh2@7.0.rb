# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "66b3fa2a6b5fcfec02c4b395d5e0d06a000e033badb19deb3289168c185e911d"
    sha256 cellar: :any,                 big_sur:       "8b1a92076a8f567d22d893f0325df142b4b6988a1cb49dacf747aa87ab79d87f"
    sha256 cellar: :any,                 catalina:      "83f809d74e9d8b995da57b10810258b941f3d5204a45263720add53ae57ca3a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9b99ae11aac971786fe648cbdf8de5f2853bfa3b6e1c136ef869fc61fca772e"
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
