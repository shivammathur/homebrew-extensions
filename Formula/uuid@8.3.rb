# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT83 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "65b1475a489414f9c87d123b092e98915ee833820d8f0987a2d1f85d13d98071"
    sha256 cellar: :any,                 arm64_big_sur:  "6eabe12ffdba996f98116fe30d4967c77fc9104f5e8a96fb9e504965913e1d96"
    sha256 cellar: :any,                 monterey:       "4f34598db73f02f3905a98ba367c04fc7514f23dc475b757625a038fd532a4ab"
    sha256 cellar: :any,                 big_sur:        "90f29375a25e2dea9e3c141a4a62fbb328d607f78a28696dca927e26946e3dd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c7e63546f7818f08696b2f105a06c2d81f9a31efb83a194a0a4ebbf88690fd45"
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
