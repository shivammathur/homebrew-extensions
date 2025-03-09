# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.0.tgz"
  sha256 "7b8622bf7df5385e159dde3f41ed91bc6798726d8d725a46db8ba884651664d0"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0ac6f439f6cc105fed12b5c31dd34b26ce43893a5c2029d5b1584d2049b99703"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "999634ba81376a96f3868476a04819799c85318814312038a622cf73a5ae0b35"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6fa3ca9226eca0c653cefb14f80b1322890659a92d61167ae24acdc70ff30daa"
    sha256 cellar: :any_skip_relocation, ventura:       "6206a8d7fcb66a423c9b4cc10506ac91fe67c328c937e07a426a9dfdb9143303"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db4db1d0f8eed54a3e2550a0b09badbb5e0f8300c7f8219eb7f51a381b972f83"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
