# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.tgz"
  sha256 "988b52e0315bb5ed725050cb02de89b541034b7be6b94623dcb2baa33f811d87"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "962126fe4be9b52ee0b48681f39d978abc3be3cf4cc02a7d3a5a96f2fa90a2d9"
    sha256 cellar: :any,                 arm64_big_sur:  "f4982261271aa978db2ac96b3226d73e1c73c8da613a438587489bd8f18839ba"
    sha256 cellar: :any,                 ventura:        "057ab4d811b7d86ba1974ed2511ebb790c1c91a7c6cd920820e491e88d91e595"
    sha256 cellar: :any,                 monterey:       "07f36c62955bf21e97cb9a52e30588b266c4f52e0a03a601e73921a9f2f845a2"
    sha256 cellar: :any,                 big_sur:        "e074ce894a7d79ffd817c53321dffee766d3bd3850b8f43678b3fb622d7456a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09843405e802247fdb09a41ca41ed1f5ed48aaf33de1e822438ae8f01be01412"
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
