# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT80 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "9e550b119da915910302b57444b91f07a8477a5331ea27a46d0286d177dc27b8"
    sha256 cellar: :any,                 arm64_ventura:  "bb7c3a88c3ef3c7f5fdf52b4150ad61481e3a3a2b79efdc93eb20809f533392f"
    sha256 cellar: :any,                 arm64_monterey: "b335169ce521fd8fbf712fd3fd520bb00e96ea22374ad5c3465f61757ba5930c"
    sha256 cellar: :any,                 arm64_big_sur:  "8e0172f3fdad71436262082bce0e6d90002d5379d8df184a05bf8bcdd692a102"
    sha256 cellar: :any,                 ventura:        "1ca91dedebe6730037746ccc10d1cbe3c80048dde91ea3792be676bc2b27fe70"
    sha256 cellar: :any,                 monterey:       "0b6de361754d77a0e224bfe76b8c2638ee27cb4ac6b601f71d2a7b9869edf050"
    sha256 cellar: :any,                 big_sur:        "f6d3a04caec628191dfebd4df1e6415babb575a58ba3038bb8746ad7d15534ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f443b3c32ef7fa7f33ea7225da7edfe1abb4ac7384d291bfed903ecf081e31e5"
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
