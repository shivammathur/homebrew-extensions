# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT84 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "3b25c89788d4d5c4ebd58c2c3458529fd780480323bb68164e14239846abf4eb"
    sha256 cellar: :any,                 arm64_monterey: "522b153f180e69604e6f8d87728607d9ddc75f87f1b5d1a15f63f40e33450b20"
    sha256 cellar: :any,                 arm64_big_sur:  "1dcd615fc0e08b555b4a97dca1f368b627ffbeae6de208fc8eb96151889f83a4"
    sha256 cellar: :any,                 ventura:        "f82b49ed5c9bea0b061f5355e6408d8836d1c43f96cc47bd6ee154056e57cc66"
    sha256 cellar: :any,                 monterey:       "ab068847740b73dcf5296a330de94222d5835354047ca7179b0260eff9387487"
    sha256 cellar: :any,                 big_sur:        "c39504620197275a46a74e66db8b5e78f8b10bd308e570c2863a1feff52c2730"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3e32c17c9f6ff1be607fc8d1477a774294f3bb1306c63f63afaa105c8db13b8"
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
