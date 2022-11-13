# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT56 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "dbe5d65df33760588f5e279dd5e3dc3a478563a08e570ecea5acc4e44e94c7a1"
    sha256 cellar: :any,                 arm64_big_sur:  "93ba63e7a8f920921b75b4feadb7eed186e8aff2402890a7a299d4743dd57c7a"
    sha256 cellar: :any,                 monterey:       "787c7e39f2b4dd061091b378a6da9a8b18db1983906ca7e7a9015b8da5e43fee"
    sha256 cellar: :any,                 big_sur:        "d97011db38e6134b74cb0203e4b8af185544ea9c9fc8381021760a08889837ec"
    sha256 cellar: :any,                 catalina:       "60d56475554dae1cb7717608b108106d84e93f503e3f1b86a965b10ddce3c3f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cfffd299dca1efbb91eae4d95a334c30e1361ba974a706a86bc1e370cc808a6f"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
