# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "5b919bb5535d977f567f18bd4330cb84cb8fde75df2ed33bbcfd028b9308f784"
    sha256 cellar: :any,                 arm64_sequoia: "4c7397a21ae95336cfe1fa97ae2178e48edb479ffc86d0c5feb5c9b857cd4f21"
    sha256 cellar: :any,                 arm64_sonoma:  "182137031f732ada759686192739a1cc61829db224d56a75b446dd879c03e037"
    sha256 cellar: :any,                 sonoma:        "45ff2a225e5db821dfd16c0ee6d27e8fb3bde668fadd1e67c7d789c4cd6a9c9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1d9d294123a28115acb685fae3fe17fc732061e0893c6d0540d633dfce523e22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a69163c3c53d83beff93b49b79422f51d6f5676a64c53a5f135c4ded5119fc2c"
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
