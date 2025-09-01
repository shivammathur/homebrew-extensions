# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "da86c041f8b5580ee5700c9b121613d55b2dd160b9bae6d491f953e7e34c8e36"
    sha256 cellar: :any,                 arm64_sonoma:  "597457f9e7cca109d8d35ca8707c3d56f95bf815a2dd9c3a317549162d7ff286"
    sha256 cellar: :any,                 arm64_ventura: "3da6d4b7fa2a1721139557bb2a9f594651b39b3a8e331a8b6a4ecfc52f2af837"
    sha256 cellar: :any,                 ventura:       "9527658b92e793fa548f07c512825f14c4c463de1a430f07302514ef54d78caa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3f06f698244f3717f90d5831ae9e26f715143a29677369cebf80d257e79b725f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a32813af6c01eef856730a13089c5e18a8aed33be9c917f98da25346ec1db1d"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
