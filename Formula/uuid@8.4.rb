# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT84 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "afc8657037ce601f9f40fb44f7678ecd34d39d45fafef94cd10a0806d594e58a"
    sha256 cellar: :any,                 arm64_sonoma:  "3684106b3f9f388058e01317ffbff3264e4b871e8f9e85578fc81ba5941ce83c"
    sha256 cellar: :any,                 arm64_ventura: "d3ab221d345dc260dcf88915070213df87f58b75ec9bf2b0c4365e71d50df0a0"
    sha256 cellar: :any,                 ventura:       "dcc3e9945ebe665aaf497698f34f8ad7d960be14b696acc3c15f4fbe0b840273"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "515ecf7198587685f2ccce1ffbc69f4d2e2904c6d9f0c12478191fda3d8723dd"
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
