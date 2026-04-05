# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.0.tgz"
  sha256 "2d2a62007b7391b7c9464c0247f2e8e1a431ad1718f9bb316cf4343423faaae9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9be596107a51a2e3907834ee2d82454096e151b59e1f0895834dbe63a4834cf2"
    sha256 cellar: :any,                 arm64_sequoia: "b9d045dea5c385d54b7cd3f6de9b6c686ca7d865981ea44812af5cc8a5349b5a"
    sha256 cellar: :any,                 arm64_sonoma:  "5c4abdf6e7e709ab2c0772d36568b3bee5243ae2302e9a070bf50d47cb462be9"
    sha256 cellar: :any,                 sonoma:        "1edcddfefacac6ad93ddc96e59b85aa2c67fc6bd5f84eae461bb1e11b24e641b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "55a63a5565060a5a0a6c5640b0a3d92fa97a37f10828e4593b72c0229e247da5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26ce389548ee261972a2a682c99144a22d3d62704afa94983e4c969cfd49c1a2"
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
