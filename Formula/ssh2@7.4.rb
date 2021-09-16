# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "b2de49a2ce5c2fd066f6c29e317e6be7c52fdb484f6880fc26f9b5fd52fdcf9c"
    sha256 cellar: :any,                 big_sur:       "3f6e2e15c67e7ddb3cca76b45448420d4e078e559310f538d0e332072cd9e472"
    sha256 cellar: :any,                 catalina:      "91dbe7b415e2a3c69dd430b04cff0be13d12eeb725b2bc099a0ba24418a3fa9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a3cbb20b20a8f951e5dc5c7257699dd72bf161091b13718ce989e84a180a476"
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
