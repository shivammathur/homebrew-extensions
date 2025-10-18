# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class Xdebug2AT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.8.tar.gz"
  sha256 "28f8de8e6491f51ac9f551a221275360458a01c7690c42b23b9a0d2e6429eff4"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "e249a25090006497feca4a421db71ea5e85f51bc2ce2ead8b9bfdd5576408396"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "474df28652b10fdc5ad8aa4456220c3387b2f9432a39c7b96227830fde9c5d85"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "63d43e420777aa9362fb04dccd7108ac5e2312a0248dc649fc1740d8a17606d2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b7a780f4925f7ec3becafd5bedd6e56256aab21d1ace4330158775aa90be0f58"
    sha256 cellar: :any_skip_relocation, ventura:        "497287c0fd2c3baf8749c02f7261a452cae439580f7b87d3d9d1e076cd101cd5"
    sha256 cellar: :any_skip_relocation, big_sur:        "cad5e99bd3b9b35c9bfd9c2325630a1e7f34f40f74eadaa1f0f0fcfa445db77f"
    sha256 cellar: :any_skip_relocation, catalina:       "bdae44ba3d4b4ce595efc702599e2aa5ef690e109886f6c966f138b9f8bc105c"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "7e0184cee3d203c270c4116afce1bab2f15e6069040329940881b283b817a60e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6fdbe89bd5ac04639ba437472057cb3bdfb4eebe086a8409a6abb45af65624d4"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
