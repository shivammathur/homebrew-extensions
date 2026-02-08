# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT83 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "94fecb47d67dc1a4447dcbcc5563bf719febe96144dc5029b6c9c2edac2d9792"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d960da440ab04cddfa6c920b75509e386a3a868bf47a30233808f128751e8077"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2b27d8b35a0e571f1beedefcfe206175e75e31a7333565d895d3f61a8363f48e"
    sha256 cellar: :any_skip_relocation, sonoma:        "81abc5302f829e6d2a249de609301d57973a37bbf3f558fe823fd690727383e3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2603804e17cf1093b1822d08bf24510b034fd1dbf2c6c032f4c6a5aa32167944"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cd6bc1382c81b04d9933dcb3016fcc3dc271c0554a71dd41904e27e7a8e1e2e4"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
