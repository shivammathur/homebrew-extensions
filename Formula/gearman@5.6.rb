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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/gearman@5.6-1.1.2"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "dbe5d65df33760588f5e279dd5e3dc3a478563a08e570ecea5acc4e44e94c7a1"
    sha256 cellar: :any,                 arm64_big_sur:  "93ba63e7a8f920921b75b4feadb7eed186e8aff2402890a7a299d4743dd57c7a"
    sha256 cellar: :any,                 monterey:       "87660f66027f335299de714c035a041d8f7e9b5497aaaf904eee01e4371271c8"
    sha256 cellar: :any,                 big_sur:        "d97011db38e6134b74cb0203e4b8af185544ea9c9fc8381021760a08889837ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "11282e3798f6884f3e8cd319693183d7d88b1ee740a801e1054f9986eb724cfd"
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
