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
    sha256 cellar: :any,                 arm64_monterey: "24834ccef3e6d3cb7976720b5e58ce13cba280713c93be2d521196ae72674706"
    sha256 cellar: :any,                 arm64_big_sur:  "079568301cf3c1e1477e98782435d1929be4e5a35f84430d5d634526a360780b"
    sha256 cellar: :any,                 monterey:       "3dc74c8277e698fa2aeebc00860929cf67ea08faf1df179826fe991487c7e370"
    sha256 cellar: :any,                 big_sur:        "312742a8cc18bd1873a3f5f0fef2da30f5279e6818d7af112db3251cae2f1519"
    sha256 cellar: :any,                 catalina:       "2facba1cb4f1aecf9c3f4ecffd6994b6bf0c1ed592d792e6f447d4e9cea0dbad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9696240a907f3d17c3cfe142039b2daa667b980b7434916ce2833518dbd5e2d"
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
