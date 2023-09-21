# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "adfe1e519d5cdbebde4d9c957d6cb3c7b43fb55be1370f4b73aa03f0f3a8d7c0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "200bd16c96f590c0b28a1ae1606ba8aa78042c0c9f7780227bfc6cbeb3119770"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3c77365217061065395d65a4ef147f031efb05a24a8de878cfc646768e1bf369"
    sha256 cellar: :any_skip_relocation, ventura:        "c6ab235868e298132bd54f0c96dea843ae33c681b644e2c719897dcb70d05686"
    sha256 cellar: :any_skip_relocation, monterey:       "ade57de102d73aaba97ae75761d114d721a52e632e706249ef46668bfc5e3c73"
    sha256 cellar: :any_skip_relocation, big_sur:        "3d46746816aa9436fcd94d3a34226c8a2b75033d1f21738fccec7bb38f13ef96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14a4f5c0ebd9b91948e1c0c480e276ec18e76acdd10949012da9d8d7b197958c"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
