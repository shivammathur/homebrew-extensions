# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT85 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5ebf8c05befe19ac87a21730272f4488f94e8ed5304d5d1798a2eb954221e48c"
    sha256 cellar: :any,                 arm64_sonoma:  "75916aa624fc99f90b41e36f67f9140fa4c8c6d31a545d345d14773db62632d7"
    sha256 cellar: :any,                 arm64_ventura: "7c7e691fa1ba1c0be575b870b8a4cf7d33bcdf777f91faf1dceac84fe304c929"
    sha256 cellar: :any,                 ventura:       "85e604bbc6ddd0c587144121717b384114cf00b7a61348bf2474c5481895b27a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84ab213a30af3d0fd280f04a2de2c0e9cf2a825c0b1479ba297e6f5aca345f2b"
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
