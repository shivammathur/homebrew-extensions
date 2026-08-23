# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.0.tgz"
  sha256 "927caeda88334a33934d17b7d3b70ff46e0649e577f1339dc711bdb853290345"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "23e400e8756cc0d895be7ce08a7fcf9d57f644b04ad8bae170ccace97a677446"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "39d8bcad4754af26422ab73c37919d1a95bbb3793a59dd9f42785508bb7a7dba"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d9f9dbacf48d903bccd5944dee0d006307583a01412f9dba1f05e31a54a53820"
    sha256 cellar: :any_skip_relocation, sonoma:        "c5bf446c01a327d1ab53f8135649d0a8c06105ca89bb14fd0286776f5c9f5a06"
    sha256 cellar: :any,                 arm64_linux:   "4d57afd9ceaab9f29917c98b3ebc7543437ae45fee5927e33019a8e9069a386f"
    sha256 cellar: :any,                 x86_64_linux:  "0ac9b41d6e3758f9486934412ef4d1bf616dd193939b872ea08600c700be64a1"
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
