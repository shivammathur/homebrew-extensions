# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "17055caff5a82cdeeabd06c5e9b678f0afdf7aec1c16670c584d5a41514bac8b"
    sha256 cellar: :any,                 big_sur:       "b228fcf4bc393c7568c2f5125ce11cca0b42dab9676b72d05710ac83415ca895"
    sha256 cellar: :any,                 catalina:      "8cfaf4dba764aee815e81eb5e751ce24c21a59d49d4fab7934822f8f2806a637"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c9ac81f097cc7e6714131ed42b4e18e6273af4d033c0bbc0bd5089f924e1116"
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
