# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "cecb50994fa7356bf3e57d96ead18d4644788c6eaa19ec714f742516d3d5ea26"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "180f1bfdc6f5e892f8f46bc9deb2fef67a6e14013e91238f6c6b9867cbcee9fd"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "61c5b41acb995397891a3a5df8b86a3c72e4d1ec12cd6827bae2ec06ca1aa2de"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ee0ee3f8ca0eaf64cef8245397954dbbe033d8c199007a85b93eb0237e21a49"
    sha256 cellar: :any_skip_relocation, ventura:        "e7e51a81e44d27ba2d154b3aa9ec3f9be4939dcb1d5db8c997d6b81aebf28c44"
    sha256 cellar: :any_skip_relocation, monterey:       "05eff6062e5a059eaefd8a6c4d3cbbf6a7201fe03a37e51f1099635f90f720e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6dea601060cc747211614d885a77ea368ea20173c7d71338c32276b578dc8037"
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
