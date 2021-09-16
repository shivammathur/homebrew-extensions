# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "e6fd2daee60c60a3b34f5b8132a733e71b9b30c0bc142f4f327fa7c19c1d0888"
    sha256 cellar: :any,                 big_sur:       "7792f96535093adaf2d9ae383b5b7626d92d191c0c0ddb7b496339a9a426084f"
    sha256 cellar: :any,                 catalina:      "4b7d25d4d5b071fb229913bdf63f0ab5f413d55382eda790b2807e27b5575595"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2bb82801473be4dd62eeb4fb9b3c392d3f0e08409e802cba275c031e09e9b7d"
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
