# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT83 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "46e8e0c68b62d90001fbd0a3ff7cbd9fdef76abb79f7de2b25fa669b6d39ce4a"
    sha256 cellar: :any,                 arm64_ventura:  "2a014e709ed7a2bc7a0061dee253d5732e63e58d6aedad63886a1c6e26f00072"
    sha256 cellar: :any,                 arm64_monterey: "fbc64a6d05aa6f17c4fddc34f55d91073d3cbb2b45b0e1e980e629f39340e147"
    sha256 cellar: :any,                 arm64_big_sur:  "136f77a8bbc2c74a2f3696a81f43cb626fd1129a5babc69f30f14c36d07656d6"
    sha256 cellar: :any,                 ventura:        "f160f6fbf964a508df299d07d45eff6edab1633cb92f3ae768bff3ef803f17da"
    sha256 cellar: :any,                 monterey:       "ea7b3da5f6b60ff6460d551b45036363f7913bf85d932222cae6053dc374f283"
    sha256 cellar: :any,                 big_sur:        "013adf4a854447a9f16aab02a9c4b6e5f90458e303bef6a7ea573a9e06052ad1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26ac832ee535070b9ba1c81039918649bcd644adbeb3a33dfaab5dbd44fdd7f7"
  end

  def uuid_dependency
    if OS.linux?
      "util-linux"
    else
      "e2fsprogs"
    end
  end

  on_macos do
    depends_on "e2fsprogs"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --with-uuid=#{Formula[uuid_dependency].opt_prefix}
    ]
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
