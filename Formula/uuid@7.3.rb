# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT73 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "477f61bf949ac2963e59a0cc6795c43b87a19eda8312d08544f427a91e49c799"
    sha256 cellar: :any,                 arm64_ventura:  "17a54e58d4501cc6600117900d784d473852b8846c4f9c4651c4da7ab850a55e"
    sha256 cellar: :any,                 arm64_monterey: "e6379987241d8f96237d824cf77b52b550d58c859dfbe6517c21615d298b390b"
    sha256 cellar: :any,                 arm64_big_sur:  "fb5ba2a59b5d0c49fb75c8b5ed9bb0906cfea152a3f22cf19372356a722c2665"
    sha256 cellar: :any,                 ventura:        "27a1081e538d4ee8c2a4049f90802606953d79a245c30c0405bf78702630c75e"
    sha256 cellar: :any,                 monterey:       "8947f4358c66901a8aca9139888ba6e0510d8b783f64260f46ec81e88f944056"
    sha256 cellar: :any,                 big_sur:        "3c9f717063ddc223d91bcd912f996c1f57f11e5c90fc940528d2948f5f737443"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50e3a1fe60c31ce341c28ab257b2c22ab42e9f09c48104a89f169b2716a8bcf0"
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
