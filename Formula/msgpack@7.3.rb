# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "fdc18c36ef7e214cf1c9169f13503b3720b2390eb659f431ec654565df6a52b6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f269f92bc0d8ca8612ea06f7de554978dab7694970c605bfb27559769ed7452f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e257ad913ecd03d149c99cf2f6f75b70865a9c152ac92cb5d471293a28867f05"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ff144079e62532b37fc368c6a0424901c2591d605cfd3d4d9d03d74d6fb6ef83"
    sha256 cellar: :any_skip_relocation, ventura:        "0f50a0a3d7b3f8182ea925c33c1ec3dd648a45d9f43b68b6650faff9c7c02dd7"
    sha256 cellar: :any_skip_relocation, monterey:       "8e983aeaff49e5ad5be0e7ae7d5aad5221a47369fc0c148eb3c6a7d25444d4dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d922b185e978a6121c8abedc8d9d067fe8f6f9d0a687527ca53efa2956cea286"
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
