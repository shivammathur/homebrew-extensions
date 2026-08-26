# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.2.tgz"
  sha256 "d16b250a1efe85b7083125731a5f664ac6bc16114e09da5f63fac085769cc48d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9ad129411fcfd887824b70900d9338f64576374d41a5c3b154bd4fb303ccf2bc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "065461a7b05f8ac4343a0e7a78583bbf8d570f78ece81acaf7de397b15cbdf47"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2ba6f105927b0715558bfb0942eb5da50323afa58175d740155cb27df2a9a808"
    sha256 cellar: :any_skip_relocation, sonoma:        "685eeae222276d00b2f842ab85af9f0784ab5759284a086f6609854b000036f1"
    sha256 cellar: :any,                 arm64_linux:   "3a2579dc5a42b5d6196d1df646923955fc0d4d64f12c4565d10164c071cd2240"
    sha256 cellar: :any,                 x86_64_linux:  "cab4dc34bdaca5547c94e1099b2204ee0c2d819a9b5943ae2a1225c7308b2324"
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
