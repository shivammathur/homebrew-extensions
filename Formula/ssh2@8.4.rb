# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "3ab5ad40ac2e2431a26a87c0fd39507d24d1f19f3e0c2a3c152543b833cf3089"
    sha256 cellar: :any,                 arm64_monterey: "2ef1fde77fef26637acdac29003a16854dcf8c938ac41f59fb01e629cfff55fd"
    sha256 cellar: :any,                 arm64_big_sur:  "f5acb77b13aff4da3711747edb1c6c79cbe73e4621f8cb2a240b8a7e169bdaaa"
    sha256 cellar: :any,                 ventura:        "a97a2af2d82f14a20322341db672bdaeea05ebd9af4013f11278203f1f604356"
    sha256 cellar: :any,                 monterey:       "8ad5e70552acb5e37819eb5b39ec491df82980cf98f8bc69e3b78874a44bef4e"
    sha256 cellar: :any,                 big_sur:        "f137e8244df740c5d4e99f1fc901ab2f9e539a26a5524c61d4a9b29e433d47ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "17846aa4090ebb3ef1e0d722151be2a6f8c4c39a3e02e7483f2a0d96aa32cb0f"
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
